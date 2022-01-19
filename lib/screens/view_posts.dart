import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grayquest_app/models/models.dart';
import 'package:grayquest_app/screens/create_post.dart';
import 'package:grayquest_app/screens/view_comments.dart';
import 'package:grayquest_app/utils.dart';
import 'package:grayquest_app/widgets/bottom_nav_bar.dart';
import 'package:grayquest_app/widgets/header_widget.dart';
import 'package:http/http.dart' as http;

class ViewPosts extends StatefulWidget {
  const ViewPosts({Key? key}) : super(key: key);

  @override
  _ViewPostsState createState() => _ViewPostsState();
}

class _ViewPostsState extends State<ViewPosts> {
  List<Post> postList = [];

  static Future<http.Response> getPosts() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    // print(response.body);
    return response;
  }

  void getPostsFromApi() {
    getPosts().then((response) {
      setState(() {
        Iterable jsonData = jsonDecode(response.body);

        postList = jsonData.map((post) => Post.fromJson(post)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // print('init method called');
    getPostsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePost(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            HeaderWidget(
              headerTitle: 'Posts',
              headerBody: 'All the posts will be displayed here',
            ),
            const SizedBox(
              height: 28,
            ),
            buildPosts(),
          ],
        ),
      ),
    );
  }

  Widget buildPosts() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: postList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return buildPostCard(postList[index]);
        });
  }

  Widget buildPostCard(Post post) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 28,
      ),
      padding: EdgeInsets.all(20),
      color: Color(0xFF191919),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            post.body,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewComments(
                    postId: post.postId,
                  ),
                ),
              );
            },
            child: Text(
              'view comments',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
