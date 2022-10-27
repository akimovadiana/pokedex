import 'package:flutter/material.dart';
import 'package:pokedex/config/colors.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({
    Key? key,
    this.name,
    required this.onTap,
  }) : super(key: key);

  final String? name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorList.transparentBlack,
          border: Border.all(
            color: ColorList.black,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            name!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
