import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameplay/jewel_model.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Screens/Gamescreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JewelModel>(
      create: (_) => JewelModel(),
      lazy: false,
      child: MaterialApp(
        title: 'Jewel Swipe',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0XFF005785),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.transparent,
            errorStyle: TextStyle(height: 0),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
            focusedBorder: defaultInputBorder,
            errorBorder: defaultInputBorder,
          ),
        ),
        home: const GameScreen(),
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0XFF080863),
    width: 1,
  ),
);