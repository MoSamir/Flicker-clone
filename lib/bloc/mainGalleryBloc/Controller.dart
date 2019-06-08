
import 'package:orange_assignment/APIs/APIs.dart';
import 'package:rxdart/rxdart.dart';

import 'Event.dart';
import 'State.dart';
import 'package:bloc/bloc.dart';

class GalleryBloc extends Bloc<GalleryEvent,GalleryState>{


  @override
  Stream<GalleryState> transform(
      Stream<GalleryEvent> events,
      Stream<GalleryState> Function(GalleryEvent event) next,
      ) {
    return super.transform(
      (events as Observable<GalleryEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  GalleryState get initialState => FirstEnterState();

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async*{

    if(isDataFinished(currentState) == false &&  event is Fetch) {
      try {
        if (currentState is FirstEnterState) {
          final response = await APIs.LoadRecent();

          yield LoadedState(dataModels: response,isFinalPageReached: false);
          return;
        }
        if (currentState is LoadedState) {
          final response = await APIs.LoadRecent();


          if ( response!=null && response.isEmpty)
            yield LoadedState(dataModels: (currentState as LoadedState).dataModels + response,isFinalPageReached: true);
          else
            yield LoadedState(dataModels:(currentState as LoadedState).dataModels + response,isFinalPageReached: false);
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


