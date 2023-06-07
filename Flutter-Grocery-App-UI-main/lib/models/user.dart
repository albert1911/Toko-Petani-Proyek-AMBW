class MyUser {
  final String nama;
  final String email;
  final String alamat;

  MyUser({
    required this.nama,
    required this.email,
    required this.alamat,
  });

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'email': email,
        'alamat': alamat,
      };

  static MyUser fromJson(Map<String, dynamic> json) => MyUser(
        nama: json['nama'],
        email: json['email'],
        alamat: json['alamat'],
      );
}

bool isLoggedIn = false;
