import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:orange_assignment/APIs/Keys.dart';
import 'package:orange_assignment/models/GroupModel.dart';
import 'package:orange_assignment/models/PhotoModel.dart';
import 'package:sprintf/sprintf.dart';

class APIs{


  static int RECENT_PAGE_NUMBER = 0 ;
  static int GROUPS_PAGE_NUMBER = 0 ;

  static void LoadFirstPage() => RECENT_PAGE_NUMBER = 0 ;
  static void LoadFirstGroup() => GROUPS_PAGE_NUMBER = 0 ;


  static Future<List<PhotoModel>>LoadRecent()async{
    RECENT_PAGE_NUMBER ++ ;


    List<PhotoModel> dataModels = [];
    String URL = sprintf(Keys.GET_RECENT,[RECENT_PAGE_NUMBER]);
    final response = await http.get(URL);
      if(response.statusCode == 200) {
        for (int i = 0; i < json.decode(response.body)['photos']['photo'].length; i++) {
          PhotoModel mod = PhotoModel.fromJson(jsonDecode(response.body)['photos']['photo'][i]);
          dataModels.add(mod);
        }
        return dataModels;

      } else {
          throw '${response.statusCode}   ${response.reasonPhrase}';
      }
    }


  static Future<List<GroupModel>>LoadGroups(String searchQuery)async{
    GROUPS_PAGE_NUMBER ++ ;
    List<GroupModel> dataModels = [];
    String URL = sprintf(Keys.GET_GROUPS,[searchQuery,RECENT_PAGE_NUMBER]);
    final response = await http.get(URL);
    if(response.statusCode == 200) {
      for(int i = 0 ; i < json.decode(response.body)['groups']['group'].length ; i++){
        GroupModel model =  GroupModel.fromJson(json.decode(response.body)['groups']['group'][i]);
        dataModels.add(model);
      }
      return dataModels;
    } else {
      throw '${response.statusCode}   ${response.reasonPhrase}';
    }
  }
}