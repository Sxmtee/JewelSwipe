import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/constants/sizes.dart';

class Ranks extends StatefulWidget {
  final Future<List<dynamic>> ranks;
  const Ranks({super.key, required this.ranks});

  @override
  State<Ranks> createState() => _RanksState();
}

class _RanksState extends State<Ranks> {
  @override
  Widget build(BuildContext context) {
    Sizes().init(context);
    return FutureBuilder(
      future: widget.ranks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(
              color: Color(0XFF005785),
              radius: 50,
            ),
          );
        } else if (snapshot.hasData) {
          final list = snapshot.data!
            ..sort(
              (e1, e2) => int.parse(e2['score']).compareTo(
                int.parse(e1['score']),
              ),
            );
          return ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.sWidth * 2.8,
                  vertical: Sizes.sHeight * 0.63,
                ),
                child: Card(
                  color: const Color(0XFF005785),
                  shape: const StadiumBorder(),
                  elevation: 10,
                  child: ListTile(
                    leading: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Color(0XFF74e2fb),
                        fontSize: 17,
                        fontFamily: "Poppins",
                      ),
                    ),
                    title: Text(
                      "${list[index]['username']}",
                      style: const TextStyle(
                        color: Color(0XFF74e2fb),
                        fontSize: 17,
                        fontFamily: "Poppins",
                      ),
                    ),
                    trailing: Text(
                      "${list[index]['score']}",
                      style: const TextStyle(
                        color: Color(0XFF74e2fb),
                        fontSize: 17,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "No Connection",
              style: TextStyle(
                fontSize: 35,
                fontFamily: "Poppins",
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "No Data",
              style: TextStyle(
                fontSize: 35,
                fontFamily: "Poppins",
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
