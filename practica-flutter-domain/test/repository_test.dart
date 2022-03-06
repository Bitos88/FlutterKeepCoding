import 'dart:math';

import 'package:practica_flutter_domain/src/taskRepository.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:practica_flutter_domain/src/task.dart';

void main() {
  late TaskRepository repo;
  late Task sampleTask;
  late Task sampleTask2;

  setUp(() {
    repo = TaskRepository.shared;
    sampleTask = Task.toDo(description: 'tarea 1');
    sampleTask2 = Task.done(description: 'tarea 2');
  });

  tearDown(() {
    repo.reset();
  });

  group('Creation & Accessors', () {
    test('empty repo', () {
      expect(TaskRepository.shared, isNotNull);
      expect(TaskRepository.shared.length, 0);
    });
  });

  group('mutators', () {
    test('Add to the begining', () {
      repo.add(sampleTask);
      expect(repo.length, 1);
      expect(repo[0], sampleTask);
    });

    test('InsertL adds correspond. index', () {
      expect(() => repo.insert(10, sampleTask2), throwsRangeError);
      expect(() => repo.insert(0, sampleTask2), returnsNormally);

      final newTask = Task.done(description: 'instert example');
      repo.insert(1, newTask);
      expect(repo[1], newTask);
    });

    test('Remove object if present', () {
      final task = Task.toDo(description: 'tarea borrado');
      final int oldSize = repo.length;
      repo.add(task);
      expect(repo.length, oldSize + 1);
      repo.remove(task);
      expect(repo.length, oldSize);
    });

    test('RemoveAt: object from index', () {
      expect(() => repo.removeAt(47), throwsRangeError);
      repo.add(sampleTask2);
      repo.removeAt(0);
      expect(repo.length, 0);
    });

    test('Move: objects between positions', () {
      repo.add(sampleTask);
      repo.add(sampleTask2);

      repo.move(0, 0);
      expect(repo[0], sampleTask2);
      expect(repo[1], sampleTask);

      expect(() => repo.move(42, -1), throwsRangeError);

      repo.move(0, 1);
      expect(repo.length, 2);
      expect(repo[1], sampleTask2);
    });
  });
}
