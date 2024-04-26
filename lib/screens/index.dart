// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todo/components/Forms.dart';
import 'package:todo/components/MyAppBar.dart';
import 'package:todo/components/TaskItem.dart';
import 'package:todo/model/Task.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final Map<String, Task> tasksList = {
    '1': Task(
      id: 1,
      todoTitle: 'Morning ExerciseMorning ExerciseMorning ExerciseMorning',
      todoDescription: 'Do Morning exercise at 6:00am',
      isDone: false,
    ),
    '2': Task(
      id: 2,
      todoTitle: 'Complete Work Report',
      todoDescription: 'Finish the weekly work report',
      isDone: true,
    ),
    '3': Task(
      id: 3,
      todoTitle: 'Call Mom',
      todoDescription: "Call mom to wish her happy birthday",
      isDone: true,
    ),
    '4': Task(
      id: 4,
      todoTitle: 'Go for a Run',
      todoDescription: "Run in the park for 30 minutes",
      isDone: false,
    ),
    '5': Task(
      id: 5,
      todoTitle: 'Buy Groceries',
      todoDescription: "Buy vegetables, fruits, and bread",
      isDone: false,
    ),
    '6': Task(
      id: 6,
      todoTitle: 'Read a Book',
      todoDescription: "Read a chapter of 'To Kill a Mockingbird'",
      isDone: false,
    ),
  };

  String filter = "All";
  bool Error = false;
  late List<Task> tasksListFilter;
  TextEditingController t = TextEditingController();
  TextEditingController d = TextEditingController();

  void addtask() {
    setState(() {
      String title = t.text.trim();
      String description = d.text.trim();

      if (title.isEmpty || description.isEmpty) {
        Error = true;
      } else {
        var ultimoID = tasksList.isNotEmpty ? tasksList.values.last.id : 0;
        int siguienteID = ultimoID + 1;
        var newValue = Task(
          id: siguienteID,
          todoTitle: title,
          todoDescription: description,
          isDone: false,
        );
        tasksList['$siguienteID'] = newValue;
        Navigator.pop(context);

        Error = false;
        t.clear();
        d.clear();
      }
    });
  }

  void deleteTask(int id) {
    tasksList.remove(id.toString());
    setState(() {});
  }

  void changeStatus(int id) {
    if (tasksList.containsKey(id.toString())) {
      Task task = tasksList[id.toString()]!;
      task.isDone = !task.isDone;
      setState(() {});
    }
  }

  void ChangeFilter(value) {
    setState(() {
      filter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (filter == "Complete") {
      tasksListFilter = tasksList.values.where((task) => task.isDone).toList();
    } else if (filter == "Pending") {
      tasksListFilter = tasksList.values.where((task) => !task.isDone).toList();
    } else {
      tasksListFilter = tasksList.values.toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: const MyAppBar(
        title: "All Tasks",
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Filtros
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ChangeFilter("All");
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "All",
                      style: TextStyle(
                        color: filter == "All" ? Colors.blue.shade700 : null,
                        fontWeight: filter == "All" ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    ChangeFilter("Complete");
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Complete",
                      style: TextStyle(
                        color:
                            filter == "Complete" ? Colors.blue.shade700 : null,
                        fontWeight:
                            filter == "Complete" ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ChangeFilter("Pending");
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Pending",
                      style: TextStyle(
                        color:
                            filter == "Pending" ? Colors.blue.shade700 : null,
                        fontWeight:
                            filter == "Pending" ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ToDo List Title

            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 10),
              child: const Text(
                "All To Dos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0), // Ajusta el valor según sea necesario
                child: ListView(
                  shrinkWrap: true,
                  children: tasksListFilter.reversed.map((task) {
                    return TaskItem(
                      task: task,
                      deleteTask: deleteTask,
                      changeStatus: changeStatus,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            builder: (BuildContext context) {
              return ReusableForm(
                onPressed: addtask,
                title: t,
                description: d,
              );
            },
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.blue.shade700,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
