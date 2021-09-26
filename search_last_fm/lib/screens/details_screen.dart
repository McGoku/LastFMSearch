import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:search_last_fm/model/album_model.dart';
import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/model/song_model.dart';
import 'package:search_last_fm/providers/album_details_provider.dart';
import 'package:search_last_fm/providers/artist_details_provider.dart';
import 'package:search_last_fm/providers/details_provider.dart';
import 'package:search_last_fm/providers/song_details_provider.dart';

class DetailsScreen extends StatefulWidget {
  final BaseModel model;

  const DetailsScreen({Key key, @required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailsProvider>(
      create: (_) {
        if (widget.model is AlbumModel) {
          return AlbumDetailsProvider(widget.model);
        } else if (widget.model is SongModel) {
          return SongDetailsProvider(widget.model);
        } else {
          return ArtistDetailsProvider(widget.model);
        }
      },
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Color(0xFF2B2B2B),
          body: Consumer<DetailsProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.width,
                    child: Image.network(
                      provider.model.imageURL,
                      fit: BoxFit.cover,
                      frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
                        return child;
                      },
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          Text(
                            provider.model.title,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            provider.model.subtitle,
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          const SizedBox(height: 16),
                          ...details(provider),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 0,
                    width: 64,
                    height: 64,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> details(DetailsProvider provider) {
    List<Widget> results;
    switch (provider.state) {
      case DetailsState.loading:
        results = [
          Center(
            child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          )
        ];
        break;
      case DetailsState.error:
        results = [
          Text(
            "there was an error getting more details",
            style: TextStyle(color: Colors.red, fontSize: 18),
          )
        ];
        break;
      case DetailsState.result:
        results = [
          Text(
            provider.model.published,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            provider.model.summary,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ];
        break;
      case DetailsState.disposed:
        results = [Container()];
        break;
    }
    return results;
  }
}
