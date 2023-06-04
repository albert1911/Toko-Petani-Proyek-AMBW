class Toko {
  final String id;
  final String nama;
  final String alamat;

  Toko({
    required this.id,
    required this.nama,
    required this.alamat,
  });
}

// List temporary digunakan agar akses ke database tidak dilakukan berulang-ulang
// saat melakukan debugging
var daftarToko = [
  Toko(id: "1", nama: "Pasar Mekar", alamat: "Jl. Semar 234"),
  Toko(id: "2", nama: "Jaya Makmur", alamat: "Jl. Merdeka 123"),
  Toko(id: "3", nama: "Pasar Enam Juni", alamat: "Jl. Pancasila 36"),
];

String getLocationName(String locationId) {
  Toko? selectedToko = daftarToko.firstWhere(
    (toko) => toko.id == locationId,
    orElse: () => Toko(id: "0", nama: "Unknown", alamat: ""),
  );

  return selectedToko.nama;
}
