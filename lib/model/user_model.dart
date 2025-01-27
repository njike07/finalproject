class UserModel {
  final String? id;
  final String email;
  final String password;
  final String confirmpassword;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.confirmpassword,
  });
}
