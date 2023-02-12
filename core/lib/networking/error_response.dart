class ErrorResponse {
  List<Error>? error;

  ErrorResponse({this.error});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    if (json['error'] != null) {
      error = <Error>[];
      json['error'].forEach((v) {
        error!.add(new Error.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Error {
  String? message;

  Error({this.message});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
