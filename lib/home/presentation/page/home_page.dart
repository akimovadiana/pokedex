import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/config/colors.dart';

// import 'package:pokedex/database/db_helper.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:pokedex/home/presentation/page/search_page.dart';
import 'package:pokedex/home/presentation/ui/home_ui.dart';
import 'package:pokedex/home/presentation/view_model/home_view_model.dart';
import 'package:pokedex/info/presentation/page/info_page.dart';
import 'package:pokedex/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel homeModel;

  // late DBHelper database;

  final scrollController = ScrollController();
  bool isLoading = false;
  final notifier = CustomNotifier();

  @override
  void initState() {
    homeModel = GetIt.I.get()..getPokemons();
    // database = GetIt.I.get();
    scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchPage()),
            ),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: homeModel.dataStream,
        builder: (context, AsyncSnapshot<List<PokemonModel>?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorList.lightBlue,
                      ColorList.blue,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: buildList(snapshot.data!),
                    ),
                    if (isLoading)
                      AnimatedBuilder(
                          animation: notifier,
                          builder: (context, _) {
                            return isLoading
                                ? CircularProgressIndicator()
                                : SizedBox.shrink();
                          }),
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

  Widget buildList(List<PokemonModel> results) => GridView.builder(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shrinkWrap: true,
        itemCount: results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return HomeUI(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => InfoPage(results[index]),
                ),
              );
            },
            name: results[index].name,
          );
        },
      );

  void onScroll() {
    if (!isLoading && scrollController.position.extentAfter < 100) {
      isLoading = true;
      notifier.notify();
      homeModel.getPokemons().then((_) {
        isLoading = false;
        notifier.notify();
      });
    }
  }
}
