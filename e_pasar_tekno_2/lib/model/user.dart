class MyUser {
  String id;

  final String username;
  final String address;
  final String authId;

  MyUser({
    this.id = '',
    required this.username,
    required this.address,
    required this.authId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'address': address,
        'auth_id': authId,
      };

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
      username: json['username'],
      address: json['address'],
      authId: json['auth_id']);
}
