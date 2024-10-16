import 'package:flutter/material.dart';
import 'package:springboot_flutter_webservice/pages/Liste_produits.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpringBoot-Flutter Web service',
      theme: ThemeData(

        useMaterial3: true,
      ),
      home: ListeProduis(),
    );
  }
}

