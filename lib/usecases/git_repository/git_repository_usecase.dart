import 'dart:convert';

import 'package:git_flutter_app/models/git_repository.dart';
import 'package:git_flutter_app/repositories/git_repository_repository.dart';
import 'package:http/http.dart';

class GitRepositoryUseCase {
  final GitRepositoryRepository _gitRepositoryRepository;

  GitRepositoryUseCase(this._gitRepositoryRepository);

  Future<List<GitRepository>> getGitRepositories(int page) async {
    Response response = await _gitRepositoryRepository.getGitRepositories(page);

    return _decode(response);
  }

  _decode(Response response) {
    print("status code is: ${response.statusCode}");
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<GitRepository> gitRepositories =
          decoded["items"].map<GitRepository>((map) {
        return GitRepository.fromJson(map);
      }).toList();

      return gitRepositories;
    } else {
      throw Exception('Error to load repositories');
    }
  }
}
