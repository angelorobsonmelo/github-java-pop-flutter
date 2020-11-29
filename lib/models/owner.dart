class Owner {
  final String login;
  final String avatarUrl;

  Owner({this.login, this.avatarUrl});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'],
      avatarUrl: json['avatar_url']
    );
  }
}
