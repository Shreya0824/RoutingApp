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
