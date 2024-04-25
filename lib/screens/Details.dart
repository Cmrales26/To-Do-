// ignore_for_file: file_names

import 'package:flutter/material.dart';

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
      final int id = arguments['id'] as int;
      final String todoTitle = arguments['todoTitle'] as String;
      final String todoDescription = arguments['todoDescription'] as String;
      final bool isDone = arguments['isDone'] as bool;

      return Scaffold(
        backgroundColor: const Color(0xFFEEEFF5),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          title: const Text("Details"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
      return Scaffold(
        backgroundColor: const Color(0xFFEEEFF5),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text('No se han proporcionado datos para mostrar.'),
        ),
      );
    }
  }
}
