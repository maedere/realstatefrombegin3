
import 'package:realstatefrombegin3/model/object/car.dart';
import 'package:realstatefrombegin3/model/object/filter.dart';

class CarRepository{

  List<MiniCar> miniCars;

  CarRepository(){
    miniCars = [];
  }

  Future<List<MiniCar>> getCarList() async{
    //miniCars = await CarApi.getCars();
    return miniCars;
  }

  Future<List<MiniCar>> getCarFilter(List<FilterModel> filters) async{
    //miniCars = await CarApi.getCarsFilter(filters);
    return miniCars;
  }

}