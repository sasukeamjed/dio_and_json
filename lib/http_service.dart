import 'package:dio/dio.dart';

class HttpService{
  late Dio _dio;

  final baseUrl = "https://reqres.in/";

  HttpService(){
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    initialaizeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async{
    print("start of request");
    Response response;
    try {
      response = await _dio.get(endPoint);
      print("after a request");
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    print("end of response");
    return response;
  }

  initialaizeInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, _){
        print(error.message);
      },
      onRequest: (request, _){
        print("${request.method} ${request.baseUrl} ${request.path}");
      },
      onResponse: (response, _){
        print(response.data);
      },
    ));
  }
}