import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Function onTap;

  Button({this.text, this.isLoading = false, this.onTap});

  _onTap() {
    if (isLoading) {
      return;
    }

    onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Material(
        elevation: 5,
        color: AppColors.MAIN_COLOR,
        child: InkWell(
          onTap: _onTap,
          child: Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Opacity(
                      opacity: isLoading ? 1 : 0,
                      child: Center(
                        child: Container(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 3,
                            )),
                      )),
                ),
                Opacity(
                  opacity: isLoading ? 0 : 1,
                  child: Center(
                    child: Text(
                      this.text,
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
