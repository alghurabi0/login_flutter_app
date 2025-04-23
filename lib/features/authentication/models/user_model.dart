class UserModel {
  final String username;
  final String phoneNumber;

  UserModel({required this.username, required this.phoneNumber});

  // Static function to create an empty user model.
  static UserModel empty() => UserModel(username: '', phoneNumber: '');

  // Convert model to JSON structure.
  Map<String, dynamic> toJson() => {'username': username, 'phoneNumber': phoneNumber};

  // Convert JSON structure to model.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(username: json['username'] ?? '', phoneNumber: json['phoneNumber'] ?? '');
  }
}
