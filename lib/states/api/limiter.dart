
import 'dart:async';
import 'dart:math';


int stamp = 0;
List<Function> arr = <Function>[];
Timer? timer;

void initTimer(int interval) {
  int stamp2 = DateTime.now().millisecondsSinceEpoch;
  int ms = max(0, interval - (stamp2 - stamp)); 

  timer?.cancel();
  timer = Timer(Duration(milliseconds: ms), () => checkLimiter(interval));
}

void checkLimiter(int interval) {
  if (arr.isEmpty) {
    timer = null;
  } else {
    stamp = DateTime.now().millisecondsSinceEpoch;
    Function cb = arr.removeAt(0);
    cb();
    if (arr.isNotEmpty) {
      initTimer(interval);
    } else {
      timer = null;
    }
  }
}

void addLimiter(int interval, Function cb) {
  int stamp2 = DateTime.now().millisecondsSinceEpoch;
  
  if (stamp2 - stamp > interval) {
    stamp = stamp2;
    cb();
  }
  else {
    arr.add(cb);
    if (timer == null) initTimer(interval);
  }
}