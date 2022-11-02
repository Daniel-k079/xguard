import 'package:xguard/pages/models/user.model.dart';
import 'package:flutter/material.dart';

class SignInSheet extends StatelessWidget {
  const SignInSheet({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Access Granted to ${user.user}.',
                  style: const TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Thank you for using GuardX App',
                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
