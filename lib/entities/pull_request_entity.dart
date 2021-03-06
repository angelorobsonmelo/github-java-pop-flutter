import 'package:git_flutter_app/models/user.dart';

class PullRequestEntity {
  final int id;
  final String title;
  final String body;
  final User user;
  final String state;
  final String htmlUrl;

  PullRequestEntity(
      {this.id, this.title, this.body, this.user, this.state, this.htmlUrl});

  factory PullRequestEntity.fromJson(Map<String, dynamic> json) {
    return PullRequestEntity(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        state: json['state'],
        htmlUrl: json['html_url'],
        user: User.fromJson(json['user']));
  }
}
