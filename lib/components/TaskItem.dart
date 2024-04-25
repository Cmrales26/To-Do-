import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TaskItem extends StatelessWidget {
  final Map<String, dynamic> task;
  final Function(dynamic) deleteTask;
  final Function(dynamic) changeStatus;

  const TaskItem({
    super.key,
    required this.task,
    required this.deleteTask,
    required this.changeStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Checkbox(
            value: task["isDone"] as bool? ?? false,
            onChanged: (value) {
              changeStatus(task["id"]);
            },
            fillColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.blue.shade700;
              }
              return Colors.white;
            }),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/details',
                        arguments: task,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "${task["todoTitle"]}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: task["isDone"]
                              ? Colors.grey
                              : null, // Si está hecho, establece el color en gris
                          decoration: task["isDone"]
                              ? TextDecoration.lineThrough
                              : null, // Si está hecho, agrega una línea a través del texto
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    deleteTask(task["id"]);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
