import 'package:flutter/material.dart';

class Custtextfaild extends StatelessWidget {
  final String hintee;
  final TextEditingController mycontroller;
  final String? Function(String?) valing;
  const Custtextfaild(
      {super.key,
      required this.hintee,
      required this.mycontroller,
      required this.valing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: valing,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hintee,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 3),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
        ),
      ),
    );
  }
}
