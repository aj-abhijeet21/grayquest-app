import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grayquest_app/models/models.dart';
import 'package:grayquest_app/models/user_provider.dart';
import 'package:grayquest_app/utils.dart';
import 'package:grayquest_app/widgets/bottom_nav_bar.dart';
import 'package:grayquest_app/widgets/header_widget.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> taskList = [];

  Future<http.Response> getTasks() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/users/${provider.userId}/todos');
    var response = await http.get(url);
    // print(response.body);
    return response;
  }

  void getTasksFromApi() {
    getTasks().then((response) {
      setState(() {
        Iterable jsonData = jsonDecode(response.body);

        taskList = jsonData.map((task) => Todo.fromJson(task)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTasksFromApi();
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
            HeaderWidget(
                headerTitle: 'To Do List',
                headerBody: 'All the to-do tasks will be shown here'),
            const SizedBox(
              height: 28,
            ),
            buildTasks(),
          ],
        ),
      ),
    );
  }

  Widget buildTasks() {
    return ListView.builder(
      itemCount: taskList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildTaskCard(taskList[index]);
      },
    );
  }

  Widget buildTaskCard(Todo task) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 16,
      ),
      padding: EdgeInsets.all(20),
      color: Color(0xFF191919),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            task.isCompleted ? 'Completed' : 'Incomplete',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: task.isCompleted ? primaryColor : Color(0xFFB66857),
            ),
          ),
        ],
      ),
    );
  }
}
