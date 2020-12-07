import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:git_flutter_app/repositories/git_repository_repository.dart';
import 'package:git_flutter_app/repositories/pull_request_repository.dart';
import 'package:git_flutter_app/ui/gitrepositories/bloc/git_repository_bloc.dart';
import 'package:git_flutter_app/ui/gitrepositories/git_repositories_ui.dart';
import 'package:git_flutter_app/ui/pullrequests/bloc/pull_request_bloc.dart';
import 'package:git_flutter_app/usecases/git_repository/git_repository_usecase.dart';
import 'package:git_flutter_app/usecases/pullrequest/pull_request_usecase.dart';

import 'datasource/remote/git_repository_api_datasource.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: GitRepositoryBloc(GitRepositoryUseCase(
          GitRepositoryRepository(GitRepositoryApiDataSource()))),
      child: BlocProvider(
        bloc: PullRequestBloc(PullRequestUseCase(
            PullRequestRepository(GitRepositoryApiDataSource()))),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: GitRepositoriesScreen(),
        ),
      ),
    );
  }
}
