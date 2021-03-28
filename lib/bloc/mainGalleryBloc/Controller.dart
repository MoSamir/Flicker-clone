
import 'package:orange_assignment/APIs/APIs.dart';

import 'Event.dart';
import 'State.dart';
import 'package:bloc/bloc.dart';

class GalleryBloc extends Bloc<GalleryEvent,GalleryState>{
  GalleryBloc(GalleryState initialState) : super(initialState);





  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async*{

    if(isDataFinished(state) == false &&  event is Fetch) {
      try {
        if (state is FirstEnterState) {
          final response = await APIs.LoadRecent();

          yield LoadedState(dataModels: response,isFinalPageReached: false);
          return;
        }
        if (state is LoadedState) {
          final response = await APIs.LoadRecent();


          if ( response!=null && response.isEmpty)
            yield LoadedState(dataModels: (state as LoadedState).dataModels! + response,isFinalPageReached: true);
          else
            yield LoadedState(dataModels:(state as LoadedState).dataModels! + response,isFinalPageReached: false);
        }
      } catch(e){
        yield ErrorState();

      }
    }
  }

  bool isDataFinished(currentState){
    return (currentState is LoadedState && (currentState as LoadedState).isFinalPageReached == true);
  }




}


