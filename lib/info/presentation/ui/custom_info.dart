import 'package:flutter/material.dart';
import 'package:pokedex/config/colors.dart';

class CustomInfo extends StatelessWidget {
  const CustomInfo({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Expanded(
            child: Text(
              '',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 48,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 360,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: ColorList.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  child: Center(
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
