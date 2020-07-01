import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdatabase/di/dependency_injection.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_bloc.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_event.dart';
import 'package:flutterdatabase/ui/food/food_routing_module.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';
import 'package:flutterdatabase/ui/food/ui/main_screen.dart';
import 'package:flutterdatabase/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateFoods extends StatefulWidget {
  Food food;
  UpdateFoods(this.food);
  @override
  UpdateFoodState createState() => UpdateFoodState(food);
}

class UpdateFoodState extends State<UpdateFoods> {
  final Food food;
  FoodBloc foodBloc;
  UpdateFoodState(this.food);
  var _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = food.name;
    priceController.text = food.price.toString();
    qtyController.text = food.qty.toString();
  }

  @override
  Widget build(BuildContext context) {
    //foodBloc= BlocProvider.of<FoodBloc>(context);
    foodBloc=sl<FoodBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppStrings.UPDATE_FOOD}"),
      ),
      body: SingleChildScrollView(child: getForm(context)),
    );
  }

  Widget getForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: nameController,
              validator: (val) {
                return val.isEmpty ? "Name is empty" : null;
              },
              decoration: InputDecoration(labelText: "Food name"),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: priceController,
              validator: (val) {
                return val.isEmpty ? "Price is empty" : null;
              },
              decoration: InputDecoration(labelText: "Price"),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: qtyController,
              validator: (val) {
                return val.isEmpty ? "Quantity is empty" : null;
              },
              decoration: InputDecoration(labelText: "Quantity"),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width.w * 0.6,
              height: 50.h,
              color: Colors.green,
              child: RaisedButton(
                onPressed: () {
                  if (validateForm()) {
                    var updatedfood = Food(
                        id: food.id,
                        name: nameController.text,
                        price: double.parse(priceController.text),
                        qty: int.parse(qtyController.text),
                        img_name: food.img_name);
                   // BlocProvider.of<FoodBloc>(context)
                        foodBloc.add(UpdateFood(updatedfood));
                    Navigator.pop(context,true);
//                    Navigator.pushReplacementNamed(
//                        context, FoodModule.routeMainScreenFood);
                  }
                },
                child: Text("Update Food"),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateForm() {
    if (_formKey.currentState.validate()) {
      return true;
    }
    return false;
  }
}
