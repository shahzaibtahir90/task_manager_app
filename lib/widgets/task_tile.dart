import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_task_screen.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: task.isDone ? Colors.green[50] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => Provider.of<TaskProvider>(context, listen: false)
              .toggleTask(task.id),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration:
                task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => Provider.of<TaskProvider>(context, listen: false)
                  .deleteTask(task.id),
            ),
          ],
        ),
      ),
    );
  }


}
