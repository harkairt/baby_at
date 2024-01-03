import 'package:app/modules/time_entries/baby_event.dart';
import 'package:flutter/material.dart';

class BabyEventRow extends StatelessWidget {
  const BabyEventRow({
    required this.event,
    required this.onDelete,
    super.key,
  });

  final BabyEvent event;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: event.type.icon,
      title: Text(_formatTime(event.date)),
      subtitle: Text(
        _formatDate(event.date),
        style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
      ),
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Törlés?'),
            action: SnackBarAction(
              label: 'Igen',
              onPressed: () {
                onDelete();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      },
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
