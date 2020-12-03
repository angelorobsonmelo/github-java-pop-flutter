import 'dart:convert';

import 'package:git_flutter_app/entities/pull_request_entity.dart';
import 'package:git_flutter_app/models/pull_request_model.dart';
import 'package:git_flutter_app/models/pull_request_reponse.dart';
import 'package:git_flutter_app/repositories/pull_request_repository.dart';
import 'package:http/http.dart';

class PullRequestUseCase {
  PullRequestRepository _pullRequestRepository = PullRequestRepository();

  Future<PullRequestResponseModel> getPullRequests(String fullUrl) async {
    String url = _getUrl(fullUrl);

    Response response = await _pullRequestRepository.getPullRequest(url);

    List<PullRequestEntity> pullRequestEntities = _decode(response);
    return _convertToModel(pullRequestEntities);
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

  PullRequestResponseModel _convertToModel(
      List<PullRequestEntity> pullRequests) {
    int openIssuesCount = 0;
    int closeIssuesCount = 0;

    pullRequests.forEach((element) {
      if (element.state == "open") {
        openIssuesCount++;
      } else {
        closeIssuesCount++;
      }
    });

    List<PullRequestModel> modelsList = pullRequests
        .map<PullRequestModel>((e) => PullRequestModel(
              id: e.id,
              title: e.title,
              body: e.body,
              user: e.user,
            ))
        .toList();

    return PullRequestResponseModel(
        openIssuesCount: openIssuesCount,
        closeIssuesCount: closeIssuesCount,
        pullRequestsModel: modelsList);
  }
}
