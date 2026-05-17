import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.products,
      getPages: AppPages.routes,
      // Daftarkan CartController secara global agar bisa diakses di semua halaman
      initialBinding: BindingsBuilder(() {
        Get.put(CartController(), permanent: true);
      }),
    );
  }
}
