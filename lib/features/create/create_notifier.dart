import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:two_fa/core/providers/supabase_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // ← important!

part 'create_notifier.g.dart';

@riverpod
class CreateNotifier extends _$CreateNotifier {
  @override
  Future<Option<AccountCreateStatus>> build() async {
    return none();
  }

  Future<void> createAccount({required String userId, required String email, required String password}) async {
    state = AsyncLoading();
    await Future.delayed(Durations.extralong3);
    final supabase = ref.watch(supabaseProvider).client;

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'user_id': userId, 'pending_2fa': true},
      );

      /** Check Already Exist */
      if (response.user!.identities == null || response.user!.identities!.isEmpty) {
        debugPrint('create failed: user already exist');
        state = AsyncError(
          some(AccountCreateStatus(success: false, message: 'User already exist.')),
          StackTrace.current,
        );
        return;
      }

      if (response.user != null) {
        debugPrint('create successful: ${response.user!.email}');
        state = AsyncData(some(AccountCreateStatus(success: true, message: 'Account created successfully.')));
      } else {
        debugPrint('create failed: ${response.user!.email}');
        state = AsyncError(
          some(AccountCreateStatus(success: false, message: 'Account creation failed.')),
          StackTrace.current,
        );
      }
    } on AuthException catch (error) {
      state = AsyncError(some(AccountCreateStatus(success: false, message: error.message)), StackTrace.current);

      debugPrint('Authentication error: ${error.message}');
    } catch (error) {
      state = AsyncError(some(AccountCreateStatus(success: false, message: error.toString())), StackTrace.current);

      debugPrint('Unexpected error: $error');
    }
  }
}

class AccountCreateStatus {
  final bool success;
  final String message;

  AccountCreateStatus({required this.success, required this.message});
}
