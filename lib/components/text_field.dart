import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final IconData icon;
  final bool isSecret;
  const DefaultTextField(
      {Key? key,
      required this.controller,
      required this.text,
      required this.icon,
      this.isSecret = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 52,
      child: Container(
        width: 327,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffafb0b5),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.only(left: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  width: 19,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Icon(
                    icon,
                    color: Colors.grey,
                  )),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                obscureText: isSecret,
                obscuringCharacter: "*",
                controller: controller,
                decoration: InputDecoration.collapsed(
                  hintText: text,
                  hintStyle: const TextStyle(
                    color: Color(0xffAFB0B6),
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
