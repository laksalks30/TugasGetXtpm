import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../model/product.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  // Ambil data dari Get.arguments yang dikirim saat navigasi
  final Product product = Get.arguments as Product;

  // Ambil CartController yang sudah didaftarkan secara global
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: const Text("Detail")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: Center(
                  child: product.images.length > 1
                      ? ListView.separated(
                          itemCount: product.images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              color: Colors.white,
                              child: Image.network(product.images[index]),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                        )
                      : Card(
                          elevation: 3,
                          color: Colors.white,
                          child: Image.network(
                            product.images[0],
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text("⭐️ ${product.rating}"),
                ],
              ),
              Text("Stock: ${product.stock}"),
              const SizedBox(height: 10),
              Text(product.description, textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: product.tags
                      .map((tag) => Chip(label: Text(tag)))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Reviews",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              Column(
                children: product.reviews.map((review) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        review['reviewerName'].toString().substring(0, 1),
                      ),
                    ),
                    trailing: Text(
                      "${review['rating']}⭐️",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    title: Text(review['reviewerName']),
                    subtitle: Text(review['comment']),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // ── Tombol Tambahkan ke Keranjang ──
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => cartController.addToCart(product),
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text(
                    'Tambahkan ke Keranjang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

