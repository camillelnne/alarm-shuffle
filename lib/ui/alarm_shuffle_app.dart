import "package:alarm_shuffle/ui/widgets/alarm_screen.dart";
import "package:flutter/material.dart";

class AlarmShuffleApp extends StatelessWidget {
  const AlarmShuffleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Alarm Clock",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AlarmScreen(),
    );
  }
}
