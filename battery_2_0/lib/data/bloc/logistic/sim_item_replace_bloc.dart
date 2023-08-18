import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';



class SimItemReplaceBloc extends Bloc<SimAllItemsEvent, Map> {
  SimItemReplaceBloc() : super({'default': {}, 'replace': {}, 'change_pallet': 'no', 'merge': 'no', 'merge_items': []}) {
    on<InitEvent>(_onInitReplaceValue);
    on<UpdateReplaceValueEvent>(_onUpdateReplaceValue);
  }

  _onInitReplaceValue(InitEvent event, Emitter<Map> emit) async {
    state['default'] = Map.from(event.initData);
    state['replace'] = Map.from(event.initData);
    emit(Map.from(state));
  }

  _onUpdateReplaceValue(UpdateReplaceValueEvent event, Emitter<Map> emit) async {
    emit(Map.from(event.updateData));
  }
}


abstract class SimAllItemsEvent extends Equatable {
  const SimAllItemsEvent();

  @override
  List<Object> get props => [];
}


class InitEvent extends SimAllItemsEvent{
  final Map initData;
  const InitEvent({required this.initData});
}

class UpdateReplaceValueEvent extends SimAllItemsEvent{
  final Map updateData;
  const UpdateReplaceValueEvent({required this.updateData});
}


