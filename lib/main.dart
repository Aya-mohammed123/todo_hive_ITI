import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../View/home_screen.dart';

import 'Models/task_adaptor.dart';
import 'Models/todo_adaptor.dart';
import 'Models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(TaskAdapter());
  }

  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(TodoAdaptor());
  }

  await Hive.openBox<TodoModel>("todoBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
