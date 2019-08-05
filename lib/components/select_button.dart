import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SelectButtonOption {
  String name;
  String value;

  SelectButtonOption({this.name, this.value});
}

class SelectButton extends StatelessWidget {
  final List<SelectButtonOption> options;
  final SelectButtonOption selectedOption;
  final Function onOptionSelect;

  SelectButton(this.options, this.selectedOption, this.onOptionSelect);

  Widget buildOption(SelectButtonOption option) {
    bool isOptionSelected = selectedOption.value == option.value;

    return Expanded(
      child: Material(
        color: isOptionSelected ? AppColors.MAIN_COLOR : Colors.white,
        child: InkWell(
          onTap: () {
            onOptionSelect(option);
          },
          child: Container(
            child: Center(
              child: Text(option.name,
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

    for (var option in options) {
      optionList.add(buildOption(option));
    }

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
