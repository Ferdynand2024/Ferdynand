class Stack<T> {
  List<T> _elements = [];

  bool get isEmpty => _elements.isEmpty;

  void push(T element) {
    _elements.add(element);
  }

  T? pop() {
    if (isEmpty) {
      print("Stack underflow");
      return null;
    } else {
      return _elements.removeLast();
    }
  }

  T? peek() {
    if (isEmpty) {
      print("Stack underflow");
      return null;
    } else {
      return _elements.last;
    }
  }
}
