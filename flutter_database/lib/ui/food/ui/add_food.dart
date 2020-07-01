import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdatabase/di/dependency_injection.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_bloc.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_event.dart';
import 'package:flutterdatabase/ui/food/food_routing_module.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';
import 'package:flutterdatabase/utils/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddFoods extends StatefulWidget {
  @override
  AddFoodState createState() => AddFoodState();
}

class AddFoodState extends State<AddFoods> {
  var _formKey = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();
  String path = "";
  String imgName = "";
  FoodBloc foodBloc;

  Future getPath() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    return path;
  }

  saveImageName() async {
    path = await getPath();
    String name = DateTime.now().toString();
    imgName = name;
    final File newImage = await _image.copy('$path/$name.png');
    print("img path:" + path);
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        saveImageName();
      });
    }
  }

  Future getImageFromGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        saveImageName();
      });
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    //foodBloc=BlocProvider.of<FoodBloc>(context);
    foodBloc=sl<FoodBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppStrings.ADD_FOOD}"),
      ),
      body: SafeArea(child: getForm(context),),
    );
  }

  Widget getForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
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
                validator: (val) {
                  return val.isEmpty ? "Price is empty." : null;
                },
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(
                      RegExp("[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)"))
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                validator: (val) {
                  return val.isEmpty ? "Quntity is empty" : null;
                },
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter(
                      RegExp("[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)"))
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: qtyController,
                decoration: InputDecoration(labelText: "Quantity"),
              ),
              SizedBox(
                height: 20.h,
              ),
              RaisedButton(
                color: Color(0xff7da453),
                onPressed: () {
                  uploadImage();
                },
                child: Text("Select image"),
              ),
              _image != null
                  ? Container(
                      height: 100.h,
                      child: Image.file(_image),
                    )
                  : SizedBox(),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width.w * 0.6,
                height: 50.h,
                child: RaisedButton(
                  color: Color(0xff7da453),
                  onPressed: () {
                    if (validateForm()) {
                      var food = Food(
                          name: nameController.text,
                          price: double.parse(priceController.text),
                          qty: int.parse(qtyController.text),
                          img_name: imgName);
                     // BlocProvider.of<FoodBloc>(context)..add(AddFood(food));
                      foodBloc.add(AddFood(food));
                      Navigator.pop(context,true);
//                      Navigator.pushReplacementNamed(
//                          context, FoodModule.routeMainScreenFood);
                    }
                  },
                  child: Text("Add Food"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    if (_formKey.currentState.validate()) {
      print("valid");
      return true;
    }
    return false;
  }

  uploadImage() async {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    getImageFromCamera();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    getImageFromGallery();
                  },
                )
              ],
            ),
          );
        });
  }
}
