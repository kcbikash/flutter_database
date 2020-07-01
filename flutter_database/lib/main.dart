
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdatabase/di/dependency_injection.dart';
import 'package:flutterdatabase/routing/routing.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_bloc.dart';
import 'package:flutterdatabase/ui/food/ui/main_screen.dart';

void main() async{
  await init();
  runApp(App());
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 350,height: 600,allowFontScaling: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Database app",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: Routing().buildRoute().generator,
      home: BlocProvider(
        create:(_)=> sl<FoodBloc>(),
        child: MainScreen(),
      ),
    );
  }

}