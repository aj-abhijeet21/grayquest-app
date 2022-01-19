import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTapped;
  CustomBottomNavBar({
    required this.onTapped,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF272828),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      selectedItemColor: Colors.white,
      selectedIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      selectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      unselectedIconTheme: const IconThemeData(
        color: Colors.white,
        opacity: 0.5,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      currentIndex: selectedIndex,
      onTap: onTapped,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/home.png'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/albums.png'),
          label: 'Albums',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/todo.png'),
          label: 'To Do List',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/profile.png'),
          label: 'Profile',
        ),
      ],
    );
  }
}
