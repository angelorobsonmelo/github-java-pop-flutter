import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:git_flutter_app/models/pull_request_model.dart';
import 'package:git_flutter_app/usecases/pullrequest/pull_request_usecase.dart';
import 'package:rxdart/rxdart.dart';

class PullRequestBloc implements BlocBase {
  PullRequestUseCase _pullRequestUseCase = PullRequestUseCase();
  final _pullRequestController =
      BehaviorSubject<List<PullRequestModel>>(seedValue: []);

  Stream<List<PullRequestModel>> get outPullRequests =>
      _pullRequestController.stream;

  void getPullRequests({String fullUrl}) async {
    List<PullRequestModel> gitRepositories =
        await _pullRequestUseCase.getPullRequests(fullUrl);

    _pullRequestController.sink.add(gitRepositories);
  }

  @override
  void dispose() {
    _pullRequestController.close();
  }
}
