import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:git_flutter_app/constants/constants.dart';
import 'package:git_flutter_app/models/git_repository.dart';
import 'package:git_flutter_app/models/pull_request_model.dart';
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
        body: Column(
          children: [
            StreamBuilder<Map<String, int>>(
                stream: bloc.outCountIssuesOpenedAndClosed,
                initialData: {},
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.grey[300],
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 22, 8, 22),
                      child: Row(
                        children: [
                          Text(
                            '${snapshot.data[Constants.OPEN_ISSUES_COUNT] == null ? 0 : snapshot.data[Constants.OPEN_ISSUES_COUNT]} opened ',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                              '/ ${snapshot.data[Constants.CLOSE_ISSUES_COUNT] == null ? 0 : snapshot.data[Constants.CLOSE_ISSUES_COUNT]} closed',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  );
                }),
            StreamBuilder(
              stream: bloc.outPullRequests,
              initialData: [],
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data.isEmpty)
                  return Center(child: CircularProgressIndicator());
                else
                  return Container(
                    height: 250,
                    child: ListView.separated(
                        padding: EdgeInsets.only(top: 46),
                        separatorBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (snapshot.hasData) {
                            PullRequestModel pullRequest = snapshot.data[index];
                            return ListTile(
                              title: Text(pullRequest.title),
                            );
                          } else {
                            return Container(
                              child: Text('Nada!'),
                            );
                          }
                        }),
                  );
              },
            )
          ],
        ));
  }
}
