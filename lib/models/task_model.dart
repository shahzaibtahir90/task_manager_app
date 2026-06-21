class Task {
  final String id;
  String title;
  bool isDone;

  Task({required this.id, required this.title, this.isDone = false});

  // Copy with helper
  Task copyWith({String? title, bool? isDone}) {
    return Task(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
