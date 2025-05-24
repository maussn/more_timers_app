import 'package:more_timers_app/main.dart';

class TimeData {
  var active = false;
  Duration duration;

  TimeData(this.duration);

  void startTimer() {
    active = true;
    print('Timer set to active: ${duration.toString()}');
  }

  void decrement() {
    duration = duration - updateInterval;
    print('Timer decremented: ${duration.toString()}');
    if (duration <= Duration.zero) {
      active = false;
      activateAlarm();
    }
  }

  String getString() {
    String str = duration.toString();
    return str.substring(0, str.length - 7);
  }
}
