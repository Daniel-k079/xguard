import 'package:flutter/material.dart';

class TextFieldBox extends StatefulWidget {
  const TextFieldBox({Key? key, required this.title, required this.hint, required this.textEditingController})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController textEditingController;

  @override
  State<TextFieldBox> createState() => _TextFieldBoxState();
}

class _TextFieldBoxState extends State<TextFieldBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w700),),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.0),
                border: Border.all(width: 0.3)),
            child: TextFormField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(fontSize: 14.0),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0)),
            ),
          )
        ],
      ),
    );
  }
}
