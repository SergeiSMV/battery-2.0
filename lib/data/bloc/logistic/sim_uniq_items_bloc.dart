import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';



class SimUniqItemsBloc extends Bloc<SimAllItemsEvent, List> {
  late List currentState;
  SimUniqItemsBloc() : super([]) {
    on<InitUniqItemsEvent>(_onInitValueEvent);
    on<UpdateUniqItemsEvent>(_onUpdateState);
    on<UniqItemsSearchEvent>(_onSearch);
    on<UniqItemsClearSearchEvent>(_onClearSearch);
    on<CartContentEvent>(_onCartContent);
  }

  _onInitValueEvent(InitUniqItemsEvent event, Emitter<List> emit) async {
    currentState = event.data;
    emit(event.data);
  }


  _onUpdateState(UpdateUniqItemsEvent event, Emitter<List> emit){
    emit(event.data);
  }

  _onSearch(UniqItemsSearchEvent event, Emitter<List> emit){

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

  _onClearSearch(UniqItemsClearSearchEvent event, Emitter<List> emit){
    emit(currentState);
  }

  _onCartContent(CartContentEvent event, Emitter<List> emit){
    List cart = event.cart;
    List cartContent = [];

    for(var cont in cart){
      if (currentState.any((element) =>
      element.values.contains(cont['category']) &&
      element.values.contains(cont['name']) &&
      element.values.contains(cont['color']) &&
      element.values.contains(cont['producer']))) {
        for (var s in currentState) {
          if (s['category'] == cont['category'] &&
              s['name'] == cont['name'] &&
              s['color'] == cont['color'] &&
              s['producer'] == cont['producer']) {
            cartContent.add(s);
            break;
          } else {
            continue;
          }
        }
    } else {
      continue;
    }
  }
    emit(cartContent.toList());
  }


}


abstract class SimAllItemsEvent extends Equatable {
  const SimAllItemsEvent();

  @override
  List<Object> get props => [];
}


class InitUniqItemsEvent extends SimAllItemsEvent{
  final List data;
  const InitUniqItemsEvent({required this.data});
}

class UpdateUniqItemsEvent extends SimAllItemsEvent{
  final List data;
  const UpdateUniqItemsEvent({required this.data});
}

class UniqItemsClearSearchEvent extends SimAllItemsEvent{}


class UniqItemsSearchEvent extends SimAllItemsEvent{
  final String text;
  const UniqItemsSearchEvent({required this.text});
}


class CartContentEvent extends SimAllItemsEvent{
  final List cart;
  const CartContentEvent({required this.cart});
}
