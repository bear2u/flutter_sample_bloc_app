import 'package:flutter_sample_bloc_app/repository.dart';

class Server extends Source {
  int count = 0;
  @override
  decrese() {
    // TODO: implement decrese
    count = count - 2;
    return count;
  }

  @override
  increase() {
    count = count + 2;
    return count;
  }

}