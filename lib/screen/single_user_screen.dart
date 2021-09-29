import 'package:dio/dio.dart';
import 'package:dio_and_json/http_service.dart';
import 'package:dio_and_json/model/single_user_response.dart';
import 'package:dio_and_json/model/user.dart';
import 'package:flutter/material.dart';

class SingleUserScreen extends StatefulWidget {
  const SingleUserScreen({Key? key}) : super(key: key);

  @override
  _SingleUserScreenState createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {

  late HttpService http;

  late SingleUserResponse singleUserResponse;

  late User user;

  bool isLoading = false;

  Future getUser() async{
    print("start");
    Response response;
    try {
      isLoading = true;
      print("start 2");
      response = await http.getRequest("/api/users/2");
      print("this is the user data ${response.data}");
      isLoading = false;
      if(response.statusCode == 200){
        setState(() {
          singleUserResponse = SingleUserResponse.fromJson(response.data);
          user = singleUserResponse.user;
        });

      }else{
        print("There is some problem status code is not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Single User"),
      ),
      body: Center(
        child: isLoading ? CircularProgressIndicator() : user != null ? Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(user.avatar),
              Container(height: 16,),
              Text("Hello, ${user.firstName}"),
            ],
          ),
        ) : Center(child: Text("No user object found"),),
      ),
    );
  }

  @override
  void initState() {
    http = HttpService();
    getUser();
    super.initState();
  }
}
