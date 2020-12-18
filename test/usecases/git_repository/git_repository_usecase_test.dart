import 'package:flutter_test/flutter_test.dart';
import 'package:git_flutter_app/models/git_repository.dart';
import 'package:git_flutter_app/repositories/git_repository_repository.dart';
import 'package:git_flutter_app/usecases/git_repository/git_repository_usecase.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class FakeGitRepositoryRepository extends Fake
    implements GitRepositoryRepository {
  @override
  Future<Response> getGitRepositories(int page) async {
    String json =
        '{"total_count": 8649765, "incomplete_results": true, "items": [ { "id": 121395510, "node_id": "MDEwOlJlcG9zaXRvcnkxMjEzOTU1MTA=", "name": "CS-Notes", "full_name": "CyC2018/CS-Notes", "private": false, "owner": { "login": "CyC2018", "id": 36260787, "node_id": "MDQ6VXNlcjM2MjYwNzg3", "avatar_url": "https://avatars3.githubusercontent.com/u/36260787?v=4", "gravatar_id": "", "url": "https://api.github.com/users/CyC2018", "html_url": "https://github.com/CyC2018", "followers_url": "https://api.github.com/users/CyC2018/followers", "following_url": "https://api.github.com/users/CyC2018/following{/other_user}", "gists_url": "https://api.github.com/users/CyC2018/gists{/gist_id}", "starred_url": "https://api.github.com/users/CyC2018/starred{/owner}{/repo}", "subscriptions_url": "https://api.github.com/users/CyC2018/subscriptions", "organizations_url": "https://api.github.com/users/CyC2018/orgs", "repos_url": "https://api.github.com/users/CyC2018/repos", "events_url": "https://api.github.com/users/CyC2018/events{/privacy}", "received_events_url":"received_events", "type":"User", "site_admin": ""}}]}';
    return Future.value(Response(json, 200));
  }
}

void main() {
  test('get git repositories success', () async {
    var fakeGitRepository = FakeGitRepositoryRepository();
    var usecase = GitRepositoryUseCase(fakeGitRepository);

    List<GitRepository> list = await usecase.getGitRepositories(1);

    expect('CS-Notes', equals(list[0].name));
  });
}
