import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';

part 'verify_notifier.g.dart';

@riverpod
class VerifyNotifier extends _$VerifyNotifier {
  @override
  Future<Option<AccountVerifyStatus>> build() async {
    return none();
  }

  Future<void> verify({required String email, required String otp}) async {
    state = AsyncLoading();
    await Future.delayed(Durations.extralong3);
    final url = Uri.parse('https://yfeajijnsshwnpeqculx.supabase.co/functions/v1/verify-code');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'otp': otp});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        state = AsyncData(some(AccountVerifyStatus(success: true, message: '2FA verified successfully!')));
      } else {
        state = AsyncError(
          some(AccountVerifyStatus(success: false, message: 'Failed to verify. ${response.body.toString()}')),
          StackTrace.current,
        );
      }
    } catch (error) {
      state = AsyncError(
        some(AccountVerifyStatus(success: false, message: 'Failed to verify. ${error.toString()}')),
        StackTrace.current,
      );
    }
  }
}

class AccountVerifyStatus {
  final bool success;
  final String message;

  AccountVerifyStatus({required this.success, required this.message});
}
