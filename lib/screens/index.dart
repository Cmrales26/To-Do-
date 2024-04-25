// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todo/components/Forms.dart';
import 'package:todo/components/TaskItem.dart';
import 'package:todo/model/List.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  String filter = "All";
  String Error = "";
  late List<Map<String, dynamic>> tasksListFilter;
  TextEditingController t = TextEditingController();
  TextEditingController d = TextEditingController();

  void addtask() {
    setState(() {
      String title = t.text.trim();
      String description = d.text.trim();

      if (title.isEmpty || description.isEmpty) {
        Error = "Please enter both a title and description.";
        return;
      } else {
        // Si ambos campos no están vacíos, proceder con la adición de la tarea
        var ultimoID = tasksList.last["id"] as int;
        int siguienteID = ultimoID + 1;
        var newValue = {
          "id": siguienteID,
          "todoTitle": title,
          "todoDescription": description,
          "isDone": false,
        };
        tasksList.add(newValue);
        Navigator.pop(context);
        Error = "";
        t.clear();
        d.clear();
      }
    });
  }

  void deleteTask(id) {
    tasksList.removeWhere((task) => task["id"] == id);
    setState(() {});
  }

  void changeStatus(id) {
    var task = tasksList.firstWhere((task) => task["id"] == id);
    task["isDone"] = !(task["isDone"] as bool);

    setState(() {});
  }

  void ChangeFilter(value) {
    setState(() {
      filter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (filter == "Complete") {
      tasksListFilter =
          tasksList.where((task) => task["isDone"] == true).toList();
    } else if (filter == "Pending") {
      tasksListFilter =
          tasksList.where((task) => task["isDone"] == false).toList();
    } else {
      tasksListFilter = tasksList.toList();
    }
    return Scaffold(
      backgroundColor: const Color(0xFFEEEFF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 90,
        title: const Center(
          child: Text("All Tasks"),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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

            // TO DO LIST

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
            Expanded(
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
            )
          ],
        ),
      ),
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
                error: Error,
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
