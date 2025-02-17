import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Colors.grey
          ),
          hintText: hintText,
          // enabledBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          // ),
          // focusedBorder: const OutlineInputBorder(
          //     borderSide: BorderSide(color: Color.fromRGBO(189, 189, 189, 1),
          //     ),
          //   ),
          //fillColor: const Color.fromRGBO(238, 238, 238, 1),
          //filled: true,
          
        ),
      ),
    );
  }
}
