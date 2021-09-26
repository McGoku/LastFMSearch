import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_last_fm/providers/album_results_provider.dart';
import 'package:search_last_fm/providers/artist_results_provider.dart';
import 'package:search_last_fm/providers/home_screen_provider.dart';
import 'package:search_last_fm/providers/results_provider.dart';
import 'package:search_last_fm/providers/song_results_provider.dart';
import 'package:search_last_fm/widgets/cell_widget.dart';

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
      // ignore: missing_return
      create: (_) {
        switch (widget.type) {
          case Tabs.song:
            return SongResultsProvider();
            break;
          case Tabs.album:
            return AlbumResultsProvider();
            break;
          case Tabs.artist:
            return ArtistResultsProvider();
            break;
        }
      },
      builder: (context, child) {
        return Consumer<ResultsProvider>(
          builder: (context, provider, child) {
            switch (provider.state) {
              case ResultsState.idle:
                return Center(
                  child: Text(provider.state.toString()),
                );
                break;
              case ResultsState.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ResultsState.results:
                return Center(
                  child: ListView(
                    children: [
                      for (var a in provider.results) CellWidget(model: a),
                    ],
                  ),
                );
                break;
              case ResultsState.noResults:
                return Center(
                  child: Text(provider.state.toString()),
                );
                break;
              case ResultsState.error:
                return Center(
                  child: Text(provider.state.toString()),
                );
                break;
              default:
                return Container();
            }
          },
        );
      },
    );
  }
}
