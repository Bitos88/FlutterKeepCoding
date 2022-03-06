import 'package:mow/mow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:flutter/material.dart';

const _kDoneOptNothing = "Nothing";
const _kDoneOptGreyOut = "GreyOut";
const _kDoneOptDelete = "Delete";

enum DoneOptions { nothing, greyOut, delete }

class DoneSettings with Updatable {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  DoneSettings._hidden() {
    _load();
  }
  static final DoneSettings shared = DoneSettings._hidden();

  final Map<DoneOptions, bool> _settings = {
    DoneOptions.nothing: true,
    DoneOptions.greyOut: false,
    DoneOptions.delete: false
  };

  bool operator [](DoneOptions option) {
    return _settings[option]!;
  }

  void operator []=(DoneOptions option, bool newValue) {
    if (newValue != _settings[option]) {
      _setAllFalse();

      _settings[option] = newValue;

      if (_areAllFalse()) {
        _settings[DoneOptions.nothing] = true;
      }

      changeState(() {
        _commit();
      });
    }
  }

  List<bool> toList() {
    return [
      _settings[DoneOptions.nothing]!,
      _settings[DoneOptions.greyOut]!,
      _settings[DoneOptions.delete]!
    ];
  }

  bool _areAllFalse() {
    return _settings[DoneOptions.nothing]! == false &&
        _settings[DoneOptions.greyOut]! == false &&
        _settings[DoneOptions.delete]! == false;
  }

  void _setAllFalse() {
    _settings[DoneOptions.nothing] = false;
    _settings[DoneOptions.greyOut] = false;
    _settings[DoneOptions.delete] = false;
  }

  Future<void> _commit() async {
    //Guarda
    final prefs = await _prefs;

    await prefs.setBool(_kDoneOptNothing, _settings[DoneOptions.nothing]!);
    await prefs.setBool(_kDoneOptGreyOut, _settings[DoneOptions.greyOut]!);
    await prefs.setBool(_kDoneOptDelete, _settings[DoneOptions.delete]!);
  }

  Future<void> _load() async {
    final prefs = await _prefs;

    changeState(() {
      _settings[DoneOptions.nothing] = prefs.getBool(_kDoneOptNothing) ?? true;
      _settings[DoneOptions.greyOut] = prefs.getBool(_kDoneOptGreyOut) ?? false;
      _settings[DoneOptions.delete] = prefs.getBool(_kDoneOptDelete) ?? false;
    });
  }
}
