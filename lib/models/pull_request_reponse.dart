import 'package:git_flutter_app/models/pull_request_model.dart';

class PullRequestResponseModel {
  final int openIssuesCount;
  final int closeIssuesCount;
  final List<PullRequestModel> pullRequestsModel;

  PullRequestResponseModel({
      this.openIssuesCount, this.closeIssuesCount, this.pullRequestsModel});
}
