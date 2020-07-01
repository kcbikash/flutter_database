import 'package:equatable/equatable.dart';
import 'package:flutterdatabase/ui/food/model/food_model.dart';


class FoodStatus extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends FoodStatus {}

class LoadingState extends FoodStatus {}

class LoadedStatus extends FoodStatus {
  List<Food> foods;
  LoadedStatus(this.foods);
}

class AddedFood extends FoodStatus{
  Food food;
  AddedFood(this.food);
}

class UpdatedFood extends FoodStatus{
  int updatedId;
  UpdatedFood(this.updatedId);
}

class DeletedFood extends FoodStatus{
  int deletedId;
  DeletedFood(this.deletedId);
}

class GetFoodByIdStatus extends FoodStatus{
  Food food;
  GetFoodByIdStatus(this.food);
}
