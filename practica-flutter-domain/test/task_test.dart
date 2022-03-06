import 'dart:math';

import 'package:practica_flutter_domain/src/task.dart';
import 'package:test/test.dart';

void main() {
  group('Task', () {
    test('Creation', () {
      expect(InmutableTask(description: 'test'), isNotNull);
      expect(Task(description: 'comprar', state: TaskState.toDo), isNotNull);
    });
  });

  group('Equality', () {
    test('Identical Objects', () {
      final compra = InmutableTask(description: 'comprar pan');
      expect(compra == compra, isTrue);
    });

    test('Equivalent objects must be equal', () {
      expect(
        InmutableTask(description: 'description'),
        InmutableTask(description: 'description'),
      );
    });

    test('Non equivalent Objects', () {
      expect(
          Task.toDo(description: 'learn dart') !=
              Task.done(description: 'learn dart'),
          isTrue);
    });
  });
}
