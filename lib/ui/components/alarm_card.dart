import "package:alarm_shuffle/ui/components/days_selector.dart";
import "package:alarm_shuffle/viewmodels/alarm_viewmodel.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class AlarmCard extends ConsumerStatefulWidget {
  final Alarm alarm;

  const AlarmCard({required this.alarm, super.key});

  @override
  AlarmCardState createState() => AlarmCardState();
}

class AlarmCardState extends ConsumerState<AlarmCard> {
  bool isExpanded = false; // Track whether the card is expanded
  late List<bool> editableRepeatDays; // Editable list of repeat days

  @override
  void initState() {
    super.initState();
    // Copy the initial repeat days to allow editing
    editableRepeatDays = List.from(widget.alarm.repeatDays);
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.alarm.isActive; // Track active/inactive state
    final textColor = isActive ? Colors.black : Colors.grey;

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
                      widget.alarm.time.format(context),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (widget.alarm.label.isNotEmpty)
                      Text(
                        widget.alarm.label,
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                  ],
                ),

                // Toggle and Expand Actions
                Row(
                  children: [
                    // Toggle Switch
                    Switch(
                      value: isActive,
                      onChanged: (value) {
                        ref.read(alarmProvider).toggleAlarm(widget.alarm, value);
                      },
                    ),

                    // Expand Button
                    IconButton(
                      icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: textColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Show Repeat Days or "Everyday/Tomorrow"
            Row(
              children: _buildRepeatDays(widget.alarm.repeatDays, isActive),
            ),

            // Expanded Section
            if (isExpanded) ...[
              const SizedBox(height: 16),

              // Editable Days Selector
              DaysSelector(
                repeatDays: editableRepeatDays,
                onDayToggle: (index, isSelected) {
                  setState(() {
                    editableRepeatDays[index] = isSelected;
                    widget.alarm.repeatDays[index] = isSelected; // Update alarm state
                  });
                },
              ),

              // Expanded Options (Delete Button)
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: "Delete Alarm",
                    onPressed: () {
                      _deleteAlarmWithUndo(context, ref);
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Function to handle delete with Snackbar
  void _deleteAlarmWithUndo(BuildContext context, WidgetRef ref) {
    final alarmProviderRef = ref.read(alarmProvider);
    alarmProviderRef.removeAlarm(widget.alarm); // Delete the alarm

    // Show Snackbar with Undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Alarm deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            // Undo delete by re-adding the alarm
            alarmProviderRef.addAlarm(widget.alarm);
          },
        ),
        duration: const Duration(seconds: 4), // Snackbar duration
      ),
    );
  }

  // Helper function to build the repeat days row
  List<Widget> _buildRepeatDays(List<bool> repeatDays, bool isActive) {
final label = ref.read(alarmProvider).getAlarmDayLabel(widget.alarm);

  if (label.isNotEmpty) {
    return [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.blue : Colors.grey,
        ),
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
            color: (isSelected && isActive) ? Colors.blue : Colors.grey,
          ),
        ),
      );
    });
  }
}
