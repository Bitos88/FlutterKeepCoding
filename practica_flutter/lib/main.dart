import 'package:flutter/material.dart';
import 'package:practica_flutter/done_settings.dart';
import 'package:practica_flutter/settings.dart';
import 'package:practica_flutter/task_list.dart';
import 'package:practica_flutter_domain/practica_flutter_domain.dart';

void main() {
  //_loadCaches();
  if (kDEBUG == true) {
    TaskRepository.shared.addTestData(amount: 120);
  }
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Flutter App",
      home: TaskListPage(),
    );
  }
}

void _loadCaches() {
  final s = DoneSettings.shared;
}
