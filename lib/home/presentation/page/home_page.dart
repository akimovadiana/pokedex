import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/database/db_helper.dart';
import 'package:pokedex/home/data/model/pokemon_model.dart';
import 'package:pokedex/home/presentation/ui/custom_grid.dart';
import 'package:pokedex/home/presentation/view_model/home_view_model.dart';
import 'package:pokedex/info/presentation/page/info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel homeModel;
  late DBHelper database;

  @override
  void initState() {
    homeModel = GetIt.I.get()..getPage();
    database = GetIt.I.get();
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
          if (snapshot.hasData || snapshot.error.runtimeType == List<dynamic>) {
            if (snapshot.hasError &&
                    (snapshot.error as List<dynamic>).isNotEmpty ||
                (snapshot.data!.results?.isNotEmpty ?? false)) {
              List<dynamic> results = [];
              if (snapshot.hasData) {
                results = snapshot.data!.results!;
              } else if (snapshot.hasError) {
                results = snapshot.error as List<dynamic>;
              }
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
                body: buildList(results),
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

  Widget buildList(List<dynamic> results) => GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shrinkWrap: true,
        itemCount: results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return CustomGrid(
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
