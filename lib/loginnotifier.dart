class LoginNotifier extends ChangeNotifier{

  var status = DataState.UNINIT;
  List<Post> data = List();

  List<Post> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }
  Future<List<Post>> fetchPosts(http.Client client)  async{

//  Future fetchPosts(http.Client client)  async{
//status = DataState.LOADING;
  //  notifyListeners();
    try {
      final response = await client.get('https://api.github.com/users');
      data = parsePosts( response.body);
      status = DataState.SUCCESS;
      notifyListeners();

    } catch(e){
      status = DataState.FAILED;
      print(e);
      }
        return data;

  }
}

enum DataState {
  UNINIT,
  LOADING,
  SUCCESS,
  FAILED
}
