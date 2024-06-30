import 'dart:math';

class Quotes {
  static final List<String> _quotes = [
    "Jangan menabung apa yang tersisa setelah dibelanjakan, tetapi belanjakan apa yang tersisa setelah menabung. - Warren Buffett",
    "Pengelolaan keuangan yang baik adalah langkah pertama menuju kebebasan finansial.",
    "Investasi terbaik yang dapat Anda lakukan adalah investasi pada diri sendiri.",
    "Jangan bekerja untuk uang, biarkan uang bekerja untuk Anda.",
    "Ketika Anda mengelola uang dengan bijak, uang akan mengelola kehidupan Anda dengan baik.",
    "Kunci kekayaan bukanlah menghasilkan lebih banyak uang, tetapi mengelola uang dengan bijak.",
    "Jangan pernah bergantung pada satu sumber penghasilan. Investasikan untuk menciptakan sumber kedua.",
    "Kebebasan finansial bukanlah memiliki banyak uang, tetapi memiliki kendali atas uang Anda.",
    "Uang adalah alat. Gunakan untuk mencapai tujuan Anda, bukan sebagai tujuan itu sendiri.",
    "Pengelolaan keuangan yang baik adalah tentang membuat keputusan yang tepat, bukan tentang menghasilkan lebih banyak uang."
  ];

  static String getRandomQuote() {
    final random = Random();
    return _quotes[random.nextInt(_quotes.length)];
  }
}
