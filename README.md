# Flutter Bloc 패턴 

## 간단한 카운터 bloc 패턴

```dart

// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_sample_bloc_app/bloc.dart';
import 'package:flutter_sample_bloc_app/provider.dart';

// Provider 영역 설정
void main() => runApp(Provider(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  int _counter = 0;
  Bloc bloc;

  void _add() {
    bloc.addCount();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc title'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.count,
          builder: (context, snapshot) {
            print(snapshot.data);
            print(snapshot.connectionState);
            return Text("count: ${snapshot.data ?? 0}");
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```

```dart
//bloc.dart

import 'package:rxdart/rxdart.dart';

class Bloc {
  // 1. Input
  final _count = BehaviorSubject<int>();
  // 2. Output
  Stream<int> get count => _count.stream;

  addCount() {
    int mCount = _count.value ?? 0;
    print(mCount);
    _count.sink.add(mCount+1);
  }

  dispose() {
    _count.close();
  }
}
```

```dart
// provider.dart

import 'package:flutter/material.dart';

import 'bloc.dart';

class Provider extends InheritedWidget {
  final Bloc bloc = Bloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Bloc of(BuildContext context) => (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;

}
```

## 레포지토리 패턴 적용

```dart
// Repository.dart

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
```

```dart
// db.dart
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
```

```dart
// server.dart
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
```

```dart
// 새로운 bloc.dart
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
```


## 화면 구성

### 게시판 개발

### 리스트

#### 화면 구성

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _add() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: StreamBuilder(
              builder: (context, snapshot) =>
                  ListView.builder(itemBuilder: (ctx, index) => Text('Item $index')))),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

```

- `bloc` 파일 및 `provider` 파일 생성
- `provider`에 `bloc` 연동 

### 쓰기

### 수정

### 삭제

