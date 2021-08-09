import 'dart:async';

enum CounterAction {
  Increment,
  Decrement,
  Reset,
}

class CounterBloc {
  int? counter;
  final _stateStreamController = StreamController<int>();

  StreamSink<int> get counterSink =>
      _stateStreamController.sink; //input property
  Stream<int> get counterStream =>
      _stateStreamController.stream; //output property

  final _eventStreamController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink =>
      _eventStreamController.sink; //input property
  Stream<CounterAction> get eventStream =>
      _eventStreamController.stream; //output property

  CounterBloc() {
    counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.Increment)
        counter = counter! + 1;
      else if (event == CounterAction.Decrement)
        counter = counter! - 1;
      else
        counter = 0;

      counterSink.add(counter!);
    });
  }
}

// class CounterBloc {
//   int _counter = 0;
//
//   final _counterStateController = StreamController<int>();
//   StreamSink<int> get _inCounter => _counterStateController.sink;
//   // For state, exposing only a stream which outputs data
//   Stream<int> get counter => _counterStateController.stream;
//
//   final _counterEventController = StreamController<CounterEvent>();
//   // For events, exposing only a sink which is an input
//   Sink<CounterEvent> get counterEventSink => _counterEventController.sink;
//
//   CounterBloc() {
//     // Whenever there is a new event, we want to map it to a new state
//     _counterEventController.stream.listen(_mapEventToState);
//   }
//
//   void _mapEventToState(CounterEvent event) {
//     if (event is IncrementEvent)
//       _counter++;
//     else
//       _counter--;
//
//     _inCounter.add(_counter);
//   }
//
//   void dispose() {
//     _counterStateController.close();
//     _counterEventController.close();
//   }
// }
