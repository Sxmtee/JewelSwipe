import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jewelswipe/JewelSwipe/Gameview/Widgets/leaderboard/ranks.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  String filter = "null";
  late Future<List<dynamic>> refresh;

  Future<List<dynamic>> getRanking(String filter) async {
    var uri = Uri.parse(
        "http://cbtportal.linkskool.com/api/get_leaderboard.php?game_type=JewelSmash&period=$filter");
    // {daily, week, null}
    List<dynamic> results = [];
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      results = jsonDecode(response.body);
    }
    return results;
  }

  @override
  void initState() {
    refresh = getRanking(filter);
    super.initState();
  }

  Future<void> onNull() async {
    setState(() {
      refresh = getRanking("null");
    });
  }

  Future<void> onDaily() async {
    setState(() {
      refresh = getRanking("daily");
    });
  }

  Future<void> onWeekly() async {
    setState(() {
      refresh = getRanking("week");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const TabBar(
            indicatorColor: Color(0XFFf09102),
            indicatorWeight: 4,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            tabs: [
              Tab(
                text: 'All Time',
              ),
              Tab(
                text: 'Weekly',
              ),
              Tab(
                text: 'Daily',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
              onRefresh: onNull,
              child: Ranks(
                ranks: getRanking("null"),
              ),
            ),
            RefreshIndicator(
              onRefresh: onWeekly,
              child: Ranks(
                ranks: getRanking("week"),
              ),
            ),
            RefreshIndicator(
              onRefresh: onDaily,
              child: Ranks(
                ranks: getRanking("daily"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
