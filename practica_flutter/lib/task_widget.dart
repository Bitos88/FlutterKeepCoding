import 'package:flutter/material.dart';
import 'package:practica_flutter/done_settings.dart';
import 'package:practica_flutter_domain/practica_flutter_domain.dart';
import 'package:mow/mow.dart';
import 'package:practica_flutter/detail_task.dart';

class TaskWidget extends MOWWidget<Task> {
  TaskWidget(Task task) : super(model: task);

  @override
  MOWState<Task, TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends MOWState<Task, TaskWidget> {
  @override
  Widget build(BuildContext context) {
    // return Dismissible(
    //   background: DismissibleBackground(),
    //   secondaryBackground: DismissibleBackground(
    //     align: MainAxisAlignment.end,
    //   ),
    //   onDismissed: (direction) {
    //     TaskRepository.shared.remove(model);
    //   },
    //   key: UniqueKey(),
    return Container(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/cellBG.png"), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 2)),
          width: 300,
          child: Dismissible(
            background: DismissibleBackground(),
            secondaryBackground: DismissibleBackground(
              align: MainAxisAlignment.end,
            ),
            onDismissed: (direction) {
              TaskRepository.shared.remove(model);
            },
            key: UniqueKey(),
            child: ListTile(
              onTap: () async {
                final task = await Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => DetailTask(
                      model: model,
                    ),
                  ),
                );
                setState(() {});
              },
              leading: Checkbox(
                  fillColor: MaterialStateProperty.all(Colors.pink),
                  checkColor: Colors.white,
                  activeColor: Colors.pink,
                  value: model.state == TaskState.done,
                  onChanged: (bool? newValue) {
                    if (newValue != null) {
                      if (newValue == true) {
                        model.state = TaskState.done;
                      } else {
                        model.state = TaskState.toDo;
                      }
                    }
                  }),
              title: _descriptionWidget(model.description),
              textColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _descriptionWidget(String text) {
    TextStyle? style;

    if (DoneSettings.shared[DoneOptions.greyOut] &&
        model.state == TaskState.done) {
      style = TextStyle(fontStyle: FontStyle.italic, color: Colors.grey);
    }
    return Text(
      text,
      style: style,
    );
  }
}

class DismissibleBackground extends StatelessWidget {
  late final String _text;
  late final Color _color;
  late final MainAxisAlignment _alignment;

  DismissibleBackground(
      {Key? key,
      String text = "Delete",
      Color color = Colors.red,
      MainAxisAlignment align = MainAxisAlignment.start})
      : _color = color,
        _text = text,
        _alignment = align,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: _color),
      //color: _color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.delete, color: Colors.white60),
            Text(
              _text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5.0,
              height: 5.0,
            )
          ],
          mainAxisAlignment: _alignment,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
