import 'package:updatable/updatable.dart';

class InmutableTask {
  late String _description;

  //ACCESSORS

  //FORMA LARGA

  // String get description {
  //   return _description;
  // }

  //FORMA CORTA - Getter y Setter
  String get description => _description;

  set description(String newValue) {
    if (newValue != _description) {
      _description = newValue;
    }
  }

  //CONSTRUCTORS(el init)

  InmutableTask({required String description}) : _description = description;

  //OVERRIDES

  @override
  String toString() {
    return '<$runtimeType: $description>';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else {
      return other is InmutableTask && _description == description;
    }
  }

  @override
  int get hashCode => description.hashCode;
}

//ENUM

enum TaskState { toDo, doing, done }

//SUBCLASS

class Task extends InmutableTask with Updatable {
  late TaskState _state;

  TaskState get state => _state;

  set state(TaskState newValue) {
    if (newValue != _state) {
      changeState(() {
        _state = newValue;
      });
    }
  }

  Task({required String description, required TaskState state})
      : _state = state,
        super(description: description);

  //NAMED CONSTRUCTORS
  Task.toDo({required String description})
      : _state = TaskState.toDo,
        super(description: description);

  Task.done({required String description})
      : _state = TaskState.done,
        super(description: description);

  //OVERRIDES

  @override
  String toString() {
    return '<$runtimeType: $state, $description>';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else {
      return other is Task &&
          state == other._state &&
          _description == other.description;
    }
  }

  @override
  //int get hashCode => description.hashCode ^ state.hashCode;
  int get hashCode => Object.hashAll([description, state]);
}
