import 'package:flutter/material.dart';

class ContactAddDialog extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: taskController,
            decoration: InputDecoration(labelText: 'Task'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop({
              'name': nameController.text,
              'task': taskController.text,
            });
          },
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}