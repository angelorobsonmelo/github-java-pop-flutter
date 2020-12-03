import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:git_flutter_app/models/pull_request_model.dart';
import 'package:git_flutter_app/models/pull_request_reponse.dart';
import 'package:git_flutter_app/usecases/pullrequest/pull_request_usecase.dart';
import 'package:rxdart/rxdart.dart';

class PullRequestBloc implements BlocBase {
  PullRequestUseCase _pullRequestUseCase = PullRequestUseCase();
  final _pullRequestController =
      BehaviorSubject<List<PullRequestModel>>(seedValue: []);

  final _issuesOpenAndCloseCountController =
      BehaviorSubject<Map<String, int>>(seedValue: {});

  Stream<Map<String, int>> get outCountIssuesOpenedAndClosed =>
      _issuesOpenAndCloseCountController.stream;

  Stream<List<PullRequestModel>> get outPullRequests =>
      _pullRequestController.stream;

  void getPullRequests({String fullUrl}) async {
    PullRequestResponseModel pullRequests =
        await _pullRequestUseCase.getPullRequests(fullUrl);

    if (pullRequests.pullRequestsModel.isNotEmpty) {
      _issuesOpenAndCloseCountController.sink.add({
        'openIssuesCount': pullRequests.openIssuesCount,
        'closeIssuesCount': pullRequests.closeIssuesCount
      });
    } else {
      _issuesOpenAndCloseCountController.sink
          .add({'openIssuesCount': 0, 'closeIssuesCount': 0});
    }

    _pullRequestController.sink.add(pullRequests.pullRequestsModel);
  }

  @override
  void dispose() {
    _pullRequestController.close();
    _issuesOpenAndCloseCountController.close();
  }
}
