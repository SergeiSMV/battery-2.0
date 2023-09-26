
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class SimNomenclatureBloc extends Bloc<SimNomenclatureEvent, Map> {
  SimNomenclatureBloc() : super({'category': '', 'name': '', 'producer': '', 'unit': ''}) {
    on<SimNomenclatureChange>(_onChangeValueEvent);
  }

  _onChangeValueEvent(SimNomenclatureChange event, Emitter<Map> emit){
    emit(event.data);
  }

}


abstract class SimNomenclatureEvent extends Equatable {
  const SimNomenclatureEvent();

  @override
  List<Object> get props => [];
}


class SimNomenclatureChange extends SimNomenclatureEvent{
  final Map data;
  const SimNomenclatureChange({required this.data});
}