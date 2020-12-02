import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:git_flutter_app/ui/gitrepositories/bloc/git_repository_bloc.dart';
import 'package:git_flutter_app/ui/gitrepositories/git_repositories_ui.dart';
import 'package:git_flutter_app/ui/pullrequests/bloc/pull_request_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: GitRepositoryBloc(),
      child: BlocProvider(
        bloc: PullRequestBloc(),
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
