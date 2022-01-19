import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grayquest_app/models/db.dart';
import 'package:grayquest_app/models/models.dart';
import 'package:grayquest_app/models/user_provider.dart';
import 'package:grayquest_app/screens/home.dart';
import 'package:grayquest_app/screens/view_posts.dart';
import 'package:grayquest_app/utils.dart';
import 'package:grayquest_app/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final dbHelper = DatabaseManager.instance;
  final TextEditingController usernameEditingController =
      TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  // Future<http.Response> getUser(String username) async {
  //   UserProvider provider = Provider.of<UserProvider>(context, listen: false);
  //   var url =
  //       Uri.parse('https://jsonplaceholder.typicode.com/users?name=$username');
  //   var response = await http.get(url);
  //   // print(response.body);
  //   return response;
  // }

  void getUserFromApi(String username) async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    var url =
        Uri.parse('https://jsonplaceholder.typicode.com/users?name=$username');
    var response = await http.get(url);
    setState(() {
      var jsonData = jsonDecode(response.body);
      UserDetails user = UserDetails.fromJson(jsonData);
      provider.setUser(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0.0,
        title: const Text(
          'LOG IN',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email ID',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
              controller: usernameEditingController,
              hintText: 'example@gmail.com',
              maxLines: 1,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
              controller: passwordEditingController,
              hintText: 'Enter your password',
              maxLines: 1,
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onPressed: login,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      child: Text('Continue'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    {
      String userName = usernameEditingController.text.trim();
      String password = passwordEditingController.text.trim();
      print(userName);
      print(password);
      bool loginSuccessful =
          await dbHelper.authenticateUser(userName, password);
      if (loginSuccessful) {
        getUserFromApi(userName);
        print('Login success...');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        AlertDialog(
          title: Text('Login failed'),
          content: Text('Please check email/password'),
        );
      }
    }
  }
}
