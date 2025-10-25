class Participant {
  final String id;
  final String username;
  final String avatarUrl;

  Participant({
    required this.id,
    required this.username,
    required this.avatarUrl
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );
  }

}