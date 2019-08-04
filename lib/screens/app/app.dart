import 'package:burger_city_flutter/components/cart_button.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/screens/burgers/burgers.dart';
import 'package:burger_city_flutter/screens/favourites/favourites.dart';
import 'package:burger_city_flutter/screens/home/home.dart';
import 'package:burger_city_flutter/screens/track_orders/track_orders.dart';
import 'package:burger_city_flutter/screens/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppScreenState();
  }
}

class AppScreenState extends State<AppScreen> {
  List<Widget> pages = [
    HomeScreen(),
    BurgersScreen(),
    FavouritesScreen(),
    TrackOrdersScreen(),
    WalletScreen()
  ];
  PageController pageController = PageController();
  PageView pageView;
  int currentPage = 0;

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
          buildNavigationBarIcon('assets/icons/home.svg', 0, 'Home'),
          buildNavigationBarIcon('assets/icons/burgers.svg', 1, 'Our Burgers'),
          buildNavigationBarIcon('assets/icons/star.svg', 2, 'Favourites'),
          buildNavigationBarIcon('assets/icons/track.svg', 3, 'Track Orders'),
          buildNavigationBarIcon('assets/icons/wallet.svg', 4, 'Wallet'),
        ],
      ),
    );
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
              setState(() {
                currentPage = index;
              });
              pageController.jumpToPage(index);
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
    pageView = PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: pageView, bottomNavigationBar: buildMenu());
  }
}
