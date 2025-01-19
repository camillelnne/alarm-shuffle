import "package:alarm_shuffle/viewmodels/alarm_viewmodel.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class AlarmScreen extends ConsumerWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmViewModel = ref.watch(alarmProvider); // Watch the AlarmViewModel

    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm Clock"),
        centerTitle: true,
      ),
      body: alarmViewModel.alarms.isEmpty
          ? Center(
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
            )
          : ListView.builder(
              itemCount: alarmViewModel.alarms.length,
              itemBuilder: (context, index) {
                final alarmTime = alarmViewModel.alarms[index];
                return ListTile(
                  title: Text(
                    "Alarm: ${alarmTime.hour}:${alarmTime.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ref.read(alarmProvider).removeAlarm(alarmTime);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a sample alarm for demonstration
          final now = DateTime.now();
          final sampleAlarm = DateTime(now.year, now.month, now.day, now.hour, now.minute + 1);
          ref.read(alarmProvider).addAlarm(sampleAlarm);
        },
        tooltip: "Add Alarm",
        child: const Icon(Icons.add),
      ),
    );
  }
}
