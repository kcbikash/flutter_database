import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_bloc.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_event.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_state.dart';
import 'package:flutterdatabase/ui/food/food_routing_module.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewFood extends StatefulWidget {
  Food food;
  ViewFood(this.food);
  @override
  ViewFoodState createState() => ViewFoodState(food);
}

class ViewFoodState extends State<ViewFood> {
  Food food;
  String imagePath="";

  ViewFoodState(this.food);



  Future getPath() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    return path;
  }

  setPath() async{
    imagePath=await getPath();
    imagePath="$imagePath/${food.img_name}.png";
    // filePath = await FlutterAbsolutePath.getAbsolutePath(imagePath);

   // final File newImage = await _image.copy('$path/$name.png');
  }


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("path test:");
   print(imagePath);
    return Scaffold(
      appBar: AppBar(
        title: Text("${food.name} Details"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  child: RaisedButton(
                      onPressed: () {
                        updateFood(food,context);
                      },
                      color: Colors.green[200],
                      child: Text("Update")),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  child: RaisedButton(
                      onPressed: () {
                        deleteFood(food,context);
                      },
                      color: Colors.red[400],
                      child: Text("Delete")),
                )
              ],
            ),
           // Image.asset("assets/images/apple.jpg"),
            //Image.asset(imagePath),

            //Image.file(filePath),

            FutureBuilder(
              future:setPath(),
              builder: (BuildContext context,AsyncSnapshot shapshot){
                if(shapshot.connectionState==ConnectionState.done){
                  return Container(
                      width: 200.w,
                      height: 200.h,
                      child: Image.file(File(imagePath)));
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
            Text("${food.name}"),
            Text("${food.price}")
          ],
        ),
      ),
    );
  }

  updateFood(Food food,BuildContext context) async{
  var updated= await Navigator.of(context).pushNamed(FoodModule.routeUpdateFood, arguments: food);
  if(updated){

  }
  }

  deleteFood(Food food,BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text("Delete Food"),
            content: Text("Are you sure you want to delete ${food.name} ?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              FlatButton(
                onPressed: () {
                  deleteFromDb(context);
                },
                child: Text("Ok"),
              )
            ],
          );
        });
  }

  deleteFromDb(BuildContext context) {
    BlocProvider.of<FoodBloc>(context).add(DeleteFood(food.id));
    Navigator.of(context).pushReplacementNamed(FoodModule.routeMainScreenFood);
  }
}
