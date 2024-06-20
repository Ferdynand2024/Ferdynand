class Queue<T> {
  List<T> _elements;
  int _front;
  int _rear;

  Queue()
      : _elements = <T>[],
        _front = 0,
        _rear = -1;

  bool get isEmpty => _rear == -1 && _front == 0;

  void enqueue(T element) {
    _rear++;
    if (_rear < _elements.length) {
      _elements[_rear] = element;
    } else {
      _elements.add(element);
    }
  }

 T? dequeue() {
  if (isEmpty) {
    print("Queue Underflow");
    return null;
  } else {
    T? element = _elements[_front];
    _elements[_front];
    _front++;
    if (_front > _rear) {
      _front = 0;
      _rear = -1;
      _elements.clear();
    }
    return element;
  }
}


  int get length => _rear - _front + 1;

  T? elementAt(int index) {
    if (index < 0 || index >= length) {
      throw RangeError('Index out of range');
    }
    return _elements[_front + index];
  }

  void removeAt(int index) {
    if (index < 0 || index >= length) {
      throw RangeError('Index out of range');
    }
    _elements.removeAt(_front + index);
    _rear--;
    if (_rear < _front) {
      _front = 0;
      _rear = -1;
    }
  }

  List<T> toList() {
    return _elements.sublist(_front, _rear + 1);
  }
}
