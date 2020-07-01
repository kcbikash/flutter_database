import 'package:equatable/equatable.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';


abstract class FoodEvent extends Equatable{
  @override
  List<Object> get props =>[];
}

class AddFood extends FoodEvent{
  Food food;
  AddFood(this.food);
}

class DeleteFood extends FoodEvent{
  int foodId;
  DeleteFood(this.foodId);
}

class GetFoodList extends FoodEvent{
}

class UpdateFood extends FoodEvent{
  Food newFood;
  //int foodIndex;
  UpdateFood(this.newFood);
}

class GetFoodById extends FoodEvent{
  int id;
  GetFoodById(this.id);
}