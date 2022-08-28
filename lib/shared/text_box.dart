import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  const TextBox({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;

  final String value;

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.0),
                border: Border.all(width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    widget.value,
                    style: const TextStyle(fontSize: 14.0,fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
