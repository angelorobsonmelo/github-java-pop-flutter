import 'package:git_flutter_app/datasource/remote/git_repository_api_datasource.dart';
import 'package:http/http.dart';

class GitRepositoryRepository {
  final GitRepositoryApiDataSource _gitRepositoryApiDataSource;

  GitRepositoryRepository(this._gitRepositoryApiDataSource);

  Future<Response> getGitRepositories(int page) async {
    return _gitRepositoryApiDataSource.getGitRepositories(page);
  }
}
