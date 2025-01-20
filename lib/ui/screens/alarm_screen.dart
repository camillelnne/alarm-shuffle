import "package:alarm_shuffle/ui/components/alarm_card.dart";
import "package:alarm_shuffle/ui/components/new_alarm.dart";
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
        onPressed: () {
          showNewAlarmOverlay(context, ref);
        },
        tooltip: "Add Alarm",
        child: const Icon(Icons.add),
      ),

    );
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
  final List<Alarm> alarms; // Now expects a list of Alarm objects

  const _AlarmList({required this.alarms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: alarms.length,
      itemBuilder: (context, index) {
        final alarm = alarms[index]; // Each item is an Alarm object
        return AlarmCard(alarm: alarm); // Pass the Alarm object to AlarmCard
      },
    );
  }
}


