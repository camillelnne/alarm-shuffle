import "package:alarm_shuffle/ui/components/days_selector.dart";
import "package:alarm_shuffle/viewmodels/alarm_viewmodel.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

/// Function to show the new alarm form as a modal bottom sheet.
void showNewAlarmOverlay(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return const NewAlarmForm(); // Displays the NewAlarmForm
    },
  );
}

/// Stateful widget for creating a new alarm.
class NewAlarmForm extends ConsumerStatefulWidget {
  const NewAlarmForm({super.key});

  @override
  ConsumerState<NewAlarmForm> createState() => _NewAlarmFormState();
}

class _NewAlarmFormState extends ConsumerState<NewAlarmForm> {
  TimeOfDay? selectedTime;
  TextEditingController labelController = TextEditingController();
  List<bool> repeatDays = List.generate(7, (_) => false);
  String? selectedSound;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  "New Alarm",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Time Picker
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text(
                    selectedTime != null
                        ? "Time: ${selectedTime!.format(context)}"
                        : "Select Time",
                  ),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        selectedTime = time;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Label Input
                TextField(
                  controller: labelController,
                  decoration: const InputDecoration(
                    labelText: "Label",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Repeat Days
                const Text(
                  "Repeat Days",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                DaysSelector(
                  repeatDays: repeatDays,
                  onDayToggle: (index, isSelected) {
                    setState(() {
                      repeatDays[index] = isSelected;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Sound Picker (Placeholder)
                ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(selectedSound ?? "Choose Alarm Sound"),
                  onTap: () {
                    // TODO: Implement sound picker
                  },
                ),
                const SizedBox(height: 16),

                // Save Button
                ElevatedButton(
                  onPressed: () {
                    if (selectedTime != null) {
                      final newAlarm = Alarm(
                        time: selectedTime!,
                        label: labelController.text,
                        repeatDays: repeatDays,
                      );
                      ref.read(alarmProvider).addAlarm(newAlarm);
                      Navigator.pop(context); // Close the overlay
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a time")),
                      );
                    }
                  },
                  child: const Center(child: Text("Save Alarm")),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
