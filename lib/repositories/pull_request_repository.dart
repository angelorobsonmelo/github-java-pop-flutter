import 'package:git_flutter_app/datasource/remote/git_repository_api_datasource.dart';
import 'package:http/http.dart';

class PullRequestRepository {
  GitRepositoryApiDataSource _gitRepositoryApiDataSource =
      GitRepositoryApiDataSource();

  Future<Response> getPullRequest(String url) async {
    return _gitRepositoryApiDataSource.getPullRequest(url);
  }
}
