import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:two_fa/app.dart';
import 'package:two_fa/core/services/initial_service.dart';

void main() async {
  runApp(
    UncontrolledProviderScope(
      container: await initialService(),
      child: App(),
    ),
  );
}