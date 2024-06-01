import 'dart:convert';
import 'package:flutter_application_2/models/task.dart';
import 'package:http/http.dart' as http;

const String apiUrl =
    'https://dars3ux-default-rtdb.firebaseio.com/contacts.json';

class ContactsController {
  List<Contact> contacts = [];

  Future<void> fetchContacts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        contacts = data.entries.map((entry) {
          return Contact(
            id: entry.key,
            name: entry.value['name'],
            task: entry.value['task'],
          );
        }).toList();
      }
    } catch (error) {
      print('Failed to fetch contacts: $error');
    }
  }

  Future<void> addContact(String name, String task) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'task': task}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String newContactId = responseData['name'];
        contacts.add(Contact(id: newContactId, name: name, task: task));
      }
    } catch (error) {
      print('Failed to add contact: $error');
    }
  }

  Future<void> editContact(int index, String name, String task) async {
    final contactId = contacts[index].id;
    try {
      final response = await http.patch(
        Uri.parse(
            'https://dars3ux-default-rtdb.firebaseio.com/contacts/$contactId.json'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'task': task}),
      );
      if (response.statusCode == 200) {
        contacts[index].name = name;
        contacts[index].task = task;
      }
    } catch (error) {
      print('Failed to edit contact: $error');
    }
  }

  Future<void> deleteContact(int index) async {
    final contactId = contacts[index].id;
    try {
      final response = await http.delete(
        Uri.parse(
            'https://dars3ux-default-rtdb.firebaseio.com/contacts/$contactId.json'),
      );
      if (response.statusCode == 200) {
        contacts.removeAt(index);
      }
    } catch (error) {
      print('Failed to delete contact: $error');
    }
  }
}
