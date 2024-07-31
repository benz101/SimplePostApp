class StandardResponse<T> {
  bool isSuccess;
  String? message;
  T? data;

  StandardResponse({required this.isSuccess, this.message, this.data});
  
}