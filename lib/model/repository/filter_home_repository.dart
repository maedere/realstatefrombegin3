


import 'package:realstatefrombegin3/model/object/filter.dart';
import 'package:realstatefrombegin3/model/object/home.dart';

class HomeRepository{

  List<MiniHome> miniHomes;

  HomeRepository(){
   miniHomes = [];
  }

  Future<List<MiniHome>> getHomeList() async{
    //miniHomes = await HomeApi.getHomes();
   return miniHomes;
  }

  Future<List<MiniHome>> getHomeListFilter(List<FilterModel> filters) async{
    //miniHomes = await HomeApi.getHomesFilter(filters);
    return miniHomes;
  }

}