
import 'package:fluro/fluro.dart';
import 'package:flutterdatabase/ui/food/food_routing_module.dart';

class Routing{
Router buildRoute(){
 Router router=Router();
 FoodModule.registerRoutes(router);
 return router;
}
}