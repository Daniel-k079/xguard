import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xguard/controllers/controller.dart';

class TextFieldBox extends StatefulWidget {
  const TextFieldBox(
      {Key? key,
      this.isPassword = false,
      required this.title,
      required this.hint,
      required this.textEditingController})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController textEditingController;
  final bool isPassword;

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
            child: TextFormField(
              validator: (value) => validateMandatoryField(value),
              obscureText: widget.isPassword,
              controller: widget.textEditingController,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle:
                      const TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0)),
            ),
          )
        ],
      ),
    );
  }
  static String? validateMandatoryField(String? value) {

    final validCharacters = RegExp(r'^[a-zA-Z0-9`/, ]+$');

    if (value!.isEmpty) {
      return 'This cannot be empty';
    } else {
      if (!value.trim().contains(validCharacters) ) {
        return 'Invalid character';
      } else {
        return null;
      }
    }
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
  List<DropdownMenuItem<String>>? optionList;
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
                    // value:widget.selectedOption ,
                    items: widget.optionList,
                    hint: const Text(
                      'Make choice here',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        border: InputBorder.none),
                    onChanged: widget.onChanged),
              ))
        ],
      ),
    );
  }
}
