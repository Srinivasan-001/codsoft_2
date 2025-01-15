import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool) onChanged;
  final VoidCallback onEdit;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Checkbox(
          value: taskCompleted,
          onChanged: (value) => onChanged(value!),
        ),
        title: Text(
          taskName,
          style: TextStyle(
            decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
