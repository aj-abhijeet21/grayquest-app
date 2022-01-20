import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grayquest_app/models/models.dart';
import 'package:grayquest_app/models/user_provider.dart';
import 'package:grayquest_app/screens/log_in.dart';
import 'package:grayquest_app/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserDetails? user;
  // UserDetails getUser() {
  //   UserProvider provider = Provider.of<UserProvider>(context, listen: false);

  //   return provider.currentUser;
  // }

  Future<http.Response> getUser() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    int userId = provider.getUserId();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users/$userId');
    var response = await http.get(url);
    // print(response.body);
    return response;
  }

  void getUserDetailsFromApi() {
    getUser().then((response) {
      setState(() {
        // Map<String, dynamic> jsonData = jsonDecode(response.body);
        var jsonData = jsonDecode(response.body);

        user = UserDetails.fromJson(jsonData);

        // jsonData
        //     .map((userDetails) => UserDetails.fromJson(userDetails))
        //     .toList()
        //     .first;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetailsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 28,
                top: 62,
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/user_profile.png'),
                  const SizedBox(width: 17),
                  const Text(
                    'User Profile',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            buildBasicInfo(user!),
            const SizedBox(
              height: 38,
            ),
            buildAddressInfo(user!),
            const SizedBox(
              height: 38,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      onPressed: logout,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text('LOG OUT'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 38,
            ),
          ],
        ),
      ),
    );
  }

  logout() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    provider.userId = 0;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LogInPage(),
      ),
    );
  }

  Widget buildAddressInfo(UserDetails user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'ADDRESS INFORMARION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Street',
            user.street,
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Suite',
            user.suite,
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'City',
            user.city,
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Zipcode',
            user.zipcode,
          ),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  Widget buildBasicInfo(UserDetails user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'BASIC INFORMARION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Name',
            user.name,
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Email Address',
            user.email,
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Password',
            'Shishir',
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Phone no.',
            user.phone,
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Website',
            user.website,
          ),
          SizedBox(
            height: 18,
          ),
          buildUserDetail(
            'Company',
            user.company,
          ),
        ],
      ),
    );
  }

  Widget buildUserDetail(String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: 'Nova',
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            data,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
