import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdatabase/di/dependency_injection.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_bloc.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_event.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_state.dart';
import 'package:flutterdatabase/ui/food/food_routing_module.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';
import 'package:flutterdatabase/utils/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  FoodBloc foodBloc;
  String imgPath = "";

  Future getPath() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    return path;
  }

  setPath(Food food) async{
    imgPath=await getPath();
    imgPath="$imgPath/${food.img_name}.png";
  }


  @override
  void initState() {
    super.initState();
    foodBloc=BlocProvider.of<FoodBloc>(context);
   // foodBloc = sl<FoodBloc>();
    foodBloc.add(GetFoodList());
  }

//  @override
//  void dispose() {
//    super.dispose();
//    foodBloc.close();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppStrings.FOOD_LIST}'),
      ),
      body: Container(
        child: BlocBuilder<FoodBloc,FoodStatus>(
         // bloc: foodBloc,
          builder: (context, status) {
            if (status is InitialState) {
              return CircularProgressIndicator();
            } else if (status is LoadedStatus) {
              return (status.foods.length != null && status.foods.length != 0)
                  ? getFoodList(context,status)
                  : Text("no data item");
            } else {
              return SizedBox();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         var isAdded=await Navigator.of(context).pushNamed(FoodModule.routeAddFood);
         if(isAdded) {
           foodBloc.add(GetFoodList());
         }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  getFoodList(BuildContext context,LoadedStatus status) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (c, position) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              openFoodDetails(context,status.foods[position]);
            },
            child: Card(
              color: Color(0xffaed581),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: getCardContain(status.foods[position]),

            ),
          ),
        );
      },
      itemCount: status.foods.length,
    );
  }

  getCardContain(Food food) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5.h,
        ),
        FutureBuilder(
          future: setPath(food),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                  width: 150.h,
                  height: 100.h,
                  child: FittedBox(child: Image.file(File(imgPath),fit: BoxFit.fill,)));
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        SizedBox(
          height: 5.h,
        ),
        Text("${food.name}"),
        SizedBox(
          height: 5.h,
        ),
        Text("${food.price}"),
      ],
    );
  }

  openFoodDetails(BuildContext context,Food food) {
    Navigator.of(context).pushNamed(FoodModule.routeViewDetails, arguments: food);
  }
}

//ListView.builder(itemBuilder: (context,index){
//return Text(status.foods[index].name);
//},itemCount:status.foods.length ,);
