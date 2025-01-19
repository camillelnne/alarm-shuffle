import "package:flutter/material.dart";

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm Clock"),
        centerTitle: true,
      ),
      body: Center(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to the add alarm screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add Alarm button pressed")),
          );
        },
        tooltip: "Add Alarm",
        child: const Icon(Icons.add),
      ),
    );
  }
}
