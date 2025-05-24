import 'package:flutter/material.dart';
import 'package:more_timers_app/logic/app_state.dart';
import 'package:more_timers_app/presentation/timers_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MoreTimersApp());
}

class MoreTimersApp extends StatelessWidget {
  const MoreTimersApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'More Timers',
        theme: ThemeData(
          colorScheme: ColorScheme.dark(),
        ),
        home: MyHomePage(),
      ),
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
