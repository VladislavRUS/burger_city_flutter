import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/title_text.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';

class SurpriseDialog extends StatefulWidget {
  final String imagePath;
  final String prize;

  SurpriseDialog(this.imagePath, this.prize);

  @override
  State<StatefulWidget> createState() {
    return SurpriseDialogState();
  }
}

class SurpriseDialogState extends State<SurpriseDialog>
    with SingleTickerProviderStateMixin {
  Animation<Offset> slideAnimation;
  Animation<double> scaleAnimation;
  AnimationController animationController;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    slideAnimation = Tween(begin: const Offset(0, 0.5), end: const Offset(0, 0))
        .chain(CurveTween(curve: Curves.ease))
        .animate(animationController);

    scaleAnimation = Tween(begin: 0.6, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(animationController);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromARGB(20, 0, 0, 0),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Container(
            padding: EdgeInsets.only(top: 20),
            width: 300,
            height: 350,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60)),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: 100,
                          height: 100,
                          child: Image.asset(widget.imagePath),
                        ),
                        TitleText(translate('surpriseDialog.congratulations')),
                        Container(
                          margin: EdgeInsets.only(top: 14),
                          width: 215,
                          child: Text(
                            '${translate('surpriseDialog.winPhrase')} ${widget.prize}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 140,
                          child: Button(
                            text: 'OK',
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
