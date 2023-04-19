import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/core/const/app_colors.dart';
import 'package:pokedex/core/const/other.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/home/home_bloc.dart';
import 'package:pokedex/presentation/info_card/info_card_bloc.dart';
import 'package:pokedex/presentation/info_card/info_card_page.dart';
import 'package:pokedex/presentation/widget/menu_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IHomeBloc bloc;

  @override
  void initState() {
    bloc = Get.find()..getPokemons();
    super.initState();
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
                child: Scaffold(
                  backgroundColor: AppColors.transparent,
                  persistentFooterButtons: [
                    buildPages(),
                  ],
                  body: buildList(snapshot.data!),
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

  Widget buildPages() {
    return StreamBuilder(
        stream: bloc.pageCountStream,
        builder: (context, AsyncSnapshot<int?> snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                IconButton(
                  onPressed: bloc.toPreviousPage,
                  icon: Icon(
                    Icons.arrow_back,
                    color: bloc.currentPage == 0
                        ? AppColors.lightGrey
                        : AppColors.black,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${bloc.currentPage + 1}/${snapshot.data}',
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: bloc.toNextPage,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: bloc.currentPage + 1 == snapshot.data
                        ? AppColors.lightGrey
                        : AppColors.black,
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        });
  }
}
