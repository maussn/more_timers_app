// import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(const MoreTimersApp());
}

class MoreTimersApp extends StatelessWidget {
  const MoreTimersApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'More Timers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: MyHomePage(),
    );
  }
}

// class AppState extends ChangeNotifier {
//   // ignore: prefer_typing_uninitialized_variables
//   var currentTimer;

//   void setTimer(Duration duration) {
//     currentTimer = Timer(duration, handleTimeout);
//   }

//   void handleTimeout() {

//   }
// }


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


// class TimerField extends StatelessWidget {
//   final Timer timer;
//   const TimerField({super.key, required this.timer});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
//       ),
//       child: Text('Should be a timer'),
//     );
//   }
// }


class TimersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('test1'),
        Text('test2')
      ],
    );
  }
}
