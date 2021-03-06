import 'owner.dart';

class GitRepository {
  final int id;
  final String name;
  final String description;
  final int forksCount;
  final int stargazersCount;
  final Owner owner;
  final String pullsUrl;

  GitRepository(
      {this.id,
      this.name,
      this.description,
      this.forksCount,
      this.stargazersCount,
      this.owner,
      this.pullsUrl});

  factory GitRepository.fromJson(Map<String, dynamic> json) {
    return GitRepository(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        forksCount: json['forks_count'],
        stargazersCount: json['stargazers_count'],
        owner: Owner.fromJson(json['owner']),
        pullsUrl: json['pulls_url']);
  }
}
