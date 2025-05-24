import 'dart:async';
import 'package:flutter/material.dart';
import 'package:more_timers_app/logic/time_data.dart';


class AppState extends ChangeNotifier {
  static const updateInterval = Duration(seconds: 1);
  final List<TimeData> entries = <TimeData>[];
  late Timer _timerUpdater;

  void addTimer(Duration duration) {
    entries.add(TimeData(duration));
    notifyListeners();
  }

  void startTimer(int index) {
    entries[index].startTimer();
    notifyListeners();
  }

  void pause(int index) {
    entries[index].pause();
    notifyListeners();
  }

  void startTimerUpdater() {
    _timerUpdater = Timer.periodic(
      updateInterval,
      (Timer timer) {
        for (var entry in entries) {
          if (entry.active) {
            entry.decrement(updateInterval);
          }
        }
        notifyListeners();
      }
    );
  }

  @override
  void dispose() {
    _timerUpdater.cancel();
    super.dispose();
  }

  AppState() {
    startTimerUpdater();
  }
}
