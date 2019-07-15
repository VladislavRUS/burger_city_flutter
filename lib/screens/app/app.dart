import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppScreenState();
  }
}

class AppScreenState extends State<AppScreen> {
  List<Widget> pages = [HomeScreen()];

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
            onTap: () {},
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
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildMenu(),
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(left: 20),
            width: 45,
            height: 27,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/lang-title.png'))),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Container(
            width: 66,
            height: 22,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/logo-title.png'))),
          ),
        ),
        body: pages[currentPage]);
  }
}
