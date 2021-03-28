import 'package:equatable/equatable.dart';
import 'package:orange_assignment/models/PhotoModel.dart';

abstract class GalleryState {
  GalleryState([List props = const []]) ;
}


class FirstEnterState extends GalleryState{}

class LoadedState extends GalleryState{
  final List<PhotoModel>? dataModels;
  final bool? isFinalPageReached;
 LoadedState({this.dataModels, this.isFinalPageReached}): super([dataModels, isFinalPageReached]);

  LoadedState copyWith({
    List<PhotoModel>? data,
    bool? hasReachedMax,
  }) {
    return LoadedState(
      dataModels: data ?? this.dataModels,
      isFinalPageReached: hasReachedMax ?? this.isFinalPageReached,
    );
  }
}


class ErrorState extends GalleryState{}





