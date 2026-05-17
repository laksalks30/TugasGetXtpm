import 'package:get/get.dart';
import '../model/product.dart';

class CartController extends GetxController {
  // State: daftar produk di keranjang (reaktif)
  final RxList<Product> cartItems = <Product>[].obs;

  // Getter: jumlah total item di keranjang
  int get itemCount => cartItems.length;

  // Getter: hitung total harga semua item di keranjang
  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + item.price);
  }

  // Method: tambah produk ke keranjang (cegah duplikat berdasarkan id)
  void addToCart(Product product) {
    final alreadyInCart = cartItems.any((item) => item.id == product.id);
    if (alreadyInCart) {
      Get.snackbar(
        'Info',
        '${product.title} sudah ada di keranjang',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      cartItems.add(product);
      Get.snackbar(
        '✅ Berhasil',
        '${product.title} ditambahkan ke keranjang',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Method: hapus produk dari keranjang berdasarkan id
  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.id == product.id);
    Get.snackbar(
      'Dihapus',
      '${product.title} dihapus dari keranjang',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Method: kosongkan seluruh keranjang
  void clearCart() {
    cartItems.clear();
  }
}
