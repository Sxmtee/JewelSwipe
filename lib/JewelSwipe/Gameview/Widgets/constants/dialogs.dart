import 'package:flutter/material.dart';

aboutGame(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Color(0XFF005785),
    title: Text(
      "ABOUT",
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),
    content: Text(
      "Frosty Smash© is a work of  art created by the Games Team of Digital Dreams Limited.\n Credits go to:\n 1) Mr. Anachunam Austine (Game Dev.) \n 2) Mr. Harrison Ilodiuba (UI/UX Designer) \n 3) Mr. Somto Ochiabutor (Game Dev.) \n 4) Mr. Victor Anya (Game Dev.) \n 4) Mr. Chux Edoga (CEO Digital Dreams)",
    ),
  );
  showDialog(
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

adUnavailable(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Color(0XFF005785),
    content: Text(
      "Ad Unavailable, Try again later",
    ),
  );
  showDialog(
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0XFF005785),
      shape: const StadiumBorder(),
      elevation: 10,
      duration: const Duration(seconds: 6),
      dismissDirection: DismissDirection.horizontal,
      content: Text(
        content,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
