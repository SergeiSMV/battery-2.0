import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';



class SimItemsBloc extends Bloc<SimAllItemsEvent, List> {
  late WebSocketChannel itemsChannel;
  late List currentState;
  SimItemsBloc() : super([]) {
    on<InitSimItemsEvent>(_onInitValueEvent);
    on<UpdateSimItemsEvent>(_onUpdateState);
    on<SimStorageSearchEvent>(_onSearch);
    on<SimStorageClearSearchEvent>(_onClearSearch);
    // on<UpdateStateEvent>(_onUpdateCurrentState);
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

  // _onUpdateCurrentState(UpdateStateEvent event, Emitter<List> emit){
  //   currentState = event.data;
  //   emit(currentState);
  // }

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


