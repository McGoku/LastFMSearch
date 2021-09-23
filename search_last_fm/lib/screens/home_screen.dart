import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_last_fm/providers/home_screen_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: DefaultTabController(
                length: 3,
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
                        children: [
                          Icon(Icons.directions_car),
                          Icon(Icons.directions_transit),
                          Icon(Icons.directions_bike),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
