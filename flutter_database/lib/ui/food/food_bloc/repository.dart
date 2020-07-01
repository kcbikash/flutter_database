
import 'package:flutterdatabase/database/database_provider.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';

abstract class FoodRepository{
  Future<List<Food>> getFoodList();
  Future<Food> insertFood(Food food);
  Future<int> updateFood(Food food);
  Future<int> deleteFood(int id);
  Future<Food> getFoodById(int id);
}

class FoodRepositoryImp extends FoodRepository{
  DatabaseProvider database;
  FoodRepositoryImp(this.database);
  @override
  Future<List<Food>> getFoodList() async{
    var foodList=await database.getFoods();
    return foodList;
  }

  Future<Food> insertFood(Food food) async{
    var insertedFood=await database.insert(food);
    return insertedFood;
  }

  Future<int> updateFood(Food food) async{
    var updated=await database.update(food);
    return updated;
  }

  Future<int> deleteFood(int id) async{
    var deleted=await database.delete(id);
    return deleted;
  }

  Future<Food> getFoodById(int id) async{
    var food=await database.getFoodById(id);
    return food;
  }



}
