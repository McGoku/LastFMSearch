import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
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
                  child: Text(
                    "To search type in search field",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    maxLines: 2,
                  ),
                );
                break;
              case ResultsState.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ResultsState.results:
                return Center(
                  child: LoadMore(
                    isFinish: provider.isAllLoaded,
                    onLoadMore: provider.loadMore,
                    child: ListView.builder(
                      itemCount: provider.results.length,
                      itemBuilder: (context, index) {
                        return CellWidget(model: provider.results[index]);
                      },
                    ),
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                  ),
                );
                break;
              case ResultsState.noResults:
                return Center(
                  child: Text(
                    "No results for search term",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    maxLines: 2,
                  ),
                );
                break;
              case ResultsState.error:
                return Center(
                  child: Text(
                    "There was an error while trying to contact database",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    maxLines: 2,
                  ),
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
