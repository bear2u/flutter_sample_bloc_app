import 'package:flutter_sample_bloc_app/repository.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  final _repository = Repository();
  // 1. Input
  final _count = BehaviorSubject<int>();
  // 2. Output
  Stream<int> get count => _count.stream;
//      .map((count) {
//    print('count : => $count');
//    return count * 10;
//  });

  addCount() {
    int mCount =  _repository.increase();
    _count.sink.add(mCount);
  }

  dispose() {
    _count.close();
  }
}