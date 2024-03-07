abstract class Result<T>{
  final T value;

  const Result({required this.value});
}

class Success extends Result {
  Success({required super.value});
}

class Failed extends Result {
  final String errorMessage;

  Failed({required this.errorMessage, required super.value});
}

class Loading extends Result {
  Loading({required super.value});
}
