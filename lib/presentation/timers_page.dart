import 'package:flutter/material.dart';
import 'package:more_timers_app/logic/app_state.dart';
import 'package:provider/provider.dart';

class TimersPage extends StatelessWidget {
  const TimersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appState = context.watch<AppState>();
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
              color: theme.colorScheme.onPrimaryContainer,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(appState.entries[index].getString()),
                    ),
                  ),
                  if (appState.entries[index].active) ...[
                    IconButton(onPressed: () {appState.pauseTimer(index);}, icon: Icon(Icons.pause_circle_outline), padding: EdgeInsets.zero)
                  ] else ...[
                    IconButton(onPressed: () {appState.removeTimer(index);}, icon: Icon(Icons.highlight_remove), padding: EdgeInsets.zero),
                    if (appState.entries[index].finished) ...[
                      IconButton(onPressed: () {appState.restartTimer(index);}, icon: Icon(Icons.restore_outlined), padding: EdgeInsets.zero)
                    ] else ...[
                      IconButton(onPressed: () {appState.startTimer(index);}, icon: Icon(Icons.play_circle), padding: EdgeInsets.zero)
                    ]
                  ]
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
