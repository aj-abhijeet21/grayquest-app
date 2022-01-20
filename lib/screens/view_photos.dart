import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grayquest_app/models/models.dart';
import 'package:http/http.dart' as http;

class ViewPhotos extends StatefulWidget {
  int albumId;
  String albumName;
  ViewPhotos({
    required this.albumId,
    required this.albumName,
  });
  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  List<Photo> photosList = [];

  Future<http.Response> getPhotos() async {
    var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/albums/${widget.albumId}/photos');
    var response = await http.get(url);
    // print(response.body);
    return response;
  }

  void getPhotosFromApi() {
    getPhotos().then((response) {
      setState(() {
        Iterable jsonData = jsonDecode(response.body);

        photosList = jsonData.map((photo) => Photo.fromJson(photo)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPhotosFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color(0xFF191919),
        elevation: 0,
        title: Text(
          widget.albumName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: buildPhotosView(),
        ),
      ),
    );
  }

  Widget buildPhotosView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: photosList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildPhotoCard(photosList[index]);
      },
    );
  }

  Widget buildPhotoCard(Photo photo) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 16,
      ),
      color: const Color(0xFF191919),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            photo.url,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              photo.title,
              style: const TextStyle(
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
