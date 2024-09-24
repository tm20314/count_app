class UserModel {
  final String fullName;
  final String email;
  final String avatarUrl;

  UserModel(
      {required this.fullName, required this.email, required this.avatarUrl});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['full_name'] ?? 'No Name',
      email: map['email'] ?? 'No Email',
      avatarUrl: map['avatar_url'] ?? '',
    );
  }
}
