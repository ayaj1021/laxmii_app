import 'package:flutter/material.dart';

class FaceIdLogin extends StatefulWidget {
  const FaceIdLogin({super.key});

  @override
  State<FaceIdLogin> createState() => _FaceIdLoginState();
}

class _FaceIdLoginState extends State<FaceIdLogin> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Face ID Login'),
      ),
    );
  }
}
