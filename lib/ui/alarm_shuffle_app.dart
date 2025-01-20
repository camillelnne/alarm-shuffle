import "package:alarm_shuffle/ui/screens/alarm_screen.dart";
import "package:flutter/material.dart";

class AlarmShuffleApp extends StatelessWidget {
  const AlarmShuffleApp({super.key});
  static const title = "Alarm Shuffle";
  static const color = Color.fromARGB(255, 52, 37, 168);



  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);

    return MaterialApp(
      title: title,
      theme: ThemeData(
        useMaterial3: true,
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
          brightness: brightness,
        ),
        
      ),
      
      home: const AlarmScreen(),
    );
  }
}
