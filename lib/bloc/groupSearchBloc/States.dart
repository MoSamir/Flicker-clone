import 'package:equatable/equatable.dart';
import 'package:orange_assignment/models/GroupModel.dart';

abstract class GroupStates extends Equatable{
  GroupStates([List prpos = const []]) : super(prpos);
}
class GroupUninitialized extends GroupStates{}
class GroupsLoaded extends GroupStates{

  final List<GroupModel> dataModels ;
  final isDataEnded ;
  GroupsLoaded({this.dataModels,this.isDataEnded}):super([dataModels,isDataEnded]);
  GroupsLoaded copyWith(List<GroupModel> dataModels , bool isFinished){
    return GroupsLoaded(
      dataModels: dataModels ?? this.dataModels,
      isDataEnded: isFinished ?? this.isDataEnded
    );
  }
}
class GropusLoadError extends GroupStates{}

class WatingUserInput extends GroupStates{}
