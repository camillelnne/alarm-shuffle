import "package:alarm_shuffle/views/alarm_shuffle_app.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Run the app
  runApp(
    const ProviderScope(
      child: AlarmShuffleApp(),
    ),
  );
}
