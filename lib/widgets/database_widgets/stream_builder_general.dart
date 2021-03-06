import 'package:cityprog/handlers/message_handler.dart';
import 'package:cityprog/widgets/lists/newsItem.dart';
import 'package:flutter/material.dart';
import '../database_model/database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cityprog/strings/string_provider.dart' show Language;
import 'package:cityprog/current_language.dart';
import 'package:cityprog/widgets/lists/eventListItem.dart';
import 'package:cityprog/widgets/lists/helpListItem.dart';
import 'package:cityprog/widgets/lists/notificationItem.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:cityprog/widgets/weather/current_weather_item.dart';

// Fetch all data, create UI elements and display them on the main screen. See also general_feed.dart.

var connectOK = false;

class StreamBuilderGeneral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: Database().getHelps(),
            builder: (context, snapshot1) {
              return StreamBuilder(
                  stream: Database().getCollection('Tapahtumat'),
                  builder: (context, snapshot2) {
                    return StreamBuilder(
                      stream: Database().getCollection('Ilmoitukset'),
                      builder: (context, snapshot3) {
                        if (!snapshot1.hasData &&
                            !snapshot2.hasData &&
                            !snapshot3.hasData) return const Text('Loading..');
                        return ListViewBuilder(
                            snapshot1.data
                                .documents, // Pass 'Apupalvelu' document results
                            snapshot1.data.documents.length,
                            snapshot2.data
                                .documents, // Pass 'Tapahtuma' document results
                            snapshot2.data.documents.length,
                            snapshot3.data.documents,
                            snapshot3.data.documents.length);
                      },
                    );
                  });
            }),
      ),
    );
  }
}

class ListViewBuilder extends StatefulWidget {
  final helpData;
  final helpDataLength;
  final eventData;
  final eventDataLength;
  final notificationData;
  final notificationDataLength;

  ListViewBuilder(this.helpData, this.helpDataLength, this.eventData,
      this.eventDataLength, this.notificationData, this.notificationDataLength);

  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  Future<dynamic> _future;

  _fetchIds() async {
    if (kIsWeb) {
      connectOK = true;
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        connectOK = true;
      }
    }
    String language;
    if (CurrentLanguage.value == Language.FI) {
      language = '1';
    } else {
      language = '2';
    }
    String url;
    if (kIsWeb) {
      url =
          'https://cors-anywhere.herokuapp.com/https://www.espoo.fi/api/opennc/v1/ContentLanguages($language)/Contents?\$filter=TemplateId%20eq%209&\$orderby=PublicDate%20desc&\$format=json';
    } else {
      url =
          'https://www.espoo.fi/api/opennc/v1/ContentLanguages($language)/Contents?\$filter=TemplateId%20eq%209&\$orderby=PublicDate%20desc&\$format=json';
    }

    List<String> contentList20 = [];
    if (connectOK) {
      connectOK = false;
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        var i = 0;
        while (i < 20) {
          contentList20.add(json['value'][i]['ContentId'].toString());
          i++;
        }
        //print(contentList20);
        return contentList20;
      } else {
        throw Exception('Failed to load resources');
      }
    }
  }

  @override
  void initState() {
    _future = _fetchIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fetchIds();
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 60),
          itemCount: widget.eventDataLength +
              widget.helpDataLength +
              widget.notificationDataLength +
              8, //+1 for weather card + 7 for news
          itemBuilder: (BuildContext _context, index) {
            return Column(
              children: <Widget>[
                if (!kIsWeb) MessageHandler(),
                if (index == 0)
                  Column(
                    children: <Widget>[
                      CurrentWeatherCard(),
                      Padding(
                        padding: EdgeInsets.all(11),
                      ),
                    ],
                  ),
                if (index < 7) _buildNewsItem(context, index),
                if (index <= widget.helpDataLength - 1)
                  Column(
                    children: <Widget>[
                      _buildHelpItem(context, widget.helpData[index]),
                      Padding(
                        padding: EdgeInsets.all(11),
                      ),
                    ],
                  ),
                if (index <= widget.eventDataLength - 1)
                  Column(
                    children: <Widget>[
                      _buildListItem(context, widget.eventData[index]),
                      Padding(
                        padding: EdgeInsets.all(11),
                      ),
                    ],
                  ),
                if (index <= widget.notificationDataLength - 1)
                  Column(
                    children: <Widget>[
                      NotificationListTile(widget.notificationData[index]),
                      Padding(
                        padding: EdgeInsets.all(11),
                      ),
                    ],
                  )
              ],
            );
          }),
    );
  }

  Widget _buildHelpItem(BuildContext context, index) {
    return HelpListTile(index);
  }

  Widget _buildListItem(BuildContext context, index) {
    return EventListTile(index);
  }

  Widget _buildNewsItem(BuildContext context, index) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              CurrentNewsCard(contentId: snapshot.data[index]),
              Padding(
                padding: EdgeInsets.all(11),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
