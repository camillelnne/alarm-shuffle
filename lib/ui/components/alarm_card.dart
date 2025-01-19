import "package:alarm_shuffle/viewmodels/alarm_viewmodel.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class AlarmCard extends ConsumerWidget {
  final Alarm alarm;

  const AlarmCard({required this.alarm, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Alarm Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarm.time.format(context),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                if (alarm.label.isNotEmpty)
                  Text(
                    alarm.label,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
              ],
            ),

            // Toggle and More Actions
            Row(
              children: [
            // Toggle Switch
              Switch(
                value: alarm.isActive,
                onChanged: (value) {
                  // Toggle the alarm's active state using the AlarmViewModel
                  ref.read(alarmProvider).toggleAlarm(alarm, value);
                },
              ),

                // Dropdown/Expand Button (Optional)
                IconButton(
                  icon: const Icon(Icons.expand_more),
                  onPressed: () {
                    // Open details or edit screen
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
