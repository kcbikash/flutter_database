
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_event.dart';
import 'package:flutterdatabase/ui/food/food_bloc/food_state.dart';
import 'package:flutterdatabase/ui/food/food_bloc/repository.dart';


class FoodBloc extends Bloc<FoodEvent,FoodStatus>{
  FoodRepository foodRepository;
  FoodBloc(this.foodRepository);

  @override
  FoodStatus get initialState => InitialState();

  @override
  Stream<FoodStatus> mapEventToState(FoodEvent event) async*{
   if(event is GetFoodList){
     yield LoadingState();
     var foodlist=await foodRepository.getFoodList();
     yield LoadedStatus(foodlist);
   }else if(event is AddFood){
      yield LoadingState();
      var food=await foodRepository.insertFood(event.food);
      yield AddedFood(food);
   }else if(event is UpdateFood){
     yield LoadingState();
     var updatedId=await foodRepository.updateFood(event.newFood);
     yield UpdatedFood(updatedId);
   }else if(event is DeleteFood){
     yield LoadingState();
     var deletedId=await foodRepository.deleteFood(event.foodId);
     yield DeletedFood(deletedId);
   }else if(event is GetFoodById){
     yield LoadingState();
     var food=await foodRepository.getFoodById(event.id);
     yield GetFoodByIdStatus(food);
   }

  }

}