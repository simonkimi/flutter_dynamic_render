import 'dart:async';

class BufferStream<T> extends Stream<T> {
  BufferStream({required T initData})
      : _controller = StreamController<T>(),
        buffer = initData;

  BufferStream.broadcast({required T initData})
      : _controller = StreamController<T>.broadcast(),
        buffer = initData;

  final StreamController<T> _controller;

  T buffer;

  void add(T event) => _controller.add(event);

  Stream<T> get stream => _controller.stream;

  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _controller.stream.listen((event) {
      onData?.call(event);
      buffer = event;
    }, onDone: onDone, onError: onError);
  }
}
