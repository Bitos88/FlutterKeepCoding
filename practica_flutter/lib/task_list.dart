import 'package:flutter/material.dart';
import 'package:mow/mow.dart';
import 'package:practica_flutter/done_settings.dart';
import 'package:practica_flutter/task_widget.dart';
import 'package:practica_flutter_domain/practica_flutter_domain.dart';
import 'package:practica_flutter/toDoDrawer.dart';

class TaskListModel extends ModelPair<TaskRepository, DoneSettings> {
  TaskListModel(TaskRepository repo, DoneSettings settings)
      : super(repo, settings);
}

class TaskListPage extends MOWWidget<TaskListModel> {
  TaskListPage()
      : super(model: TaskListModel(TaskRepository.shared, DoneSettings.shared));

  @override
  MOWState<TaskListModel, TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends MOWState<TaskListModel, TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ToDoDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: _newTask,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.pinkAccent,
        title: const Text("App FLutter"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/LiquidBG.jpeg"), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return TaskWidget(TaskRepository.shared[index]);
          },
          itemCount: TaskRepository.shared.length,
        ),
      ),
    );
  }

  void _newTask() {
    TaskRepository.shared.add(Task.toDo(description: "New task added"));
  }
}
