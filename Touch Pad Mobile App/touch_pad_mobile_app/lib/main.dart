import 'package:flutter/material.dart';
import 'package:touch_pad_mobile_app/views/ip_qr_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: const IpQrView()),
    );
  }
}
