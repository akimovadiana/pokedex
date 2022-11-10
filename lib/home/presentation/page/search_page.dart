import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/config/colors.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:pokedex/home/presentation/ui/home_ui.dart';
import 'package:pokedex/home/presentation/view_model/home_view_model.dart';
import 'package:pokedex/info/presentation/page/info_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late HomeViewModel homeModel;

  @override
  void initState() {
    homeModel = GetIt.I.get()..startListen();
    super.initState();
  }

  @override
  void dispose() {
    homeModel.stopListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: StreamBuilder(
        stream: homeModel.searchStream,
        initialData: <PokemonModel>[],
        builder: (context, AsyncSnapshot<List<PokemonModel>?> snapshot) {
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
                SizedBox(height: 20),
                Text(
                  'Find a Pokemon by name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: homeModel.queryController,
                    cursorColor: ColorList.black,
                  ),
                ),
                snapshot.hasData
                    ? Expanded(
                        child: snapshot.data!.isNotEmpty
                            ? buildList(snapshot.data!)
                            : Text('No results were found'),
                      )
                    : homeModel.queryController.value.text.isNotEmpty
                        ? CircularProgressIndicator()
                        : SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildList(List<PokemonModel> results) => GridView.builder(
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
}
