import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:git_flutter_app/constants/constants.dart';
import 'package:git_flutter_app/models/git_repository.dart';
import 'package:git_flutter_app/models/pull_request_model.dart';
import 'package:git_flutter_app/ui/pullrequests/bloc/pull_request_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

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
                                color: Constants.ORANGE_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                              '/ ${snapshot.data[Constants.CLOSE_ISSUES_COUNT] == null ? 0 : snapshot.data[Constants.CLOSE_ISSUES_COUNT]} closed',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))
                        ],
                      ),
                    ),
                  );
                }),
            Expanded(
              child: StreamBuilder(
                stream: bloc.outPullRequests,
                initialData: [],
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data.isEmpty)
                    return Center(child: CircularProgressIndicator());
                  else {
                    return ListView.separated(
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
                            return buildRepositoriesList(pullRequest);
                          } else {
                            return Container(
                              child: Text('Nada!'),
                            );
                          }
                        });
                  }
                },
              ),
            )
          ],
        ));
  }

  InkWell buildRepositoriesList(PullRequestModel pullRequestModel) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: 8),
        margin: EdgeInsets.only(left: 16),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                pullRequestModel.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  pullRequestModel.body == null ? '' : pullRequestModel.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        NetworkImage(pullRequestModel.user.avatarUrl),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 4),
                        child: Text(
                          pullRequestModel.user.login,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        _launchURL(pullRequestModel.htmlUrl);
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
