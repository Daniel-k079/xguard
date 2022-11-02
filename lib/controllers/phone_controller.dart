//  Created by Ronnie Zad Muhanguzi .
//  2022,. All rights reserved.
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// #####  Home Page Controller
/// Here we are creating our [HomePageController] class
class KeyPadController extends GetxController {
  /// #####  Amount Controller
  /// Here we are initializing the [amountController] and marking it as an observable variable using
  /// `obs` from the `package:get`
  final TextEditingController ussdOption = TextEditingController();
  final amountController = TextEditingController().obs;
  var doneEditing = false.obs;
    var selectedTime = ''.obs;
  var selectedLecturer = ''.obs;

  /// #####  insertText method
  /// This method is used to input text from a user via the keypad.
  /// Here we first check  if the `amountController` current selection is mot empty  we then set the
  /// new cursor position to the current controller position and move it by the length of the
  /// `inserted text` . We then replace the substring with the `insertedText` and set it to text value
  /// of the controller.
  /// Also the maximum text length is set to 5.
  void insertText(
      String textToInsert, Rx<TextEditingController> amountController) {
    if (amountController.value.selection.start >= 0) {
      int newPosition =
          amountController.value.selection.start + textToInsert.length;
      amountController.value.text = amountController.value.text.replaceRange(
        amountController.value.selection.start,
        amountController.value.selection.end,
        textToInsert,
      );
      amountController.value.selection = TextSelection(
        baseOffset: newPosition,
        extentOffset: newPosition,
      );
    } else if (amountController.value.text.length < 5) {
      amountController.value.text += textToInsert;
    }
  }



}
