import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/core/const/app_colors.dart';
import 'package:pokedex/core/const/other.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/home/home_bloc.dart';
import 'package:pokedex/presentation/info_card/info_card_bloc.dart';
import 'package:pokedex/presentation/info_card/info_card_page.dart';
import 'package:pokedex/presentation/widget/menu_item.dart';
import 'package:pokedex/util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IHomeBloc bloc;

  // late DBHelper database;

  final scrollController = ScrollController();
  bool isLoading = false;
  final notifier = CustomNotifier();

  @override
  void initState() {
    bloc = Get.find()..getPokemons();
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
      ),
      body: StreamBuilder(
        stream: bloc.dataStream,
        builder: (context, AsyncSnapshot<List<PokemonEntity>?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.lightBlue,
                      AppColors.blue,
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

  Widget buildList(List<PokemonEntity> results) => GridView.builder(
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
          return MenuItem(
            onTap: () {
              Get.find<IInfoCardBloc>().getInfo(results[index]);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => InfoCardPage(),
                ),
              );
            },
            name: results[index].name ?? Other.onEmptyString,
          );
        },
      );

  void onScroll() {
    if (!isLoading && scrollController.position.extentAfter < 100) {
      isLoading = true;
      notifier.notify();
      bloc.getPokemons().then((_) {
        isLoading = false;
        notifier.notify();
      });
    }
  }
}
