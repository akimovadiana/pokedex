import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/config/colors.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:pokedex/info/presentation/ui/custom_info.dart';
import 'package:pokedex/info/presentation/view_model/info_view_model.dart';

class InfoPage extends StatefulWidget {
  const InfoPage(this.pokemonModel, {Key? key}) : super(key: key);

  final PokemonModel pokemonModel;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late InfoViewModel infoModel;

  @override
  void initState() {
    infoModel = GetIt.I.get()..getInfo(widget.pokemonModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: StreamBuilder(
        stream: infoModel.dataStream,
        builder: (context, AsyncSnapshot<PokemonModel?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.url?.isNotEmpty ?? false) {
              final PokemonModel pokemonInfo = snapshot.data!;
              return CustomInfo(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      pokemonInfo.types?.length ?? 0,
                      (index) => Column(
                        children: [
                          Text(
                            'Pokemon type: ${pokemonInfo.types?[index]}',
                            style: TextStyle(
                              color: ColorList.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Pokemon weight: ${pokemonInfo.weight} kg',
                      style: TextStyle(
                        color: ColorList.white,
                      ),
                    ),
                    Text(
                      'Pokemon height: ${pokemonInfo.height} cm',
                      style: TextStyle(
                        color: ColorList.white,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text('Error: something went wrong');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
