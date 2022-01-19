import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grayquest_app/models/models.dart';
import 'package:grayquest_app/utils.dart';
import 'package:grayquest_app/widgets/bottom_nav_bar.dart';
import 'package:grayquest_app/widgets/header_widget.dart';
import 'package:http/http.dart' as http;

class ViewComments extends StatefulWidget {
  int postId;

  ViewComments({required this.postId});

  @override
  State<ViewComments> createState() => _ViewCommentsState();
}

class _ViewCommentsState extends State<ViewComments> {
  List<Comment> commentList = [];

  Future<http.Response> getComments() async {
    var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/${widget.postId}/comments');
    var response = await http.get(url);
    // print(response.body);
    return response;
  }

  void getCommentsFromApi() {
    getComments().then((response) {
      setState(() {
        Iterable jsonData = jsonDecode(response.body);

        commentList =
            jsonData.map((comment) => Comment.fromJson(comment)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCommentsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            HeaderWidget(
              headerTitle: 'Comments',
              headerBody: 'All the comments for this post will be shown here.',
            ),
            const SizedBox(
              height: 28,
            ),
            buildComments(),
          ],
        ),
      ),
    );
  }

  Widget buildComments() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: commentList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildCommentCard(commentList[index]);
      },
    );
  }

  Widget buildCommentCard(Comment comment) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  comment.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  comment.email,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            comment.body,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
