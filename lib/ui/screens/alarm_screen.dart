import "package:alarm_shuffle/ui/components/alarm_card.dart";
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
        title: const Text("Alarme"),
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
      padding: const EdgeInsets.all(8.0),
      itemCount: alarms.length,
      itemBuilder: (context, index) {
        final alarmTime = alarms[index];
        return AlarmCard(alarmTime: alarmTime);
      },
    );
  }
}

