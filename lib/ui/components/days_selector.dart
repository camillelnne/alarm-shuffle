import "package:flutter/material.dart";

class DaysSelector extends StatelessWidget {
  final List<bool> repeatDays;
  final void Function(int index, bool isSelected) onDayToggle;

  const DaysSelector({
    required this.repeatDays,
    required this.onDayToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const dayLabels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Wrap(
      spacing: 8,
      children: List.generate(7, (index) {
        final isSelected = repeatDays[index];
        return ChoiceChip(
          label: Text(dayLabels[index]),
          selected: isSelected,
          onSelected: (selected) {
            onDayToggle(index, selected); // Notify parent of the toggle
          },
          showCheckmark: false,
        );
      }),
    );
  }
}
