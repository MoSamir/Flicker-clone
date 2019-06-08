import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:orange_assignment/APIs/APIs.dart';
import 'package:orange_assignment/bloc/groupSearchBloc/States.dart';

import 'Event.dart';

class GroupBloc extends Bloc<GroupEvents, GroupStates> {
  StreamController<String> _userInput = StreamController<String>.broadcast();

  Stream<String> get outPut => _userInput.stream;
  Function(String) get inPut => _userInput.sink.add;
  String searchQuery;

  onSearchPressed(String searchTemp) async {

    if (searchTemp != searchQuery) {
      APIs.LoadFirstGroup();
    }
    searchQuery = searchTemp;
    if (searchQuery == null || searchQuery.isEmpty) {
      _userInput.sink.addError("Search Can't be empty");
      return;
    }
    dispatch(SearchButtonClicked());
  }

  @override
  // TODO: implement initialState
  GroupStates get initialState => WatingUserInput();

  @override
  Stream<GroupStates> mapEventToState(GroupEvents event) async* {
    try {
      if (event is SearchButtonClicked) {
        if (currentState is GroupUninitialized || currentState is WatingUserInput) {
          final response = await APIs.LoadGroups(searchQuery);
          yield GroupsLoaded(dataModels: response, isDataEnded: false);
          return;
        }
        if (currentState is GroupsLoaded) {
          yield GroupUninitialized();
          dispatch(SearchButtonClicked());
          return ;
        }
      } else if (event is Scrolled) {
        final response = await APIs.LoadGroups(searchQuery);
        if (response.isEmpty) {
          yield (currentState as GroupsLoaded).copyWith(
              (currentState as GroupsLoaded).dataModels + response, true);
        } else {
          yield GroupsLoaded(
              dataModels: (currentState as GroupsLoaded).dataModels + response,
              isDataEnded: false);
        }
      }
    }catch(e){
      yield GropusLoadError();
    }
  }
}