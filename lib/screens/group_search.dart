import 'package:flutter/material.dart';
import 'package:orange_assignment/APIs/APIs.dart';
import 'package:orange_assignment/bloc/groupSearchBloc/Controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_assignment/bloc/groupSearchBloc/Event.dart';
import 'package:orange_assignment/bloc/groupSearchBloc/States.dart';
import 'package:orange_assignment/bloc/mainGalleryBloc/State.dart';
import 'package:orange_assignment/models/GroupModel.dart';
import 'package:orange_assignment/models/PhotoModel.dart';


class GroupSearch extends StatefulWidget {
  @override
  _GroupSearch createState() => _GroupSearch();
}

class _GroupSearch extends State<GroupSearch> {
  final _scrollController = ScrollController();
  final GroupBloc _groupsBloc = GroupBloc(WatingUserInput());
  final _scrollThreshold = 25*100.0;
  TextEditingController searchController = TextEditingController();

  _GroupSearch(){
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Search Groups '),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
            StreamBuilder<String>(
            stream: _groupsBloc.outPut,
                builder: (context, snapshot) {
                  return Container(
                    margin: EdgeInsets.only(right: 10,left: 10,top: 25),
                    child: TextField(
                      controller: searchController,
                      onChanged: _groupsBloc.inPut,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          )
                        ),
                        labelText: 'Search Groups',
                        hintText: 'Enter non-Empty Group name',
                        errorText: snapshot.error as String?,
                      ),
                    ),
                  );
                }
            ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                child: Center(
                  child: RaisedButton.icon(
                    elevation: 10,
                    label: Text('Search',textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.white,
                    ),),
                    color: Colors.pinkAccent,
                    icon: Icon(Icons.search,color: Colors.white,),
                    onPressed: _onSearchPressed,
                  ),
                ),
              ),
                Expanded(
                  child: BlocBuilder(
                      bloc: _groupsBloc,
                      builder: (BuildContext context, GroupStates state) {
                        if(state is GroupsLoaded){
                          return GridView.count(crossAxisCount: 2,
                            controller: _scrollController,
                            children: getImagesWidget(state.dataModels!),
                          );
                        } else if(state is GropusLoadError){
                          return Center(
                            child: Text("Error"),
                          );
                        } else if(state is WatingUserInput){
                          return Container();
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                  ),
                ),
              ],
            ),

        ));
  }
  void _onSearchPressed(){
    _groupsBloc.onSearchPressed(searchController.text);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _groupsBloc.add(Scrolled());
    }

  }

  List<Widget>getImagesWidget(List<GroupModel> groups){
    List<Widget> gridList =[];
    for(GroupModel model in groups){
      gridList.add(Container(
          margin: EdgeInsets.all(8),
          decoration: ShapeDecoration( shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(width: 1),
          ),   image: DecorationImage(image: NetworkImage(model.iconPath!),fit: BoxFit.cover)),
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
                Text(model.groupTitle!, maxLines: 2 , textAlign: TextAlign.center,style: TextStyle(
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