
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class SimOrderCartBloc extends Bloc<OrderCartEvent, List> {
  SimOrderCartBloc() : super([]) {
    on<OrderCartChangeEvent>(_onChangeValueEvent);
  }

  _onChangeValueEvent(OrderCartChangeEvent event, Emitter<List> emit){
    emit(event.data);
  }

}


abstract class OrderCartEvent extends Equatable {
  const OrderCartEvent();

  @override
  List<Object> get props => [];
}


class OrderCartChangeEvent extends OrderCartEvent{
  final List data;
  const OrderCartChangeEvent({required this.data});
}