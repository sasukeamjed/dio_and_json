import 'package:dio/dio.dart';
import 'package:dio_and_json/http_service.dart';
import 'package:dio_and_json/model/list_user_response.dart';
import 'package:dio_and_json/model/user.dart';
import 'package:flutter/material.dart';

class ListUserScreen extends StatefulWidget {
  const ListUserScreen({Key? key}) : super(key: key);

  @override
  _ListUserScreenState createState() => _ListUserScreenState();
}

class _ListUserScreenState extends State<ListUserScreen> {

  late HttpService http;

  bool isLoading = false;

  late ListUserResponse listUserResponse;

  late List<User> users;

  Future getListUser() async{

    Response response;
    try {
      isLoading = true;
      print("start 2");
      response = await http.getRequest("/api/users?page=2");
      print("this is the user data ${response.data}");
      isLoading = false;
      if(response.statusCode == 200){
        setState(() {
          listUserResponse = ListUserResponse.fromJson(response.data);
          users = listUserResponse.users;
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
  void initState() {
    http = HttpService();
    getListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Single User"),
      ),
      body: Center(
        child: isLoading ? CircularProgressIndicator() : users != null ? ListView.builder(itemCount: users.length, itemBuilder: (context, index){
          final user = users[index];
          return ListTile(
            title: Text(user.firstName),
            leading: Image.network(user.avatar),
            subtitle: Text(user.email),
          );
        },) : Center(child: Text("No user object found"),),
      ),
    );
  }
}
