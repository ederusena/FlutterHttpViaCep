import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double tamanho;
  const Separator({super.key, this.tamanho = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tamanho,
    );
  }
}
