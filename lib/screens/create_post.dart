import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grayquest_app/models/models.dart';
import 'package:grayquest_app/models/user_provider.dart';
import 'package:grayquest_app/utils.dart';
import 'package:grayquest_app/widgets/textfield_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController bodyEditingController = TextEditingController();
  int postId = 1;

  @override
  void initState() {
    super.initState();
    getPostsFromApi();
  }

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

        postId =
            jsonData.map((post) => Post.fromJson(post)).toList().last.postId +
                1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: const Color(0xFF191919),
        elevation: 0,
        title: const Text(
          'Create Post',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
              controller: titleEditingController,
              hintText: '',
              maxLines: 1,
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Post',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
              controller: bodyEditingController,
              hintText: '',
              maxLines: 5,
            ),
            const SizedBox(
              height: 28,
            ),
            Center(
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
                onPressed: () {
                  String title = titleEditingController.text.trim();
                  String body = bodyEditingController.text.trim();
                  createPost(
                    postId,
                    title,
                    body,
                  );
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 22),
                  child: Text('Submit Post'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future createPost(int postId, String title, String body) async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    Post newPost = Post(
      postId: postId,
      userId: provider.userId,
      title: title,
      body: body,
    );
    var jsonData = newPost.toJson();

    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(jsonData),
    );

    print(response.statusCode);
    if (response.statusCode == 201) {
      print('Post created successfully');
    } else {
      print(response.body);
    }
  }
}
