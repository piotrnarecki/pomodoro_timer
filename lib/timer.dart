import 'dart:async';
import 'timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimer {
  double _radius = 1;

  bool _isActive = true;

  Timer timer;
  Duration _time;
  Duration _fullTime;

  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();

    String formattedTime = minutes + ":" + seconds;

    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;

      if (this._isActive) {
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;

        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }

      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

//Future readSettings()async*

}
