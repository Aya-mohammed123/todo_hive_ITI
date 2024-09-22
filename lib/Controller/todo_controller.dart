import '../Models/task.dart';
import '../Models/todo_model.dart';

class TodoController {
  List<TodoModel> tasks = [
    TodoModel(
      id: 1,
      time: '07:00 AM',
      description: [
        Task(name: '15 min work out (jogging)', isCompleted: true),
        Task(name: 'Cold shower', isCompleted: true),
        Task(name: 'Breakfast', isCompleted: false),
      ],
    ),
    TodoModel(
      id: 2,
      time: '08:00 PM',
      description: [
        Task(name: 'sport Time', isCompleted: false),
        Task(name: 'Coffee break', isCompleted: false),
      ],
    ),
    TodoModel(
      id: 3,
      time: '10:00 PM',
      description: [
        Task(name: 'work out', isCompleted: false),
      ],
    ),
  ];

  List<Task> getTodoModelForIndex(int index) {
    return tasks[index].description;
  }

  void addTodoList(TodoModel todoModel) {
    tasks.add(todoModel);
  }

  void deleteTodoGroup(int index) {
    tasks.removeAt(index);
  }

  void updateTodoGroup(int index, TodoModel updatedTodoModel) {
    tasks[index] = updatedTodoModel;
  }

  void updateTodoModel(TodoModel updatedTodo) {
    int index = tasks.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      tasks[index] = updatedTodo;
    }
  }
}
