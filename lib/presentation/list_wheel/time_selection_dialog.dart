import 'package:flutter/material.dart';
import 'package:more_timers_app/logic/app_state.dart';
import 'package:more_timers_app/presentation/list_wheel/tile.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class TimeSelectionDialog extends StatelessWidget {
  var currentHours = 0;
  var currentMinutes = 0;
  var currentSeconds = 0;

  TimeSelectionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    return AlertDialog(
      contentPadding: EdgeInsets.all(50),
      content: Row(
        children: [
          Expanded(
            child: ListWheelScrollView.useDelegate(
              onSelectedItemChanged: (value) => currentHours = value,
              itemExtent: 70,
              overAndUnderCenterOpacity: 0.5,
              perspective: 0.01,
              physics: FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 99,
                builder: (context, hours) {
                  return MyTile(
                    value: hours,
                  );
                }
              ),
            ),
          ),
          
          SizedBox(
            width: 10, 
            child: Text(
              ':',
              style: TextStyle(
                fontSize: 40,
                color:Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Expanded(
            child: ListWheelScrollView.useDelegate(
              onSelectedItemChanged: (value) => currentMinutes = value,
              itemExtent: 70,
              overAndUnderCenterOpacity: 0.5,
              perspective: 0.01,
              physics: FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 60,
                builder: (context, mins) {
                  return MyTile(
                    value: mins,
                  );
                }
              ),
            ),
          ),
          
          SizedBox(
            width: 10, 
            child: Text(
              ':',
              style: TextStyle(
                fontSize: 40,
                color:Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Expanded(
            child: ListWheelScrollView.useDelegate(
              onSelectedItemChanged:(value) => currentSeconds = value,
              itemExtent: 70,
              overAndUnderCenterOpacity: 0.5,
              perspective: 0.01,
              physics: FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 60,
                builder: (context, secs) {
                  return MyTile(
                    value: secs,
                  );
                }
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            appState.addTimer(Duration(hours: currentHours, minutes: currentMinutes, seconds: currentSeconds));
            Navigator.of(context).pop();
          }, 
          child: Text('Create Timer')
        ),
        TextButton(
          onPressed: () {Navigator.of(context).pop();}, 
          child: Text('Cancel')
        )
      ],
    );
  }
}
