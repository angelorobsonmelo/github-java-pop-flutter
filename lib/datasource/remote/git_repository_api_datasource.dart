import 'package:http/http.dart' as http;

const BASE_URL = "https://api.github.com";

class GitRepositoryApiDataSource {
  Future<http.Response> getGitRepositories(int page) async {
    final url =
        "$BASE_URL/search/repositories?q=language:Java&sort=stars&page=$page";

    return http.get(url);
  }

  Future<http.Response> getPullRequest(String url) async {
    return http.get(url);
  }
}
