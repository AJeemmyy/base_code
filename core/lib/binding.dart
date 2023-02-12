import 'package:core/networking/network_handler.dart';
import 'package:core/storage/preference_manager.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;


void setup(){
  getIt.registerLazySingleton<NetworkHandler>(() => NetworkHandler());
  getIt.registerLazySingleton<PreferenceManager>(() => PreferenceManager());
}

