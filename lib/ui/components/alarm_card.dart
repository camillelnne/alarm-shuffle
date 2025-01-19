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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alarm Time and Label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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

                // Toggle and Delete Actions
                Row(
                  children: [
                    // Toggle Switch
                    Switch(
                      value: alarm.isActive,
                      onChanged: (value) {
                        ref.read(alarmProvider).toggleAlarm(alarm, value);
                      },
                    ),

                    // Delete Button
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: "Delete Alarm",
                      onPressed: () {
                        // Show confirmation dialog before deletion
                        _showDeleteConfirmation(context, ref, alarm);
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Repeat Days or Text (Everyday/Tomorrow)
            Row(
              children: _buildRepeatDays(alarm.repeatDays),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to show a delete confirmation dialog
  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, Alarm alarm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Alarm"),
          content: const Text("Are you sure you want to delete this alarm?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                ref.read(alarmProvider).removeAlarm(alarm); // Delete the alarm
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Helper function to build the repeat days row
  List<Widget> _buildRepeatDays(List<bool> repeatDays) {
    if (repeatDays.every((day) => day)) {
      return [
        const Text(
          "Everyday",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ];
    }

    if (repeatDays.every((day) => !day)) {
      return [
        const Text(
          "Tomorrow",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
        ),
      ];
    }

    const dayLabels = ["M", "T", "W", "T", "F", "S", "S"];
    return List.generate(7, (index) {
      final isSelected = repeatDays[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          dayLabels[index],
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ),
      );
    });
  }
}
