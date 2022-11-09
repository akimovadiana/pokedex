import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:pokedex/config/colors.dart';
import 'package:simple_shadow/simple_shadow.dart';

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
    final NetworkImage img = NetworkImage(image);

    return ImagePixels(
      imageProvider: img,
      builder: (BuildContext context, ImgDetails img) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [
                ColorList.white,
                img.pixelColorAtAlignment!(Alignment.center),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: ColorList.transparent,
            body: Column(
              children: [
                SizedBox(
                  height: 150,
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
                            top: -200,
                            child: SimpleShadow(
                              child: Image.network(
                                image,
                                height: 300,
                                fit: BoxFit.fitHeight,
                              ),
                              offset: Offset(5,5),
                              sigma: 10,
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
      },
    );
  }
}