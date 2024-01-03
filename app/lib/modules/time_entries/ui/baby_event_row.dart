import 'package:app/modules/time_entries/baby_event.dart';
import 'package:flutter/material.dart';

class BabyEventRow extends StatelessWidget {
  const BabyEventRow({
    required this.event,
    super.key,
  });

  final BabyEvent event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: event.type.icon,
      title: Text(_formatTime(event.date)),
      subtitle: Text(_formatDate(event.date)),
    );
  }
}

// A util function which formats DateTime's date part eg: 2023-02-11, ensuring that each value has two characters (so 02 instead of just 2)
String _formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

String _formatTime(DateTime date) {
  return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}
