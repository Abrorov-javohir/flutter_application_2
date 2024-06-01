import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/task.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ContactItem({
    Key? key,
    required this.contact,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name),
      subtitle: Text(contact.task),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}