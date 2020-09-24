import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'post.dart';

class ListViewPosts  extends StatelessWidget {
  final List<Post> posts;

  ListViewPosts ({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: posts.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[

                Divider(height: 5.0),
                ListTile(

                  title: Text(
                    '${posts[position].login}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  subtitle: Text(
                    '${posts[position].url}',
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  leading: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 15.0,
                        child: Text(
                          '${posts[position].id}',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () =>
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              SecondScreen(),
                            settings: RouteSettings(
                              arguments: posts[position], //_onTapItem(context, posts[position]),
                            ),
                          )
                      ),
//                  Navigator.pushNamed(context, '/second')

                )
              ],
            );
          }),
    );
  }

}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(post.login),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(post.avatar_url),
            SizedBox(height: 30),
            Text(post.type),
            SizedBox(height: 30),
            Text(post.node_id),
            SizedBox(height: 80),
             RaisedButton(
              onPressed: () {
                // Navigate back to the first screen by popping the current route
                // off the stack.
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ]
        )

      ),
    );
  }
}
