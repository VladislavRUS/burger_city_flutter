import 'package:flutter/material.dart';

class Sticker extends StatelessWidget {
  String title;
  String subtitle;
  Function onTap;

  Sticker(this.title, this.subtitle, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Material(
        color: Colors.black,
        child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: Container(
            height: 98,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 42,
                  height: 51,
                  margin: EdgeInsets.only(left: 33, right: 16),
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        this.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(this.subtitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
