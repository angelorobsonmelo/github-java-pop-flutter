import 'package:git_flutter_app/models/user.dart';

class PullRequestModel {
  final int id;
  final String title;
  final String body;
  final User user;
  final String htmlUrl;

  PullRequestModel(
      {this.id,
      this.title,
      this.body,
      this.user,
      this.htmlUrl});
}
