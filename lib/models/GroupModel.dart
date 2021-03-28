import 'package:sprintf/sprintf.dart';
import 'package:orange_assignment/APIs/Keys.dart';

class GroupModel{

  String? groupID , groupTitle , iconPath , groupMembers ;
  GroupModel.fromJson(Map<String,dynamic> jsonMap){

    String? serverId = jsonMap['iconserver'];
    int? farmId = jsonMap['iconfarm'];
    groupTitle = jsonMap['name'];
    groupMembers = jsonMap['members'];
    groupID = jsonMap['nsid'];
    iconPath = sprintf(Keys.GROUP_IMAGE,[farmId,serverId,groupID]);
  }
}