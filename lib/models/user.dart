class User {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? avatarUrl;
  final DateTime? createdAt;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.avatarUrl,
    this.createdAt,
  });

  // Create User instance from Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      avatarUrl: json['avatar_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  get name => null;

  // Create copy of User with modified fields
  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? avatarUrl,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
