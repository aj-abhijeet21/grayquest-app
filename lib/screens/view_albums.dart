import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grayquest_app/models/models.dart';
import 'package:grayquest_app/models/user_provider.dart';
import 'package:grayquest_app/screens/view_photos.dart';
import 'package:grayquest_app/widgets/bottom_nav_bar.dart';
import 'package:grayquest_app/widgets/header_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ViewAlbums extends StatefulWidget {
  const ViewAlbums({Key? key}) : super(key: key);

  @override
  _ViewAlbumsState createState() => _ViewAlbumsState();
}

class _ViewAlbumsState extends State<ViewAlbums> {
  List<Album> albumList = [];

  Future<http.Response> getAlbums() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/users/${provider.userId}/albums');
    var response = await http.get(url);
    // print(response.body);
    return response;
  }

  void getAlbumsFromApi() {
    getAlbums().then((response) {
      setState(() {
        Iterable jsonData = jsonDecode(response.body);

        albumList = jsonData.map((album) => Album.fromJson(album)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAlbumsFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
              headerTitle: 'Albums',
              headerBody: 'All the albums by the user will be shown here',
            ),
            const SizedBox(
              height: 28,
            ),
            buildAlbums(),
          ],
        ),
      ),
    );
  }

  Widget buildAlbums() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: albumList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildAlbumCard(albumList[index]);
      },
    );
  }

  Widget buildAlbumCard(Album album) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 16,
      ),
      padding: EdgeInsets.all(20),
      color: Color(0xFF191919),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 9,
            child: Text(
              album.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPhotos(
                      albumId: album.albumId,
                      albumName: album.title,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
