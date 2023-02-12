
class NetworkResponse<T>{

  final T body ;
  final bool isRequestSuccess;
  final String errorMessage;

  NetworkResponse(this.body, this.isRequestSuccess, this.errorMessage);
}