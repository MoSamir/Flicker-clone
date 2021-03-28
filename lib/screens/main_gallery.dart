import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:orange_assignment/APIs/APIs.dart';
import 'package:orange_assignment/bloc/groupSearchBloc/States.dart';
import 'package:orange_assignment/bloc/mainGalleryBloc/Controller.dart';
import 'package:orange_assignment/bloc/mainGalleryBloc/Event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_assignment/bloc/mainGalleryBloc/State.dart';
import 'package:orange_assignment/models/PhotoModel.dart';


class MainGallery extends StatefulWidget {
  @override
  _MainGalleryState createState() => _MainGalleryState();
}

class _MainGalleryState extends State<MainGallery> {
  final _scrollController = ScrollController();
  final GalleryBloc _imagesBloc = GalleryBloc(FirstEnterState());
  final _scrollThreshold = 25*100.0;

  _MainGalleryState(){
    _scrollController.addListener(_onScroll);
    _imagesBloc.add(new Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Photos Gallery ')
      ),
        body: BlocBuilder(
        bloc: _imagesBloc,
          builder: (BuildContext context, GalleryState state) {
          if(state is LoadedState){
            return GridView.count(crossAxisCount:  kIsWeb ? 4 : 2,
            controller: _scrollController,
            children: getImagesWidget(state.dataModels!),
            );
          } else if(state is FirstEnterState){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {

            return Center(
              child: Text("Error"),
            );
          }
          }
    ));
  }
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _imagesBloc.add(Fetch());
    }

  }

  List<Widget>getImagesWidget(List<PhotoModel> images){
    List<Widget> gridList =[];
    for(PhotoModel model in images){
      gridList.add(Container(
        margin: EdgeInsets.all(8),
        decoration: ShapeDecoration( shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 1),
      ),   image: DecorationImage(image: NetworkImage(model.imagePath!),fit: BoxFit.cover)),
        width: 100,
          height: 100,
        child: Card(
         color: Colors.transparent,
          elevation: 8,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //Image.network(model.imagePath,fit: BoxFit.cover,height: 150,),
              Text(model.imgTitle!, maxLines: 2 , textAlign: TextAlign.center,style: TextStyle(
                backgroundColor: Color.fromARGB(100,0, 0,0),
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),)
            ],
          ),
        )
      ));
    }
    return gridList;
  }
}