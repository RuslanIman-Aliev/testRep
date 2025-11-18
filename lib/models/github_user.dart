class GithubUser {
  final String login;
  final String? name;
  final String? avatarUrl;
  final String? bio;
  final int publicRepos;
  final int followers;
  final int following;

  GithubUser({
    required this.login,
    this.name,
    this.avatarUrl,
    this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory GithubUser.fromJson(Map<String, dynamic> json) => GithubUser(
        login: json['login'] ?? '',
        name: json['name'],
        avatarUrl: json['avatar_url'],
        bio: json['bio'],
        publicRepos: json['public_repos'] ?? 0,
        followers: json['followers'] ?? 0,
        following: json['following'] ?? 0,
      );
}
