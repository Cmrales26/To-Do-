// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo/components/MyAppBar.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      final int id = arguments['id'];
      final String todoTitle = arguments['todoTitle'];
      final String todoDescription = arguments['todoDescription'];
      final bool isDone = arguments['isDone'];

      return Scaffold(
        backgroundColor: const Color(0xFFEEEFF5),
        appBar: const MyAppBar(
          title: "Details",
          centerTitle: false,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todoTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Task id:$id',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                  // Agregar un text que diga Complete or peding depenst of the value of idDone
                  Text(
                    isDone ? 'Complete' : 'Pending',
                    style: TextStyle(
                      fontSize: 15,
                      color: isDone ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Task Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(todoDescription),
                  ],
                ),
              )
              // Text('ID: $id'),,
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        backgroundColor: Color(0xFFEEEFF5),
        appBar: MyAppBar(
          title: "Error",
          centerTitle: false,
        ),
        body: Center(
          child: Text('No data provided to display.'),
        ),
      );
    }
  }
}
