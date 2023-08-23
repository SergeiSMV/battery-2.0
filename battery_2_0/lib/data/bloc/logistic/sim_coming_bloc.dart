
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class SimComingBloc extends Bloc<AddItemEvent, Map> {
  SimComingBloc() : super({
    'category': '', 'name': '', 'color': '', 'producer': '', 'barcode': '', 'quantity': '', 
    'unit': '', 'place': '', 'cell': '', 'fifo': '', 'author': '', 'pallet_size': '',
    'pallet_height': '', 'merge': 'no', 'merge_items': []
  }) {
    on<SimComingChange>(_onChangeValueEvent);
  }

  _onChangeValueEvent(SimComingChange event, Emitter<Map> emit){
    emit(event.data);
  }

}


abstract class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object> get props => [];
}


class SimComingChange extends AddItemEvent{
  final Map data;
  const SimComingChange({required this.data});
}