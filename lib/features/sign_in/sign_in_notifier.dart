import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:two_fa/core/providers/supabase_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

part 'sign_in_notifier.g.dart';

@riverpod
class SignInNotifier extends _$SignInNotifier {
  @override
  Future<Option<AccountSignInStatus>> build() async {
    return none();
  }

  Future<void> loginAndSend2FAEmail(String email, String password) async {
    state = AsyncLoading();
    await Future.delayed(Durations.extralong3);
    final supabase = ref.watch(supabaseProvider).client;

    try {
      final response = await supabase.auth.signInWithPassword(email: email, password: password);

      final user = response.user;

      if (user != null) {
        await _send2FAEmail(email);
      } else {
        state = AsyncError(
          some(AccountSignInStatus(success: false, message: 'Account sign in failed.')),
          StackTrace.current,
        );
      }
    } on AuthException catch (e) {
      state = AsyncError(
        some(AccountSignInStatus(success: false, message: 'Account sign in failed. ${e.message}')),
        StackTrace.current,
      );
    } catch (e) {
      state = AsyncError(
        some(AccountSignInStatus(success: false, message: 'Account sign in failed. $e')),
        StackTrace.current,
      );
    }
  }

  Future<void> _send2FAEmail(String email) async {
    final url = Uri.parse('https://yfeajijnsshwnpeqculx.supabase.co/functions/v1/send-verification-code');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        state = AsyncData(some(AccountSignInStatus(success: true, message: '2FA email sent successfully.')));
      } else {
        state = AsyncError(
          some(AccountSignInStatus(success: false, message: 'Failed to send 2FA email.')),
          StackTrace.current,
        );
      }
    } catch (error) {
      state = AsyncError(
        some(AccountSignInStatus(success: false, message: 'Failed to send 2FA email. $error')),
        StackTrace.current,
      );
    }
  }
}

class AccountSignInStatus {
  final bool success;
  final String message;

  AccountSignInStatus({required this.success, required this.message});
}
