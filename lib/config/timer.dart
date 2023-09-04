// timer_util.dart

import 'dart:async';

class TimerUtil {
  late Timer _timer;
  int _seconds = 0;

  void startTimer(Function(int) updateTimer) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      updateTimer(_seconds);
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  void resetTimer() {
    _seconds = 0;
  }

  Stream<int> timerStream = Stream<int>.periodic(
    Duration(seconds: 1),
        (x) => x,
  );

  static String getFormattedTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}


// import 'dart:async';
//
// void startTimer(Function(String) updateTimer) {
//   int seconds = 0;
//   Timer? timer;
//
//   timer = Timer.periodic(Duration(seconds: 1), (t) {
//     seconds++;
//     final String recordedTime = getRecordedTime(seconds);
//     updateTimer(recordedTime);
//   });
// }
//
// String getRecordedTime(int seconds) {
//   final int hours = seconds ~/ 3600;
//   final int minutes = (seconds % 3600) ~/ 60;
//   final int remainingSeconds = seconds % 60;
//
//   final String hoursStr = hours.toString().padLeft(2, '0');
//   final String minutesStr = minutes.toString().padLeft(2, '0');
//   final String secondsStr = remainingSeconds.toString().padLeft(2, '0');
//
//   return '$hoursStr:$minutesStr:$secondsStr';
// }