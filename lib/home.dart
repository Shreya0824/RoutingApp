import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'listposts.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'loginnotifier.dart'

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

    }
}


