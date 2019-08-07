import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final List<String> options;
  final int selectedOptionIndex;
  final Function onOptionSelect;

  SelectButton(this.options, this.selectedOptionIndex, this.onOptionSelect);

  Widget buildOption(int index, String option) {
    bool isOptionSelected = selectedOptionIndex == index;

    return Expanded(
      child: Material(
        color: isOptionSelected ? AppColors.MAIN_COLOR : Colors.white,
        child: InkWell(
          onTap: () {
            if (isOptionSelected) {
              return;
            }

            onOptionSelect(index);
          },
          child: Container(
            child: Center(
              child: Text(option,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: isOptionSelected
                          ? Colors.white
                          : AppColors.MAIN_DARK_COLOR)),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildOptions() {
    List<Widget> optionList = [];

    options.asMap().forEach((index, option) {
      optionList.add(buildOption(index, option));
    });

    return optionList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0), spreadRadius: 8, blurRadius: 15)
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: buildOptions(),
          ),
        ),
      ),
    );
  }
}
