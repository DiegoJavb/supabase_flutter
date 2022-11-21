import 'package:call_supabase/products.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bjmwpmbdkmyheiwzlbjy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJqbXdwbWJka215aGVpd3psYmp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njg1NjM0ODYsImV4cCI6MTk4NDEzOTQ4Nn0.LxliMumfywOSV1h1Qww6BGtDQMoFilqXqd1To2sPd5U',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mostrando data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Products(),
    );
  }
}
