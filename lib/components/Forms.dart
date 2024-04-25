// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ReusableForm extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController title;
  final TextEditingController description;
  final String error;
  const ReusableForm({
    super.key,
    required this.onPressed,
    required this.title,
    required this.description,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 0),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Add New Task",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              error,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.red),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text("Task Title"),
                  ),
                  TextField(
                    controller: title,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      label: Text("Title"),
                      prefixIcon: Icon(Icons.create),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text("Task Description"),
                  ),
                  TextField(
                    controller: description,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      label: Text("Description"),
                      prefixIcon: Icon(Icons.info),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                minimumSize: const Size(40, 50),
              ),
              child: const Text(
                "Add New Task",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
