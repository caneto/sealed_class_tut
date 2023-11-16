sealed class UIState {
  const UIState();
}

class InitialState extends UIState {
  const InitialState();
}

class SuccessState<T> extends UIState {
  final T data;

  const SuccessState(this.data);
}

class LoadingState extends UIState {
  const LoadingState();
}

class ErrorState extends UIState {
  final String message;

  const ErrorState(this.message);
}