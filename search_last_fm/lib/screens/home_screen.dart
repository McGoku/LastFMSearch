import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_last_fm/providers/home_screen_provider.dart';
import 'package:search_last_fm/widgets/results_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("Search LastFM"),
          ),
          backgroundColor: Color(0xFF2B2B2B),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 48,
                    child: CupertinoTextField(
                      controller: provider.controller,
                      focusNode: provider.focusNode,
                      textInputAction: TextInputAction.search,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                      ),
                      suffix: (provider.controller.text.isNotEmpty)
                          ? InkWell(
                              onTap: () {
                                provider.clearText();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : Container(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(28),
                        ),
                        // color: Color(0xFF2B2B2B),
                        color: Colors.white,
                      ),
                      placeholder: "search for songs",
                      placeholderStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.red,
                      ),
                      onChanged: (input) {
                        provider.rebuild();
                      },
                      onSubmitted: (String txt) {
                        // provider.search();
                      },
                    ),
                  ),
                  Container(
                    height: 32,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      tabs: [
                        Tab(text: "Album"),
                        Tab(text: "Song"),
                        Tab(text: "Artist"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ResultsWidget(type: Tabs.Album),
                        ResultsWidget(type: Tabs.Song),
                        ResultsWidget(type: Tabs.Artist),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
