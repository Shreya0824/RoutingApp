import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'listposts.dart';
import 'package:flutter/foundation.dart';
Future<List<Post>> fetchPosts(http.Client client) async {
  final response = await client.get('https://api.github.com/users');

  return compute(parsePosts, response.body);
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class FirstScreen extends StatelessWidget {
//  final String title;
//
//  FirstScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text(title),
        title: Text('Named Routes Demo'),

      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListViewPosts (posts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}