import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:search_last_fm/providers/home_screen_provider.dart';
import 'package:search_last_fm/services/search_service.dart';
import 'package:search_last_fm/widgets/results_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  FocusNode _focusNode;
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(listenTab);
    SearchService.instance.activeTab = Tabs.album;
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _tabController.removeListener(listenTab);
    _tabController.dispose();
    super.dispose();
  }

  void listenTab() {
    SearchService.instance.activeTab = Tabs.values[_tabController.index];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeScreenProvider(),
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
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
                    child: Consumer<HomeScreenProvider>(
                      builder: (context, provider, child) {
                        return CupertinoTextField(
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          textInputAction: TextInputAction.search,
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                          ),
                          suffix: (provider.shouldShowX)
                              ? InkWell(
                                  onTap: () {
                                    provider.clearText(_textEditingController);
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
                          placeholder: "search",
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
                            provider.changeText(input);
                          },
                          onSubmitted: (String txt) {
                            provider.submit(txt);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 32,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      tabs: [
                        for (var category in Tabs.values)
                          Tab(
                            text: getTitleFor(category),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ResultsWidget(type: Tabs.album),
                        ResultsWidget(type: Tabs.song),
                        ResultsWidget(type: Tabs.artist),
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

  String getTitleFor(Tabs tab) {
    switch (tab) {
      case Tabs.album:
        return "Album";
      case Tabs.artist:
        return "Artist";
      case Tabs.song:
        return "Song";
      default:
        return "";
    }
  }
}
