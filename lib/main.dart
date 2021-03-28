import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_assignment/screens/group_search.dart';
import 'package:orange_assignment/screens/main_gallery.dart';
import 'package:bloc/bloc.dart';


void main(){

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context){
            return GroupSearch();
          }));
        }, child: Icon(Icons.search , color: Colors.grey,),),

        body: MainGallery(),
    );
  }

}


class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}