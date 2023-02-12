import 'package:dio/dio.dart';

// import '../../utils/network_mappers.dart';
import '../utils/utlis.dart';
import 'network_mappers.dart';
import 'network_response.dart';

class NetworkHandler {
  // PreferenceManager preferenceManager = Get.find();

  static final NetworkHandler _singleton = NetworkHandler._internal();
  Dio dio = Dio();

  factory NetworkHandler() {
    return _singleton;
  }

  String baseUrl = "https://app.policesteakkw.com/api/";

  NetworkHandler._internal();

  Future<NetworkResponse<ResponseType>> get<ResponseType extends Mappable>(
      ResponseType responseType, String url,
      { var body}) async {
    var response;
    try {
      // print("${ storage.read(CachingKey.AUTH_TOKEN)}");
      dio.options.baseUrl = baseUrl;
        dio.options.headers = {
          // "lang":AppLocalization.localeNow.toString(),
          "Accept": "application/json",
          "Content-Type": "application/json",
          // 'Authorization': preferenceManager.authToken(),
          // "Accept-Language":preferenceManager.currentLang()
        };

      response = await dio.get(url, queryParameters: body);
      print("***************GET $url , query: $body ***************\n${response.data}");

    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse<ResponseType>(response, responseType);
  }

  Future<NetworkResponse<ResponseType>> post<ResponseType extends Mappable>(
      ResponseType responseType, String url,
      { var body, encoding}) async {
    var response;
    dio.options.baseUrl = baseUrl;
    try {
        dio.options.headers = {
          "Accept": "application/json",
          "Content-Type": "application/json",
          // 'Authorization': preferenceManager.authToken(),
          // "Accept-Language":preferenceManager.currentLang()
        };

      response = await dio.post(url,
          data: body, options: Options(requestEncoder: encoding));
        print("***************POST $url , body: $body ***************\n${response.data}");

    } on DioError catch (e) {
      print(e.toString());
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse<ResponseType>(response, responseType);
  }

  Future<NetworkResponse<ResponseType>> delete<ResponseType extends Mappable>(
      ResponseType responseType, String url,
      { var body, encoding}) async {
    var response;
    dio.options.baseUrl = baseUrl;
    try {
        dio.options.headers = {
          "Accept": "application/json",
          "Content-Type": "application/json",
          // 'Authorization': preferenceManager.authToken(),
          // "Accept-Language":preferenceManager.currentLang()
        };

      response = await dio.delete(url,
          data: body, options: Options(requestEncoder: encoding));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse<ResponseType>(response, responseType);
  }

  NetworkResponse<ResponseType> handleResponse<ResponseType extends Mappable>(
      Response response, ResponseType responseType) {

    try{
      final int statusCode = response.statusCode!;
      // print("Status Code is$statusCode");

      if (statusCode >= 200 && statusCode < 300) {
        print("correrct request: " + response.toString());
        if (responseType is ListMappable) {
          return NetworkResponse<ResponseType>(
              Mappable(responseType, response.data) as ResponseType, true, "");
        } else {
          return NetworkResponse<ResponseType>(
              Mappable(responseType, response) as ResponseType, true, "");
        }
      }
      else if(statusCode == 404){
        return NetworkResponse<ResponseType>(Mappable(responseType, response) as ResponseType,
            false, "Not found");

      }
      else {
        print("request error: " + response.toString());
        return NetworkResponse<ResponseType>(Mappable(responseType, response) as ResponseType,
            false,  Utils.getErrorFromJson(response.data));
      }
    }on DioError catch (e) {
      // print(e.toString());
      // if (e.response != null) {
      //   response = e.response;
      // }
      return NetworkResponse<ResponseType>(Mappable(responseType, response) as ResponseType,
          false, e.message);

    } catch(e){
      return NetworkResponse<ResponseType>(Mappable(responseType, response) as ResponseType,
          false, e.toString());
    }

  }
}


