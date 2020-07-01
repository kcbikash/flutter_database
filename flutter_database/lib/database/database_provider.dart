import 'package:flutter/material.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';
import 'package:flutterdatabase/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  Database _database;

  Future<Database> database() async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, AppConstants.DATABASE_NAME),
        version: 1, onCreate: (Database database, int version) async {
      print("Creating food table");
      await database.execute(
        "CREATE TABLE ${AppConstants.FOOD_TABLE} ("
        "${AppConstants.COLUMN_ID} INTEGER PRIMARY KEY,"
        "${AppConstants.COLUMN_NAME} TEXT,"
        "${AppConstants.COLUMN_PRICE} REAL,"
        "${AppConstants.COLUMN_QTY} INTEGER,"
        "${AppConstants.COLUMN_IMG_NAME} TEXT "
        ")",
      );
    });
  }

  Future<List<Food>> getFoods() async {
    final db = await database();
    var foods = await db.query(AppConstants.FOOD_TABLE, columns: [
      AppConstants.COLUMN_ID,
      AppConstants.COLUMN_NAME,
      AppConstants.COLUMN_PRICE,
      AppConstants.COLUMN_QTY,
      AppConstants.COLUMN_IMG_NAME,
    ]);
    List<Food> foodList = List<Food>();
    foods.forEach((currentFood) {
      Food food = Food.fromJson(currentFood);
      foodList.add(food);
    });
    return foodList;
  }

  Future<Food> getFoodById(int id) async {
    final db = await database();
    Food retrievedFood;
    var food = await db.query(AppConstants.FOOD_TABLE,
        columns: [
          AppConstants.COLUMN_ID,
          AppConstants.COLUMN_NAME,
          AppConstants.COLUMN_PRICE,
          AppConstants.COLUMN_QTY,
          AppConstants.COLUMN_IMG_NAME,
        ],
        where: "id=?",
        whereArgs: [id]);
    food.forEach((element) {
      Food retrievedFood=Food.fromJson(element);
    });
    return retrievedFood;
    //Food getFood=Food.fromJson(food);
  }

  Future<Food> insert(Food food) async {
    final db = await database();
    food.id = await db.insert(AppConstants.FOOD_TABLE, food.toJson());
    return food;
  }

  Future<int> delete(int id) async {
    final db = await database();
    return db.delete(
      AppConstants.FOOD_TABLE,
      where: "id= ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Food food) async {
    final db = await database();
    return await db.update(
      AppConstants.FOOD_TABLE,
      food.toJson(),
      where: "id=?",
      whereArgs: [food.id],
    );
  }
}
