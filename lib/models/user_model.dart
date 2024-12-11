
class User {
  final int? id;
  final String fullName, phoneNumber, email;
  final String? password;
  final int? status;

  User({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    this.password,
    this.status
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }
}