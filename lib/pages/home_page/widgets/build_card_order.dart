import 'package:flutter/material.dart';

Widget buildPokemonOrder({required int order}) {
  final formattedOrder = '#${order.toString().padLeft(3, '0')}';
  return Positioned(
    top: 12,
    right: 10,
    child: Text(
      formattedOrder,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black12,
      ),
    ),
  );
}