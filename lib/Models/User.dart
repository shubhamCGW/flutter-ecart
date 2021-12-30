class User {
  final int userId;
  final String name;
  final String email;
  final int phone;
  final String image;

  User({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['profile']['id'],
        name: json['profile']['name'],
        email: json['profile']['email'],
        phone: json['profile']['phone'],
        image: json['profile']['image']);
  }
}
