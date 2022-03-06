import 'package:flutter/material.dart';
import 'package:mow/mow.dart';
import 'package:practica_flutter/done_settings.dart';
import 'package:practica_flutter_domain/practica_flutter_domain.dart';

class DoneOptionsWidget extends MOWWidget<DoneSettings> {
  DoneOptionsWidget({required DoneSettings model}) : super(model: model);

  @override
  MOWState<DoneSettings, DoneOptionsWidget> createState() =>
      _DoneOptionsState();
}

class _DoneOptionsState extends MOWState<DoneSettings, DoneOptionsWidget> {
  late BuildContext? _ctxt;

  @override
  Widget build(BuildContext context) {
    _ctxt = context;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ToggleButtons(
        children: [
          _button("Nothing"),
          _button("GreyOut"),
          _button("Delete", destructive: true),
        ],
        isSelected: model.toList(),
        direction: Axis.vertical,
        onPressed: _tapHandler,
      ),
    );
  }

  void _tapHandler(int index) async {
    DoneOptions opt = DoneOptions.values[index];

    if (DoneSettings.shared[opt] == false) {
      DoneSettings.shared[opt] = true;
    } else {
      DoneSettings.shared[opt] = false;
    }

    if (opt == DoneOptions.delete) {
      final shouldDelete = await showDialog<bool>(
        barrierDismissible: false,
        context: _ctxt!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Should all "done" task be deleted?'),
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
        //llamar al metodo del repo que borra todas las tareas DONE.
        TaskRepository.shared.removeAll();
      }
    }
  }

  Widget _button(String caption, {bool destructive = false}) {
    if (!destructive) {
      return Text(caption);
    } else {
      return Row(
        children: [
          const Icon(
            Icons.dangerous,
            size: 15,
            color: Colors.red,
          ),
          Text(caption)
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }
  }
}
