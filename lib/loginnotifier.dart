class LoginNotifier extends ChangeNotifier{

  var status = DataState.UNINIT;
  List<Post> data = List();

  List<Post> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  Future fetchPosts(http.Client client)  async{
    status = DataState.LOADING;
    notifyListeners();
    try {
      final response = await client.get('https://api.github.com/users');
      data = await compute(parsePosts, response.body);
      status = DataState.SUCCESS;
      notifyListeners();

    } catch(e){
      status = DataState.FAILED;
      print(e.toString);
      }
  }
}

enum DataState {
  UNINIT,
  LOADING,
  SUCCESS,
  FAILED
}
