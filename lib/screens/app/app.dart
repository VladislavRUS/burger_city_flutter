import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/constants/app_pages.dart';
import 'package:burger_city_flutter/screens/burgers/burgers.dart';
import 'package:burger_city_flutter/screens/home/home.dart';
import 'package:burger_city_flutter/screens/track_orders/track_orders.dart';
import 'package:burger_city_flutter/screens/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';

class AppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppScreenState();
  }
}

class AppScreenState extends State<AppScreen> {
  List<Widget> pages;
  PageController pageController = PageController();
  PageView pageView;
  int currentPage = AppPages.HOME;
  bool isLoaded = false;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  Widget buildMenu() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromARGB(60, 0, 0, 0), blurRadius: 10, spreadRadius: 2)
      ]),
      height: 87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildNavigationBarIcon(
              'assets/icons/home.svg', AppPages.HOME, translate('app.home')),
          buildNavigationBarIcon('assets/icons/burgers.svg', AppPages.BURGERS,
              translate('app.burgers')),
          buildNavigationBarIcon('assets/icons/track.svg',
              AppPages.TRACK_ORDERS, translate('app.trackOrders')),
          buildNavigationBarIcon('assets/icons/wallet.svg', AppPages.WALLET,
              translate('app.wallet')),
        ],
      ),
    );
  }

  onChangePage(int index) {
    setState(() {
      currentPage = index;
    });
    pageController.jumpToPage(index);
  }

  Widget buildNavigationBarIcon(String iconAsset, int index, String text) {
    Widget svg = SvgPicture.asset(
      iconAsset,
      width: 25,
      height: 25,
      fit: BoxFit.contain,
      color: index == currentPage
          ? AppColors.MAIN_COLOR
          : AppColors.DARK_ICON_COLOR,
    );

    return Expanded(
      child: Container(
        child: Material(
          child: InkWell(
            onTap: () {
              onChangePage(index);
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(bottom: 8), child: svg),
                  Text(
                    text,
                    style: TextStyle(fontSize: 10),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    pages = [
      HomeScreen(
        onChangePage: onChangePage,
      ),
      BurgersScreen(),
      TrackOrdersScreen(),
      WalletScreen()
    ];

    this.init();
  }

  init() {
    pageView = PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: pages,
    );

    SchedulerBinding.instance.addPostFrameCallback((callback) {
      var arguments = ModalRoute.of(context).settings.arguments;

      if (arguments != null) {
        int page = (arguments as Map<String, int>)["activePage"];
        onChangePage(page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: pageView, bottomNavigationBar: buildMenu());
  }
}
