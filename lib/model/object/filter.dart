
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class FilterModel extends Equatable{

  final String name;
  final String type;
  bool active;
  IconData icon;


  FilterModel(this.name, this.type
      , this.active,[this.icon]
      );

  @override
  String toString() {
    return '$type $name';
  }

  @override
  List<Object> get props => [name , type];
}