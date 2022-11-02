//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'package:flutter/material.dart';


class KeyPadButton extends StatefulWidget {
  /// #####  Key Pad Button
  /// This is a custom keypad with it takes an `index` of type [int] and `tapAction` of type
  /// [VoidCallback]
  const KeyPadButton(
      {Key? key,
      required this.numberStyle,
      required this.letterStyle,
      required this.index,
      required this.tapAction})
      : super(key: key);
  final int index;
  final VoidCallback tapAction;
  final TextStyle numberStyle;
  final TextStyle letterStyle;

  @override
  State<KeyPadButton> createState() => _KeyPadButtonState();
}

class _KeyPadButtonState extends State<KeyPadButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: widget.tapAction,
      child: Container(
        width: 72.0,
        height: 72.0,
        color: Colors.transparent,
        child: Center(
          child: Column(
            children: [
              Text(
                  widget.index == 9
                      ? '*'
                      : widget.index == 10
                          ? '0'
                          : widget.index == 11
                              ? '#'
                              : '${widget.index + 1}',
                  style: widget.numberStyle),
              Text(
                getText(widget.index),
                style: widget.letterStyle
              )
            ],
          ),
        ),
      ),
    );
  }

  getText(index) {
    switch (index) {
      case 0:
        return '';
      case 1:
        return 'ABC';
      case 2:
        return 'DEF';
      case 3:
        return 'GHI';
      case 4:
        return 'JKL';
      case 5:
        return 'MNO';
      case 6:
        return 'PQRS';
      case 7:
        return 'TUV';
      case 8:
        return 'WXYZ';
      case 9:
        return '';
      case 10:
        return '+';
      case 11:
        return '';
      case 12:
        return '';

      default:
    }
  }
}
