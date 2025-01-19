import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class AlarmViewModel extends ChangeNotifier {
  final List<DateTime> _alarms = []; // List to store alarms

  List<DateTime> get alarms => List.unmodifiable(_alarms); // Prevent external modification

  void addAlarm(DateTime alarmTime) {
    _alarms.add(alarmTime);
    notifyListeners(); // Notify UI listeners to rebuild
  }

  void removeAlarm(DateTime alarmTime) {
    _alarms.remove(alarmTime); // Remove the alarm
    notifyListeners();
  }

  void clearAlarms() {
    _alarms.clear(); // Clear all alarms
    notifyListeners();
  }
}

final alarmProvider = ChangeNotifierProvider((ref) => AlarmViewModel());
