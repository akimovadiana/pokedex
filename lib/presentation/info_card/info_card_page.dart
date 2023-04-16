import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:pokedex/core/const/app_colors.dart';
import 'package:pokedex/core/const/assets.dart';
import 'package:pokedex/domain/entity/pokemon_info_entity.dart';
import 'package:pokedex/presentation/info_card/info_card_bloc.dart';
import 'package:simple_shadow/simple_shadow.dart';

class InfoCardPage extends StatefulWidget {
  @override
  State<InfoCardPage> createState() => _InfoCardPageState();
}

class _InfoCardPageState extends State<InfoCardPage> {
  late IInfoCardBloc bloc;

  @override
  void initState() {
    bloc = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          size: 30,
        ),
      ),
      body: StreamBuilder(
        stream: bloc.dataStream,
        builder: (context, AsyncSnapshot<PokemonInfoEntity?> snapshot) {
          if (snapshot.hasData) {
            final Size size = MediaQuery.of(context).size;
            final PokemonInfoEntity pokemonInfoEntity = snapshot.data!;
            final NetworkImage img = NetworkImage('${pokemonInfoEntity.image}');

            return ImagePixels(
              imageProvider: img,
              builder: (BuildContext context, ImgDetails img) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.white,
                        img.pixelColorAtAlignment!(Alignment.center),
                      ],
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 130, left: 10, right: 10),
                          child: Container(
                            alignment: Alignment.topCenter,
                            width: MediaQuery.of(context).size.width,
                            child: SimpleShadow(
                              child: Text(
                                '${pokemonInfoEntity.name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 48,
                                ),
                              ),
                              offset: Offset(5, 5),
                              sigma: 10,
                              opacity: 0.7,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          fit: StackFit.passthrough,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 360,
                              width: size.width,
                              decoration: const BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(35),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 150, 50, 50),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildParam('Type'),
                                        buildParam('Weight'),
                                        buildParam('Height'),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ...(pokemonInfoEntity.types ?? [])
                                              .map(buildParamValue),
                                          buildParamValue(
                                              '${pokemonInfoEntity.weight} kg'),
                                          buildParamValue(
                                              '${pokemonInfoEntity.height} cm'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: -200,
                              child: SimpleShadow(
                                child: Image.network(
                                  '${pokemonInfoEntity.image}',
                                  errorBuilder: (_, __, ___) =>
                                      Image.asset(Assets.launchIcon),
                                  height: 300,
                                  fit: BoxFit.fitHeight,
                                ),
                                offset: Offset(5, 5),
                                sigma: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildParam(String name) => Text(
        '$name:',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget buildParamValue(String value) => Text(
        '$value',
        style: TextStyle(
          color: AppColors.white,
        ),
      );
}
