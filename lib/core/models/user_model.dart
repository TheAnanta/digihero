class User {
  final String username;
  final String name;
  final bool isAuthenticated;

  const User({
    required this.username,
    required this.name,
    this.isAuthenticated = false,
  });

  User copyWith({
    String? username,
    String? name,
    bool? isAuthenticated,
  }) {
    return User(
      username: username ?? this.username,
      name: name ?? this.name,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'isAuthenticated': isAuthenticated,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      isAuthenticated: json['isAuthenticated'] ?? false,
    );
  }

  @override
  String toString() {
    return 'User(username: $username, name: $name, isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.username == username &&
        other.name == name &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode {
    return username.hashCode ^ name.hashCode ^ isAuthenticated.hashCode;
  }
}