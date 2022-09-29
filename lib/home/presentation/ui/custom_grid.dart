import 'package:flutter/material.dart';
import 'package:pokedex/config/colors.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({
    Key? key,
    this.image,
    this.name,
    required this.onTap,
  }) : super(key: key);

  final String? image;
  final String? name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              ColorList.lightGrey,
              ColorList.darkGrey,
            ],
          ),
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
