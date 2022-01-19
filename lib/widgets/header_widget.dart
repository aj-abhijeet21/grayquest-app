import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  String headerTitle;
  String headerBody;
  HeaderWidget({required this.headerBody, required this.headerTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF191919),
      height: 185,
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 62,
        bottom: 28,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerTitle,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 13),
          Flexible(
            child: Text(
              headerBody,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
