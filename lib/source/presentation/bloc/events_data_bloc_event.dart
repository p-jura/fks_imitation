import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventsDataBlocEvent extends Equatable {}

class GetEventsFromRemoteSingleCategory extends EventsDataBlocEvent {
  GetEventsFromRemoteSingleCategory();

  @override
  List<Object?> get props => [];
}

class GetAllCategoriesEventsData extends EventsDataBlocEvent {
  final int? categoiresAmmount;

  GetAllCategoriesEventsData([this.categoiresAmmount]);

  @override
  List<Object?> get props => [categoiresAmmount];
}

class GetSingleCategoryEventsData extends EventsDataBlocEvent {
  final int categoryId;

  GetSingleCategoryEventsData({required this.categoryId});
 
  @override
  List<Object?> get props => [categoryId];
}
