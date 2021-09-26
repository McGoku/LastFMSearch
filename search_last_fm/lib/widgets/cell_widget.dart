import 'package:flutter/material.dart';
import 'package:search_last_fm/model/base_model.dart';
import 'package:search_last_fm/screens/details_screen.dart';

class CellWidget extends StatelessWidget {
  final BaseModel model;

  const CellWidget({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        color: Color(0xFF434343),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(model: model)));
          },
          child: Row(
            children: [
              Container(
                width: 100,
                child: Image.network(
                  model.imageURL,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        model.title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        model.subtitle,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
