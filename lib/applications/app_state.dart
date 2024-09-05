import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'enums.dart';

class AppState with ChangeNotifier {
  AppCurrentState _status = AppCurrentState.IsFree;
  LocalState _localStatus = LocalState.IsFree;

  void stateStatus(AppCurrentState status, [bool callNotify=true]) {
    _status = status;
    if (callNotify) notifyListeners();
  }
  void setLocalState(LocalState status, [bool callNotify=true]) {
    _localStatus = status;
    if (callNotify) notifyListeners();
  }

  getStateStatus() => _status;
  getLocalStatus() => _localStatus;
}
