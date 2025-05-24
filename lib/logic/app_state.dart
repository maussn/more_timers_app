import 'dart:async';
import 'package:flutter/material.dart';
import 'package:more_timers_app/logic/time_data.dart';
import 'package:more_timers_app/main.dart';


class AppState extends ChangeNotifier {
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

  void startTimerUpdater() {
    _timerUpdater = Timer.periodic(
      updateInterval,
      (Timer timer) {
        for (var entry in entries) {
          if (entry.active) {
            entry.decrement();
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
