import 'package:bloc_pattern/controllers/counter_bloc.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    print("-------Widget Tree-------");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<Object>(
              stream: counterBloc.counterStream,
              builder: (context, snapshot) {
                return Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter++;
          counterBloc.counterSink.add(_counter);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
