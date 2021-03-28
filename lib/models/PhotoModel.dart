import 'package:orange_assignment/APIs/Keys.dart';
import 'package:sprintf/sprintf.dart';


class PhotoModel{


  String? imgTitle,imgID,imagePath;

  PhotoModel.name(this.imgTitle, this.imgID, this.imagePath);

  PhotoModel(this.imgTitle, this.imgID, this.imagePath);

  String? get Path => imagePath;
  String? get ID => imagePath;
  String? get Title => imagePath;


  PhotoModel.fromJson(Map<String,dynamic> jsonResponse){

    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

    int? farm = jsonResponse['farm'];
    String? server = jsonResponse['server'];
    String? secret = jsonResponse['secret'];

    imgID = jsonResponse['id'];
    imgTitle = jsonResponse['title'];
    imgID = jsonResponse['id'];
    imagePath = sprintf(Keys.IMAGE_PATH,[farm,server,imgID,secret]);
  }

}


// https://farm{farm_id}.staticflickr.com/{iconserver}/buddyicons/{group_id}.jpg


