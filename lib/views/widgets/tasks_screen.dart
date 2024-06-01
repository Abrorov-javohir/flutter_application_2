import 'package:flutter/material.dart';
import 'package:flutter_application_2/controller/task_controller.dart';
import 'package:flutter_application_2/models/task.dart';
import 'package:flutter_application_2/views/widgets/listItem.dart';
import 'package:flutter_application_2/views/widgets/list_add.dart';
import 'package:flutter_application_2/views/widgets/task_edit.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final contactsController = ContactsController();

  @override
  void initState() {
    super.initState();
    contactsController.fetchContacts().then((_) {
      setState(() {});
    });
  }

  void onDelete(int index) {
    contactsController.deleteContact(index).then((_) {
      setState(() {});
    });
  }

  void onEdit(Contact contact, int index) async {
    Map<String, dynamic>? data = await showDialog(
      context: context,
      builder: (ctx) {
        return ContactEditDialog(contact: contact);
      },
    );

    if (data != null && data['name'] != null && data['task'] != null) {
      contactsController
          .editContact(index, data['name'], data['task'])
          .then((_) {
        setState(() {});
      });
    }
  }

  void onAdd() async {
    Map<String, dynamic>? data = await showDialog(
      context: context,
      builder: (ctx) {
        return ContactAddDialog();
      },
    );

    if (data != null && data['name'] != null && data['task'] != null) {
      contactsController.addContact(data['name'], data['task']).then((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: onAdd,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contactsController.contacts.length,
        itemBuilder: (ctx, index) {
          final contact = contactsController.contacts[index];
          return ContactItem(
            contact: contact,
            onDelete: () => onDelete(index),
            onEdit: () => onEdit(contact, index),
          );
        },
      ),
    );
  }
}
