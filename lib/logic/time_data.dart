
class TimeData {
  var active = false;
  var finished = false;
  late Duration duration;
  final Duration initialDuration;

  TimeData(this.initialDuration) {
    duration = initialDuration;
  }

  void start() {
    active = true;
    print('Timer set to active: ${duration.toString()}');
  }

  void pause() {
    active = false;
  }

  void restart() {
    duration = initialDuration;
    finished = false;
    active = true;
  }

  void decrement(Duration updateInterval) {
    duration = duration - updateInterval;
    print('Timer decremented: ${duration.toString()}');
    if (duration <= Duration.zero) {
      active = false;
      finished = true;
      activateAlarm();
    }
  }

  void activateAlarm() {
    print('Alarm goes off!');
  }

  String getString() {
    String str = duration.toString();
    return str.substring(0, str.length - 7);
  }
}
