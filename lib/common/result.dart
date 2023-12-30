sealed class Result<T> {
  factory Result.success(T data) = Success<T>;
  factory Result.error(String e) = Error<T>;
}

class Success<T> implements Result<T> {
  final T data;
  Success(this.data);
}

class Error<T> implements Result<T> {
  final String error;
  Error(this.error);
}