import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class Alarm {
  final TimeOfDay time;
  final String label;
  final List<bool> repeatDays; // 7 booleans for Mon-Sun
  final String? soundPath; // Path to the selected alarm sound
  bool isActive;

  Alarm({
    required this.time,
    this.label = "",
    required this.repeatDays,
    this.soundPath,
    this.isActive = true,
  });
}

class AlarmViewModel extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  List<Alarm> get alarms => List.unmodifiable(_alarms);

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    notifyListeners();
  }

  void removeAlarm(Alarm alarm) {
    _alarms.remove(alarm);
    notifyListeners();
  }

  void toggleAlarm(Alarm alarm, bool isActive) {
    final index = _alarms.indexOf(alarm);
    if (index != -1) {
      _alarms[index].isActive = isActive;
      notifyListeners();
    }
  }


  String getAlarmDayLabel(Alarm alarm) {
    final now = DateTime.now();
    final alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      alarm.time.hour,
      alarm.time.minute,
    );

    if (alarm.repeatDays.every((day) => !day)) {
      // One-time alarm
      return alarmDateTime.isAfter(now) ? "Today" : "Tomorrow";
    }

    if (alarm.repeatDays.every((day) => day)) {
      // Repeats every day
      return "Everyday";
    }

    // For custom repeat days, no specific label
    return "";
  }
}


final alarmProvider = ChangeNotifierProvider((ref) => AlarmViewModel());
