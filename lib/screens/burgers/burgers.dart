import 'package:burger_city_flutter/components/custom_chip.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/loader.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/constants/routes.dart';
import 'package:burger_city_flutter/models/burger.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BurgersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BurgersScreenState();
  }
}

class BurgersScreenState extends State<BurgersScreen> {
  bool isLoading = false;
  List<Burger> burgers = [];

  static Store of(BuildContext context) => ScopedModel.of<Store>(context);

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    showLoader();
    await this.fetchBurgers();
    hideLoader();
  }

  showLoader() {
    setState(() {
      isLoading = true;
    });
  }

  hideLoader() {
    setState(() {
      isLoading = false;
    });
  }

  fetchBurgers() async {
    Store store = of(context);

    try {
      await store.fetchBurgers();
    } catch (e) {
      print(e);
    }
  }

  Widget buildList() {
    Store store = of(context);

    return ListView.builder(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        itemCount: store.burgers.length,
        itemBuilder: (context, index) {
          bool isLast = index == store.burgers.length - 1;

          return buildListItem(store.burgers[index], isLast);
        });
  }

  Widget buildListItem(Burger burger, bool isLast) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
      height: 86,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            spreadRadius: 8,
            blurRadius: 15,
            offset: const Offset(0, 8))
      ], color: Colors.white),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Store store = of(context);
            store.setCurrentBurger(burger);
            Navigator.of(context).pushNamed(Routes.CUSTOMIZE);
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 4),
                width: 80,
                height: 50,
                child: Hero(
                  tag: burger.id.toString(),
                  child: Image.asset(burger.imageUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      burger.name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.MAIN_DARK_COLOR),
                    ),
                  ),
                  Text(
                    '${burger.price.toString()} \$',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.MAIN_COLOR),
                  ),
                ],
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: CustomChip(
                    child: Container(
                        margin: EdgeInsets.only(left: 2),
                        child: Image.asset('assets/icons/chevron.png'))),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Loader(),
            )
          : buildList(),
    );
  }
}
