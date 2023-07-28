sealed class ApiState<T> {
  const ApiState();
}

final class Loading extends ApiState {}

class Success<T> extends ApiState<T> {
  final T result;

  Success(this.result);
}

class Error extends ApiState {
  final Exception exception;

  Error(this.exception);
}
