
mixin Response {
  String? message;
  String? statusCode;

  bool success(){
    return statusCode == '200';
  }
}