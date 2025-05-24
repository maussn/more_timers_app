import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const updateInterval = Duration(seconds: 1);

void activateAlarm() {
  print('Alarm goes off!');
}


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


void main() {
  runApp(const MoreTimersApp());
}

class MoreTimersApp extends StatelessWidget {
  const MoreTimersApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _AppState(),
      child: MaterialApp(
        title: 'More Timers',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class _AppState extends ChangeNotifier {
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

  _AppState() {
    startTimerUpdater();
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (currentPageIndex) {
      case 0:
        page = Card(child: Text('Stopwatches'));
      case 1:
        page = TimersPage();
      default:
        throw UnimplementedError('no widget for $currentPageIndex');
    }

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.access_alarm),
            label: 'Stopwatches'
          ),
          NavigationDestination(
            icon: Icon(Icons.av_timer), 
            label: 'Timers'
          )
        ],
      ),
      body: page,
    );
  }
}


class TimersPage extends StatelessWidget {
  const TimersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_AppState>();
    ScrollController myController = ScrollController();
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: ListView.separated(
        padding: const EdgeInsets.all(10),
        controller: myController,
        itemCount: appState.entries.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < appState.entries.length) {
            return Container(
              height: 50,
              padding: EdgeInsets.all(10),
              color: Colors.amber,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(appState.entries[index].getString()),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      appState.entries[index].startTimer();
                    },
                    icon: Icon(Icons.play_arrow),
                  ),

                  // IconButton(onPressed: () {appState.(index);}, icon: Icon(Icons.highlight_remove))
                ],
              ),
            );
          }
          return Center(
            child: IconButton(
              onPressed: () {
                appState.addTimer(Duration(seconds: 5));
                myController.jumpTo(myController.position.maxScrollExtent);
              },
              icon: Icon(Icons.add_circle),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
