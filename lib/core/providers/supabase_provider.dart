import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:two_fa/core/constants/api_constants.dart';

part 'supabase_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Supabase> supabaseAsync(Ref ref) async {
  return Supabase.initialize(
    url: ApiConstants.supabaseUrl,
    anonKey: ApiConstants.supabaseKey,
  );
}

@Riverpod(keepAlive: true)
Supabase supabase(Ref ref) {
  return ref.watch(supabaseAsyncProvider).requireValue;
}
