import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task.dart';

class ContactEditDialog extends StatelessWidget {
  final Contact contact;
  final TextEditingController nameController;
  final TextEditingController taskController;

  ContactEditDialog({required this.contact})
      : nameController = TextEditingController(text: contact.name),
        taskController = TextEditingController(text: contact.task);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Contact'),
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
          child: Text('Save'),
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