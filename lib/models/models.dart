class UserDetails {
  int userId;
  String name;
  String userName;
  String email;
  String phone;
  String website;
  String company;
  String street;
  String suite;
  String city;
  String zipcode;
  UserDetails({
    required this.userId,
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
    required this.website,
    required this.company,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  factory UserDetails.fromJson(Map<String, dynamic> data) {
    final userId = data['id'] as int;

    final userName = data['username'] as String;
    final name = data['name'] as String;
    final email = data['email'] as String;
    final phone = data['phone'] as String;
    final website = data['website'] as String;
    final company = data['company']['name'] as String;
    final street = data['address']['street'] as String;
    final suite = data['address']['suite'] as String;
    final city = data['address']['city'] as String;
    final zipcode = data['address']['zipcode'] as String;
    return UserDetails(
      userId: userId,
      name: name,
      userName: userName,
      email: email,
      phone: phone,
      website: website,
      company: company,
      street: street,
      suite: suite,
      city: city,
      zipcode: zipcode,
    );
  }
}

class Post {
  String title;
  String body;
  int postId;
  int userId;
  Post({
    required this.postId,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> data) {
    final postId = data['id'] as int;
    final userId = data['userId'] as int;
    final title = data['title'] as String;
    final body = data['body'] as String;

    return Post(
      title: title,
      body: body,
      postId: postId,
      userId: userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': postId,
      'title': title,
      'body': body,
    };
  }
}

class Comment {
  String name;
  String email;
  String body;
  int postId;

  Comment({
    required this.name,
    required this.email,
    required this.body,
    required this.postId,
  });

  factory Comment.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final email = data['email'] as String;
    final body = data['body'] as String;
    final postId = data['postId'] as int;

    return Comment(
      name: name,
      body: body,
      email: email,
      postId: postId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'body': body,
      'postId': postId,
    };
  }
}

class Album {
  int userId;
  int albumId;
  String title;

  Album({
    required this.title,
    required this.userId,
    required this.albumId,
  });

  factory Album.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String;
    final userId = data['userId'] as int;
    final albumId = data['id'] as int;

    return Album(
      title: title,
      userId: userId,
      albumId: albumId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'userId': userId,
      'id': albumId,
    };
  }
}

class Photo {
  String title;
  String url;
  String thumbnailUrl;
  int photoId;

  Photo({
    required this.photoId,
    required this.thumbnailUrl,
    required this.title,
    required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String;
    final url = data['url'] as String;
    final thumbnailUrl = data['thumbnailUrl'] as String;
    final photoId = data['id'] as int;

    return Photo(
      photoId: photoId,
      thumbnailUrl: thumbnailUrl,
      title: title,
      url: url,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photoId': photoId,
      'thumbnailUrl': thumbnailUrl,
      'title': title,
      'url': url,
    };
  }
}

class Todo {
  int taskId;
  String title;
  bool isCompleted;

  Todo({
    required this.isCompleted,
    required this.taskId,
    required this.title,
  });

  factory Todo.fromJson(Map<String, dynamic> data) {
    final taskId = data['id'] as int;
    final title = data['title'] as String;
    final isCompleted = data['completed'] as bool;

    return Todo(
      isCompleted: isCompleted,
      taskId: taskId,
      title: title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isCompleted': isCompleted,
      'taskId': taskId,
      'title': title,
    };
  }
}
