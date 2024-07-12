import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final VoidCallback onTap;

  const CustomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromRGBO( 255, 160, 25, 1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Center(
          child: Text(
            'Ingresar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ),
      ),
      
    );
  }
}