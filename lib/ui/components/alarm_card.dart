import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class AlarmCard extends ConsumerWidget {
  final DateTime alarmTime;
  final bool isActive;

  const AlarmCard({
    required this.alarmTime,
    this.isActive = true,
    super.key,
  });

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
                  "${alarmTime.hour.toString().padLeft(2, '0')}:${alarmTime.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isActive ? "Active" : "Inactive",
                  style: TextStyle(
                    fontSize: 14,
                    color: isActive ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),

            // Toggle and More Actions
            Row(
              children: [
                // Toggle Switch
                Switch(
                  value: isActive,
                  onChanged: (value) {
                    //TODO
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
