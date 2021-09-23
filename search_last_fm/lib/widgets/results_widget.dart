import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_last_fm/providers/home_screen_provider.dart';
import 'package:search_last_fm/providers/results_provider.dart';

class ResultsWidget extends StatefulWidget {
  final Tabs type;

  const ResultsWidget({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResultsWidgetState();
}

class _ResultsWidgetState extends State<ResultsWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResultsProvider>(
      create: (_) => ResultsProvider(widget.type),
      builder: (context, child) {
        return Consumer<ResultsProvider>(
          builder: (context, provider, child) {
            Color color = Colors.white;
            switch (provider.type) {
              case Tabs.Artist:
                color = Colors.blue;
                break;
              case Tabs.Song:
                color = Colors.yellow;
                break;
              case Tabs.Album:
                color = Colors.green;
                break;
            }
            return Container(
              color: color,
            );
          },
        );
      },
    );
  }
}
