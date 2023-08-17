import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';



class SimItemsBloc extends Bloc<SimAllItemsEvent, List> {
  late List currentState;
  SimItemsBloc() : super([]) {
    on<InitSimItemsEvent>(_onInitValueEvent);
    on<UpdateSimItemsEvent>(_onUpdateState);
    on<SimStorageSearchEvent>(_onSearch);
    on<SimStorageClearSearchEvent>(_onClearSearch);
  }

  _onInitValueEvent(InitSimItemsEvent event, Emitter<List> emit) async {
    currentState = event.data;
    emit(event.data);
  }


  _onUpdateState(UpdateSimItemsEvent event, Emitter<List> emit){
    emit(event.data);
  }

  _onSearch(SimStorageSearchEvent event, Emitter<List> emit){

    List request = event.text.split(' ');
    List result = [];

    for (var x = 0 ; x <= request.length-1; x++ ){
      result.isEmpty ? 
        result.addAll(currentState.where((item) => item['searchName'].toLowerCase().contains(request[x])).toList())
        :
        result = result.where((item) => item['searchName'].toLowerCase().contains(request[x])).toList();
      result.toSet().toList();
    }

    emit(result);
  }

  _onClearSearch(SimStorageClearSearchEvent event, Emitter<List> emit){
    emit(currentState);
  }

}


abstract class SimAllItemsEvent extends Equatable {
  const SimAllItemsEvent();

  @override
  List<Object> get props => [];
}


class InitSimItemsEvent extends SimAllItemsEvent{
  final List data;
  const InitSimItemsEvent({required this.data});
}

class UpdateSimItemsEvent extends SimAllItemsEvent{
  final List data;
  const UpdateSimItemsEvent({required this.data});
}

class SimStorageClearSearchEvent extends SimAllItemsEvent{}


class SimStorageSearchEvent extends SimAllItemsEvent{
  final String text;
  const SimStorageSearchEvent({required this.text});
}

class UpdateStateEvent extends SimAllItemsEvent{
  final List data;
  const UpdateStateEvent({required this.data});
}


