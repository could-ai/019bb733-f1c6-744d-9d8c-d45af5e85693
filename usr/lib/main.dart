import 'package:flutter/material.dart';
import 'screens/inventory_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS PBO 3 Inventaris',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // Routing Safety: Mendefinisikan initialRoute dan routes map
      initialRoute: '/',
      routes: {
        '/': (context) => const InventoryScreen(),
      },
    );
  }
}
