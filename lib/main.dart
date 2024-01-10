import 'package:flutter/material.dart';
import 'package:flutter_sbloc_api/features/posts/ui/post_page.dart';




void main() async{
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostsPage(),
    );
  }
}