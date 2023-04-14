import 'package:get/get.dart';
import 'package:pokedex/data/data_source/remote_data_source.dart';
import 'package:pokedex/data/interface/i_remote_data_source.dart';
import 'package:pokedex/data/repository/api_repository.dart';
import 'package:pokedex/domain/repository/i_api_repository.dart';
import 'package:pokedex/domain/use_case/get_pokemon_details_use_case.dart';
import 'package:pokedex/domain/use_case/get_pokemons_use_case.dart';
import 'package:pokedex/presentation/home/home_bloc.dart';
import 'package:pokedex/presentation/info_card/info_card_bloc.dart';

abstract class DependencyInjections {
  static void init() {
    Get.put<IRemoteDataSource>(RemoteDataSource());
    Get.put<IApiRepository>(ApiRepository(Get.find()));
    Get.put(GetPokemonsUseCase(Get.find()));
    Get.put(GetPokemonDetailsUseCase(Get.find()));
    Get.put<IHomeBloc>(HomeBloc(Get.find(), Get.find()));
    Get.put<IInfoCardBloc>(InfoCardBloc(Get.find()));
  }
}
