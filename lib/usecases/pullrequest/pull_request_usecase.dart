import 'dart:convert';

import 'package:git_flutter_app/entities/pull_request_entity.dart';
import 'package:git_flutter_app/models/pull_request_model.dart';
import 'package:git_flutter_app/repositories/pull_request_repository.dart';
import 'package:http/http.dart';

class PullRequestUseCase {
  PullRequestRepository _pullRequestRepository = PullRequestRepository();

  Future<List<PullRequestModel>> getPullRequests(String fullUrl) async {
    String url = _getUrl(fullUrl);

    Response response = await _pullRequestRepository.getPullRequest(url);

    List<PullRequestEntity> pullRequestEntities = _decode(response);
    return convertToModel(pullRequestEntities);
  }

  String _getUrl(String url) {
    List<String> fullUrl = url.split('{');
    return fullUrl[0];
  }

  List<PullRequestEntity> _decode(Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body).cast<Map<String, dynamic>>();

      return decoded
          .map<PullRequestEntity>((json) => PullRequestEntity.fromJson(json))
          .toList();
    } else {
      throw Exception('Error to load pull requests');
    }
  }

  List<PullRequestModel> convertToModel(List<PullRequestEntity> pullRequests) {
    int openPullRequestQuantity = 0;
    int closedPullRequestQuantity = 0;

    pullRequests.forEach((element) {
      if (element.state == "open") {
        openPullRequestQuantity++;
      } else {
        closedPullRequestQuantity++;
      }
    });

    return pullRequests
        .map<PullRequestModel>((e) => PullRequestModel(
              id: e.id,
              title: e.title,
              body: e.body,
              user: e.user,
              closeIssuesCount: openPullRequestQuantity,
              openIssuesCount: closedPullRequestQuantity,
            ))
        .toList();
  }

}
