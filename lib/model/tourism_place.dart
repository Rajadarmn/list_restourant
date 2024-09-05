class TourismPlace {
  String name;
  String location;
  String description;
  String openDays;
  String openTime;
  String imageAsset;
  List<String> imageUrls;
  bool isFavorite;
  final double rating; // Tambahkan rating jika diperlukan

  TourismPlace({
    required this.name,
    required this.location,
    required this.description,
    required this.openDays,
    required this.openTime,
    required this.imageAsset,
    required this.imageUrls,
    this.isFavorite = false,
    this.rating = 0.0, // Tambahkan nilai default jika diperlukan
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}

var tourismPlaceList = [
  TourismPlace(
    name: 'Sheraton',
    location: 'Sheraton Surabaya Hotel & Towers, Jl. Embong Malang No.25-31, Kedungdoro, Kec. Tegalsari, Surabaya, Jawa Timur 60261',
    description:
        'Restoran Sheron di Surabaya adalah tempat makan yang menawarkan suasana nyaman dengan menu beragam, mencakup masakan lokal dan internasional. Dikenal karena pelayanan yang ramah, Sheron cocok untuk makan bersama, acara keluarga, atau bisnis.',
    openDays: 'Open Tuesday - Saturday',
    openTime: '06:00 - 23:00',
    imageAsset: 'asset/sheraton.jpg',
    imageUrls: [
      'asset/sheraton1.jpg',
      'asset/sheraton2.jpg',
      'asset/sheraton3.jpg',
    ],
    rating: 5.0, // Tambahkan rating
  ),
  TourismPlace(
    name: 'Domicile',
    location: 'Jl. Sumatera No.35, Gubeng, Kec. Gubeng, Surabaya, Jawa Timur 60281',
    description:
        'Domicile Kitchen & Lounge adalah restoran modern di Surabaya yang menyajikan masakan internasional dan lokal dengan sentuhan kreatif. Interiornya elegan dan stylish, menciptakan suasana nyaman untuk bersantap atau berkumpul. Menu di Domicile beragam, mulai dari pasta, steak, hingga hidangan penutup yang menarik, menjadikannya pilihan populer untuk makan siang atau malam.',
    openDays: 'Open Everyday',
    openTime: '11:00 - 23:00',
    imageAsset: 'asset/domicile.jpg',
    imageUrls: [
      'asset/domicile1.jpg',
      'asset/domicile2.jpeg',
      'asset/domicile3.jpg',
    ],
    rating: 4.8, // Tambahkan rating
  ),
  TourismPlace(
    name: 'Layar-Seafood',
    location: 'Jl. KH Abdul Wahab Siamin Surabaya No.216, Dukuh Pakis, Kec. Dukuhpakis, Surabaya, Jawa Timur 60225',
    description:
        'Layar Seafood Surabaya adalah restoran terkenal yang menyajikan hidangan laut segar dengan berbagai pilihan bumbu khas Nusantara, seperti saus asam manis dan saus padang. Dengan konsep interior modern dan nyaman, restoran ini cocok untuk makan bersama keluarga atau teman. Pengunjung bisa memilih sendiri seafood segar sebelum dimasak, menjadikannya pengalaman kuliner yang menarik dan memuaskan.',
    openDays: 'Open Everyday',
    openTime: '11:00 - 21:30',
    imageAsset: 'asset/layar.webp',
    imageUrls: [
      'asset/layar1.jpg',
      'asset/layar2.webp',
      'asset/layar3.jpg',
    ],
    rating: 4.5, // Tambahkan rating
  ),

  TourismPlace(
    name: 'SKY-36',
    location: 'Jl. Sumatera No.36, Gubeng, Kec. Gubeng, Surabaya, Jawa Timur 60281',
    description:
        'Sky-36 adalah restoran mewah di puncak gedung di Surabaya, menawarkan pemandangan kota yang spektakuler. Dengan suasana elegan dan menu perpaduan masakan lokal serta internasional, tempat ini ideal untuk makan malam romantis atau acara khusus.',
    openDays: 'Open Everyday',
    openTime: '16.00-22.00',
    imageAsset: 'asset/sky-36-restaurant.jpg',
    imageUrls: [
      'asset/sky1.jpg',
      'asset/sky2.jpg',
      'asset/sky3.jpg',
    ],
    rating: 4.9, // Tambahkan rating
  ),

];
