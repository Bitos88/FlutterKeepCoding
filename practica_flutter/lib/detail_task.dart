import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mow/mow.dart';
import 'package:practica_flutter/done_settings.dart';
import 'package:practica_flutter_domain/practica_flutter_domain.dart';

class DetailTask extends MOWWidget<Task> {
  DetailTask({Key? key, required Task model}) : super(key: key, model: model);

  @override
  MOWState<Task, DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends MOWState<Task, DetailTask> {
  final _controller = TextEditingController();

  var isSelected = [false];
  late BuildContext? _ctxt;
  var message = '';

  @override
  Widget build(BuildContext context) {
    _ctxt = context;
    if (model.state == TaskState.toDo) {
      isSelected = [false];
      message = 'Pending Task';
    } else {
      isSelected = [true];
      message = 'Finished Task';
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.pinkAccent,
        title: Text(model.description),
        leading: BackButton(
          onPressed: () => returnToCaller(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'describe your task',
                  labelText: 'Task:',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.task),
                  suffixIcon: _iconButton(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(message),
              ),
              ToggleButtons(
                children: const <Widget>[Icon(Icons.delete)],
                onPressed: (int index) {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                    if (model.state == TaskState.toDo) {
                      model.state = TaskState.done;
                      _showScaffoldMessage('Task change to DoneState');

                      if (DoneSettings.shared[DoneOptions.delete]) {
                        _alertDelete();
                      }
                    } else {
                      model.state = TaskState.toDo;
                      _showScaffoldMessage('Task change to TodoState');
                    }
                  });
                },
                isSelected: isSelected,
              )
            ],
          ),
        ),
      ),
    );
  }

  IconButton? _iconButton() {
    IconButton? icon;

    if (_controller.text.isEmpty) {
      icon = null;
    } else {
      icon = IconButton(
        onPressed: () {
          setState(() {
            _controller.clear();
          });
        },
        icon: Icon(Icons.clear),
      );
    }
    return icon;
  }

  @override
  void initState() {
    super.initState();
    _controller.text = model.description;

    _controller.addListener(_updateModel);
  }

  void _updateModel() {
    model.description = _controller.text;
  }

  @override
  void dispose() {
    _controller.removeListener(_updateModel);
    _controller.dispose();
    super.dispose();
  }

  void returnToCaller(BuildContext context) {
    Navigator.of(context).pop(context);
  }

  void _alertDelete() async {
    final shouldDelete = await showDialog<bool>(
      barrierDismissible: false,
      context: _ctxt!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: showTitle(),
          content: SingleChildScrollView(
            child: Text('Are you sure to delete all?'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('YES'),
            )
          ],
        );
      },
    );
    if (shouldDelete == true) {
      TaskRepository.shared.remove(model);
      Navigator.pop(context);
    }
  }

  Text showTitle() {
    if (model.state == TaskState.toDo) {
      return Text('Pending Task');
    } else {
      return Text('Finished Task');
    }
  }

  void _showScaffoldMessage(String message) {
    SnackBar snackMessage = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackMessage);
  }
}
