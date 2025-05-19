import 'package:flutter/material.dart';

void main() {
  runApp(const MoreTimersApp());
}

class MoreTimersApp extends StatelessWidget {
  const MoreTimersApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: MyHomePage(),
    );
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
    // Widget page;
    // switch (currentPageIndex) {
    //   case 0:
    //     page = Placeholder();
    //   case 1:
    //     page = Placeholder();
    //   default:
    //     throw UnimplementedError('no widget for $currentPageIndex');
    // }


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
            label: 'Stopwatchs'
          ),
          NavigationDestination(
            icon: Icon(Icons.av_timer), 
            label: 'Timers'
          )
        ],
      ),
      body: 
        <Widget>[
        Card(child: Text('Timers'),),
        Card(child: Text('Stopwatches'))
      ][currentPageIndex],
    );
  }
}
