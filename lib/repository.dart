import 'package:flutter_sample_bloc_app/server.dart';

import 'db.dart';

class Repository {
  final sources = <Source> [
    DB(),
    Server()
  ];

  increase() {
    print('increase click');
    return sources[1].increase();
  }

  decrese() {
    print('decrease click');
    return sources[1].decrese();
  }
}

abstract class Source {
  increase();
  decrese();
}