// 산책 기록시 하단에 표시되는 산책 시간 측정 타이머
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

  // 00:00:00 형식으로 시간 변환
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
