import 'package:flutter/foundation.dart';
import '../models/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  final Uuid _uuid = const Uuid();

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(String title) {
    final task = Task(id: _uuid.v4(), title: title);
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isDone = !_tasks[index].isDone;
      notifyListeners();
    }
  }

  void updateTask(String id, String newTitle) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].title = newTitle;
      notifyListeners();
    }
  }
}
