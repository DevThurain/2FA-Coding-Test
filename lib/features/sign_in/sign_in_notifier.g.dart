// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInNotifierHash() => r'b8080ce0fc8c735a351b471ad85929eba7f66194';

/// See also [SignInNotifier].
@ProviderFor(SignInNotifier)
final signInNotifierProvider = AutoDisposeAsyncNotifierProvider<
  SignInNotifier,
  Option<AccountSignInStatus>
>.internal(
  SignInNotifier.new,
  name: r'signInNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$signInNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SignInNotifier =
    AutoDisposeAsyncNotifier<Option<AccountSignInStatus>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
