import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:pokedex/home/presentation/view_model/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModelImpl homeModel;

  @override
  void initState() {
    homeModel = GetIt.I.get()..getPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: StreamBuilder(
        stream: homeModel.dataStream,
        builder: (context, AsyncSnapshot<ContentModel?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.results?.isNotEmpty ?? false) {
              final List<PokemonModel> results = snapshot.data!.results!;
              return Scaffold(
                persistentFooterButtons: [
                  IconButton(
                    enableFeedback:
                        snapshot.data?.previous?.isNotEmpty ?? false,
                    onPressed: () {
                      homeModel.getPage(false);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  IconButton(
                    enableFeedback: snapshot.data?.next?.isNotEmpty ?? false,
                    onPressed: homeModel.getPage,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
                body: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${results[index].name}'),
                    );
                  },
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
