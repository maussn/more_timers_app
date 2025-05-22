// import 'dart:async';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

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
  final List<String> entries = <String>[];

  void addEntry(int index) {
    entries.add('$index');
    notifyListeners();
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
    ScrollController _myController = ScrollController();
    Timer(Duration(milliseconds: 500), () => _myController.jumpTo(_myController.position.maxScrollExtent));
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        controller: _myController,
        itemCount: appState.entries.length == null ? 1 : appState.entries.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < appState.entries.length) {
            return Container(
              height: 50,
              color: Colors.amber,
              child: Center(child: Text('Entry ${appState.entries[index]}')),
            );
          }
          return Center(
            child: IconButton(
              onPressed: () {
                appState.addEntry(index);
                _myController.jumpTo(_myController.position.maxScrollExtent);
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
