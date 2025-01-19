import "package:alarm_shuffle/viewmodels/alarm_viewmodel.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class AlarmScreen extends ConsumerWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmViewModel = ref.watch(alarmProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm Clock"),
        centerTitle: true,
      ),
      body: alarmViewModel.alarms.isEmpty
          ? const _EmptyState()
          : _AlarmList(alarms: alarmViewModel.alarms),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSampleAlarm(ref),
        tooltip: "Add Alarm",
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addSampleAlarm(WidgetRef ref) {
    final now = DateTime.now();
    final sampleAlarm = DateTime(now.year, now.month, now.day, now.hour, now.minute + 1);
    ref.read(alarmProvider).addAlarm(sampleAlarm);
  }
}

// Widget for the empty state
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.alarm,
            size: 100,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          const Text(
            "No alarms set yet!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(
            "Tap the + button to add a new alarm.",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// Widget for displaying the alarm list
class _AlarmList extends StatelessWidget {
  final List<DateTime> alarms;

  const _AlarmList({required this.alarms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0), // Add some padding around the list
      itemCount: alarms.length,
      itemBuilder: (context, index) {
        final alarmTime = alarms[index];
        return _AlarmCard(alarmTime: alarmTime);
      },
    );
  }
}

// Widget for a single alarm card
class _AlarmCard extends ConsumerWidget {
  final DateTime alarmTime;

  const _AlarmCard({required this.alarmTime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Spacing between cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Alarm Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alarm: ${alarmTime.hour}:${alarmTime.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Delete Button
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(alarmProvider).removeAlarm(alarmTime);
              },
            ),
          ],
        ),
      ),
    );
  }
}
