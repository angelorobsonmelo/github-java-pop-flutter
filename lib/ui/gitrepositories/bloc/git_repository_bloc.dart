import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:git_flutter_app/models/git_repository.dart';
import 'package:git_flutter_app/usecases/git_repository/git_repository_usecase.dart';
import 'package:rxdart/rxdart.dart';

class GitRepositoryBloc implements BlocBase {
  GitRepositoryUseCase _gitRepositoryUseCase = GitRepositoryUseCase();
  final _gitRepositoryController =
  BehaviorSubject<List<GitRepository>>(seedValue: []);

  List<GitRepository> gitRepositories;

  Stream<List<GitRepository>> get outGitRepositories =>
      _gitRepositoryController.stream;

  void getRepositories({int page = 1}) async {
    if (page == 1) {
      gitRepositories = await _gitRepositoryUseCase.getGitRepositories(page);
    } else {
      gitRepositories += await _gitRepositoryUseCase.getGitRepositories(page);
    }

    _gitRepositoryController.sink.add(gitRepositories);
  }

  @override
  void dispose() {
    _gitRepositoryController.close();
  }
}
