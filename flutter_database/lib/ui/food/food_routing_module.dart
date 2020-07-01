
 import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdatabase/di/dependency_injection.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_bloc.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_event.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';
import 'package:flutterdatabase/ui/food/ui/add_food.dart';
import 'package:flutterdatabase/ui/food/ui/main_screen.dart';
import 'package:flutterdatabase/ui/food/ui/update_food.dart';
import 'package:flutterdatabase/ui/food/ui/view_food.dart';

class FoodModule{
  static  String routeAddFood="/addFood";
  static  String routeUpdateFood="/updateFood";
  static String routeMainScreenFood="/mainScreen";
  static String routeViewDetails="/viewDetails";

  static registerRoutes(Router router){
   router.define(routeAddFood,transitionType: TransitionType.fadeIn, handler: Handler(handlerFunc: (BuildContext context,Map<String,dynamic> params){
     return AddFoods();
//       BlocProvider(
//       create: (context)=>sl<FoodBloc>(),
//       child: AddFoods(),
//     );
   }));

   router.define(routeMainScreenFood,transitionType: TransitionType.fadeIn, handler: Handler(handlerFunc: (BuildContext context,Map<String,dynamic> params){
     return MainScreen();
   }));

   router.define(routeViewDetails, transitionType: TransitionType.fadeIn, handler: Handler(handlerFunc: (BuildContext context,Map<String,dynamic> params){
     final args=ModalRoute.of(context).settings.arguments as Food;
     return ViewFood(args);
//       BlocProvider(
//       create: (context)=>sl<FoodBloc>(),
//       child:ViewFood(args),
//     );
   }));

   router.define(routeUpdateFood, transitionType: TransitionType.fadeIn, handler: Handler(handlerFunc: (BuildContext context,Map<String,dynamic> params){
     final args=ModalRoute.of(context).settings.arguments as Food;
     return  UpdateFoods(args);
//       BlocProvider(
//       create: (context)=>sl<FoodBloc>(),
//       child: UpdateFoods(args),
//     );
   }));

  }
 }