import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'listposts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => LoginNotifier(),
      child:Scaffold(
      appBar: AppBar(
        title: Text('Named Routes Demo'),
      ),
      body: Builder(
          builder: (BuildContext context) {
            Provider.of<LoginNotifier>(context).fetchPosts(http.Client());

            return Stack(
            children: <Widget>[
                        Consumer<LoginNotifier>(

                            builder: (context, notif, child) => notif
                                .isLoading
                                ? Center(
                                child:
                                CircularProgressIndicator())
                                :
                            ListViewPosts(posts: notif.data,)

                    )]
                  );},


          )));
//        Builder<List<Post>>(
//        future: fetchPosts(http.Client()),
//        builder: (context, snapshot) {
//
//          Consumer<LoginNotifier>(
//              builder: (context, notif, child) => notif
//                  .isLoading
//                  ? Center(
//                  child:
//                  CircularProgressIndicator())
//                  : return snapshot.hasData
//          ? ListViewPosts (posts: snapshot.data)
//              : Center(child: CircularProgressIndicator());
//              //child,
////              child: Container()
//          )
//         // if (snapshot.hasError) print(snapshot.error);
//        },
   //   ),

    }
}

class LoginNotifier extends ChangeNotifier{

  bool isLoading=false;
  List<Post> data = List();

  List<Post> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Future fetchPosts(http.Client client)  async{
    isLoading=true;
    String error="";
    notifyListeners();
    try {
      final response = await client.get('https://api.github.com/users');
      data = await compute(parsePosts, response.body);
      isLoading = false;
      notifyListeners();

    } catch(e){
      isLoading=false;
      print('error');
      }
  }
}

