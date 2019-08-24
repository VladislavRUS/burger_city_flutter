import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/loader.dart';
import 'package:burger_city_flutter/components/title_text.dart';
import 'package:burger_city_flutter/models/coordinates.dart';
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

class TrackOrdersScreenState extends State<TrackOrdersScreen>
    with SingleTickerProviderStateMixin {
  static Store of(context) => ScopedModel.of(context);
  bool isInitialized = false;
  bool useFakeMap = false;
  String map;
  Coordinates coordinates;
  Animation<double> animation;
  AnimationController animationController;

  WebViewController webViewController;
  Widget body;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      init();
    }
  }

  init() async {
    Store store = of(context);

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(animationController);

    if (store.confirmedOrder == null) {
      body = buildEmptyPlaceholder();
    } else {
      await loadMap();
      await getCoordinates();

      if (useFakeMap) {
        body = SizedBox.expand(child: Image.asset('assets/images/fake-map.png', fit: BoxFit.fitWidth,));
      } else {
        prepareMap();
        body = buildWebView();
      }
    }

    setState(() {
      isInitialized = true;
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  loadMap() async {
    map = await rootBundle.loadString('assets/map.html');
  }

  getCoordinates() async {
    Store store = of(context);

    try {
      coordinates = await store
          .getCoordinates(store.confirmedOrder.addressDescription.title);
    } catch (e) {
      setState(() {
        useFakeMap = true;
      });
      print(e);
    }
  }

  prepareMap() {
    Store store = of(context);

    map = map
        .replaceFirst('LATITUDE', coordinates.latitude.toString())
        .replaceFirst('LONGITUDE', coordinates.longitude.toString())
        .replaceFirst('API_KEY', store.config.apiKey);
  }

  Widget buildWebView() {
    return (WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) async {
        webViewController = controller;
      },
      initialUrl: Uri.dataFromString(map, mimeType: 'text/html').toString(),
    ));
  }

  Widget buildEmptyPlaceholder() {
    return Center(child: TitleText(translate('trackOrders.empty')));
  }

  @override
  Widget build(BuildContext context) {
    return isInitialized
        ? FadeTransition(
            opacity: animation,
            child: body,
          )
        : Center(child: Loader());
  }
}
