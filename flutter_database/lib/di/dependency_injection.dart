import 'dart:ffi';

import 'package:flutterdatabase/database/database_provider.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_bloc.dart';
import 'package:flutterdatabase/ui/food/food_bloc/repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future init() async{
  sl.registerLazySingleton(() => DatabaseProvider());
  sl.registerLazySingleton<FoodRepository>(() => FoodRepositoryImp(sl()));
  sl.registerLazySingleton(() => FoodBloc(sl()));
  return sl.allReady();
}
