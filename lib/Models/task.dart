// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  String name;
  bool isCompleted;

  Task({
    required this.name,
    this.isCompleted = false,
  });
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'isCompleted': isCompleted,
    };
  }
}
