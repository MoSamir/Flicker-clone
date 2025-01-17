import 'package:equatable/equatable.dart';
import 'package:orange_assignment/models/GroupModel.dart';

abstract class GroupStates {
  GroupStates([List prpos = const []]) ;
}
class GroupUninitialized extends GroupStates{}
class GroupsLoaded extends GroupStates{

  final List<GroupModel>? dataModels ;
  final isDataEnded ;
  GroupsLoaded({this.dataModels,this.isDataEnded}):super([dataModels,isDataEnded]);
  GroupsLoaded copyWith(List<GroupModel> dataModels , bool isFinished){
    return GroupsLoaded(
      dataModels: dataModels ,
      isDataEnded: isFinished
    );
  }
}
class GropusLoadError extends GroupStates{}

class WatingUserInput extends GroupStates{}
