import 'package:flutter/material.dart';
import 'package:pokedex/config/colors.dart';

class InfoUI extends StatelessWidget {
  const InfoUI({
    Key? key,
    required this.child,
    required this.name,
    required this.image,
  }) : super(key: key);

  final Widget child;
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.centerRight,
          colors: [
            ColorList.lightBlue,
            ColorList.blue,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: ColorList.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 48,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.passthrough,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
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
                      Positioned(
                        top: -100,
                        child: Image.network(
                          image,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
