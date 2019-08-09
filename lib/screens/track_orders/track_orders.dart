import 'package:burger_city_flutter/components/loader.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:scoped_model/scoped_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrackOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TrackOrdersScreenState();
  }
}

class TrackOrdersScreenState extends State<TrackOrdersScreen> {
  static Store of(context) => ScopedModel.of(context);
  bool isInitialized = false;
  String map;
  Map<String, double> coordinates;

  WebViewController webViewController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      init();
    }
  }

  init() async {
    await loadMap();
    await getCoordinates();
    prepareMap();

    setState(() {
      isInitialized = true;
    });
  }

  loadMap() async {
    map = await rootBundle.loadString('assets/map.html');
  }

  getCoordinates() async {
    Store store = of(context);

    try {
      coordinates =
          await store.getCoordinates(store.order.addressDescription.title);
    } catch (e) {
      print(e);
    }
  }

  prepareMap() {
    Store store = of(context);

    map = map.replaceFirst('LATITUDE', coordinates['latitude'].toString())
        .replaceFirst('LONGITUDE', coordinates['longitude'].toString())
        .replaceFirst('API_KEY', store.config.apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return isInitialized
        ? WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) async {
              print(await controller.currentUrl());
              webViewController = controller;
            },
            initialUrl:
                Uri.dataFromString(map, mimeType: 'text/html').toString(),
          )
        : Center(child: Loader());
  }
}
