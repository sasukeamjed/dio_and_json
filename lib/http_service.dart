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
      print(response.statusCode);
      print("after a request");
    } on DioError catch (e) {
      if(e.type == DioErrorType.connectTimeout){
        print("Connection  Timeout Exception");
        throw Exception("Connection  Timeout Exception");
      }
      print(e.message);
      throw Exception(e.message);
    }
    print("end of response");
    return response;
  }

  initialaizeInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler){
        print(error.message);
        handler.next(error);
      },
      onRequest: (request, handler){
        print("${request.method} ${request.baseUrl} ${request.path}");
        handler.next(request);
      },
      onResponse: (response, handler){
        print(response.data);
        handler.next(response);
      },
    ));
  }
}