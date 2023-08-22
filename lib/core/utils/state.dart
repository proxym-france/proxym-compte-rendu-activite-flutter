sealed class State<T> {}

class Success<T> extends State<T> {
  final T data;

  Success(this.data);
}

class Error<T> extends State<T> {
  final Object? error;

  Error(this.error);
}

class Loading<T> extends State<T> {
  final bool shouldBeVisible;

  Loading({this.shouldBeVisible = true});
}

class Initial<T> extends State<T> {}

class Refreshing<T> extends State<T> {
  final T data;

  Refreshing(this.data);
}
