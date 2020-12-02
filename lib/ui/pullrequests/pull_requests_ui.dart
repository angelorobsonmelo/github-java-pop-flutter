import 'package:flutter/material.dart';
import 'package:git_flutter_app/models/git_repository.dart';

class PullRequestsUi extends StatelessWidget {
  final GitRepository gitRepository;

  PullRequestsUi({@required this.gitRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gitRepository.name),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
