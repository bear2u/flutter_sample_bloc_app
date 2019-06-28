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
