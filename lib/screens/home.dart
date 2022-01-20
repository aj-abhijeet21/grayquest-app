import 'package:flutter/material.dart';
import 'package:grayquest_app/screens/profile.dart';
import 'package:grayquest_app/screens/todo_list.dart';
import 'package:grayquest_app/screens/view_albums.dart';
import 'package:grayquest_app/screens/view_posts.dart';
import 'package:grayquest_app/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const ViewPosts(),
    const ViewAlbums(),
    const TodoList(),
    const UserProfile(),
  ];

  void _onItemTapped(int index) {
    print('total length: ${_pages.length}');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: _pages.elementAt(
          _selectedIndex,
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTapped: _onItemTapped,
      ),
    );
  }
}
