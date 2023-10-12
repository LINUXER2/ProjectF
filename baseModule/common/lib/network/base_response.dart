class BaseResponse<T> {
  final bool succeed;
  final String? message;
  final T data;

  BaseResponse(this.succeed, this.message, this.data);

  @override
  String toString() {
    return "succeed:$succeed,message:$message \n data:$data";
  }
}
