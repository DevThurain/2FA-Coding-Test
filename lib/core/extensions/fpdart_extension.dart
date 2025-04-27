import 'package:fpdart/fpdart.dart';

extension ForceSome<T> on Option<T> {
  T force() => getOrElse(() => throw Exception('Expected Some, got None'));
}
