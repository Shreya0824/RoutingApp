class Post {
  final int id;
  final String login;
  final String url;
  final String type;
  final String node_id;
  final String avatar_url;


  Post({ this.id, this.login, this.url,this.type,this.node_id,this.avatar_url});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      login: json['login'] as String,
      url: json['url'] as String,
      type: json['type'] as String,
      node_id: json['node_id'] as String,
      avatar_url: json['avatar_url'] as String,

    );
  }
}