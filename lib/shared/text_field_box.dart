import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xguard/controllers/controller.dart';

class TextFieldBox extends StatefulWidget {
  const TextFieldBox(
      {Key? key,
      required this.title,
      required this.hint,
      required this.textEditingController})
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
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
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

class ChoicePicker extends StatefulWidget {
  ChoicePicker(
      {Key? key,
      required this.onChanged,
      required this.optionList,
      required this.title,
      required this.hint,
      required this.selectedOption})
      : super(key: key);

  final String title;
  final String hint;
  String selectedOption;
  List<String> optionList;
  Function(String?)? onChanged;

  @override
  State<ChoicePicker> createState() => _ChoicePickerState();
}

class _ChoicePickerState extends State<ChoicePicker> {
  final RequestController requestController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.0),
                  border: Border.all(width: 0.3)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: DropdownButtonFormField<String>(
                  items: widget.optionList
                      .map((element) => DropdownMenuItem<String>(
                            value: element,
                            child: Text(
                              element,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ))
                      .toList(),
                  hint: const Text(
                    'Make choice here',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      border: InputBorder.none),
                  onChanged: widget.onChanged
                  
                ),
              ))
        ],
      ),
    );
  }
}
