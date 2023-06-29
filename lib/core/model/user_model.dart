class UserModel {
  const UserModel({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.fullName,
  });

  final String? email;

  final String id;

  final String? name;
  final String? fullName;

  final String? photo;

  static const empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;
}
