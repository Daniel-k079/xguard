import 'package:flutter/material.dart';

class CameraHeader extends StatelessWidget {
  const CameraHeader(this.title, {Key? key, this.onBackPressed})
      : super(key: key);
  final String title;
  final void Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.black, Colors.transparent],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 60.0,
            ),
            Row(
              children: [
                InkWell(
                  onTap: onBackPressed,
                  child: const Center(
                      child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Text(
              'TIP: Keep the same pose, when setting up this feature and when scanning in ',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
