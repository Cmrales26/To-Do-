// ignore_for_file: file_names, non_constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ReusableForm extends StatefulWidget {
  final VoidCallback onPressed;
  final TextEditingController title;
  final TextEditingController description;
  const ReusableForm({
    super.key,
    required this.onPressed,
    required this.title,
    required this.description,
  });

  @override
  State<ReusableForm> createState() => _ReusableFormState();
}

class _ReusableFormState extends State<ReusableForm> {
  bool error = false;

  void HaldleSubmit() {
    if (widget.title.text.trim().isEmpty ||
        widget.description.text.trim().isEmpty) {
      setState(() {
        error = true;
      });
    } else {
      setState(() {
        error = false;
      });
      widget.onPressed();
    }
  }

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
                      child: const Column(
                        children: [
                          Center(
                            child: Text(
                              "Add New Task",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text("Task Title"),
                  ),
                  TextField(
                    controller: widget.title,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      label: const Text("Title"),
                      labelStyle:
                          TextStyle(color: error ? Colors.red : Colors.grey),
                      prefixIcon: const Icon(Icons.create),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: error ? Colors.red : Colors.grey,
                            width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: error ? Colors.red : Colors.grey),
                      ),
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
                    controller: widget.description,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      label: const Text("Description"),
                      labelStyle:
                          TextStyle(color: error ? Colors.red : Colors.grey),
                      prefixIcon: const Icon(Icons.info),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: error ? Colors.red : Colors.grey,
                            width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: error ? Colors.red : Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              // onPressed: widget.onPressed,
              onPressed: () {
                HaldleSubmit();
              },
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
