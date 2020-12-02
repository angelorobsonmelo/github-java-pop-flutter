import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:git_flutter_app/models/git_repository.dart';
import 'package:git_flutter_app/ui/pullrequests/bloc/pull_request_bloc.dart';

class PullRequestsUi extends StatelessWidget {
  final GitRepository gitRepository;

  PullRequestsUi({@required this.gitRepository});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PullRequestBloc>(context);
    bloc.getPullRequests(fullUrl: gitRepository.pullsUrl);

    return Scaffold(
        appBar: AppBar(
          title: Text(gitRepository.name),
          backgroundColor: Colors.black87,
        ),
        body: Container(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 22, 8, 22),
            child: Row(
              children: [
                Text(
                  '${this.gitRepository.name} ',
                  style: TextStyle(
                      color: Colors.yellow, fontWeight: FontWeight.bold),
                ),
                Text('/ ${this.gitRepository.name}',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ));
  }
}
