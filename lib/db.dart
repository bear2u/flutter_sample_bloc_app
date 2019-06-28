import 'package:flutter_sample_bloc_app/repository.dart';

class DB extends Source {
  int count = 0;
  @override
  decrese() {
    // TODO: implement decrese
    return ++count;
  }

  @override
  increase() {
    // TODO: implement increase
    return ++count;
  }

}