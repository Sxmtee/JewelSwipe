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
      "Frosty Smash© is a work of  art created by the Games Team of Digital Dreams Limited.\n Credits go to:\n 1) Mr. Somto Ochiabutor (Game Dev.) \n 2) Mr. Harrison Ilodiuba (UI/UX Designer) \n 3) Mr. Chux Edoga (CEO & Project Manager)\n 4) Mr. Victor Anya (Team Lead)",
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
