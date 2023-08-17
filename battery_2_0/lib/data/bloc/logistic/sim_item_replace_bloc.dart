import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';



class SimItemReplaceBloc extends Bloc<SimAllItemsEvent, Map> {
  SimItemReplaceBloc() : super({'default': {}, 'replace': {}, 'merge': 'no', 'merge_items': [], 'change_pallet': 'no'}) {
    on<InitEvent>(_onInitReplaceValue);
    on<ReplaceEvent>(_onSetReplaceValue);
    on<MergeEvent>(_onSetMergeValue);
    on<MergeItemsEvent>(_onSetMergeItemsValue);
    on<ChangePalletEvent>(_onSetChangePalletValue);
  }

  _onInitReplaceValue(InitEvent event, Emitter<Map> emit) async {
    state['default'] = event.initData;
    state['replace'] = event.initData;
    emit(Map.from(state));
  }

  _onSetReplaceValue(ReplaceEvent event, Emitter<Map> emit) async {
    state['replace'] = event.replaceData;
    emit(Map.from(state));
  }

  _onSetMergeValue(MergeEvent event, Emitter<Map> emit){
    state['merge'] = event.data;
    emit(Map.from(state));
  }


  _onSetMergeItemsValue(MergeItemsEvent event, Emitter<Map> emit) async {
    state['merge_items'] = event.mergeItems;
    emit(Map.from(state));
  }

    _onSetChangePalletValue(ChangePalletEvent event, Emitter<Map> emit) async {
    state['change_pallet'] = event.data;
    emit(Map.from(state));
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

class MergeEvent extends SimAllItemsEvent{
  final String data;
  const MergeEvent({required this.data});
}

class ReplaceEvent extends SimAllItemsEvent{
  final Map replaceData;
  const ReplaceEvent({required this.replaceData});
}

class MergeItemsEvent extends SimAllItemsEvent{
  final List mergeItems;
  const MergeItemsEvent({required this.mergeItems});
}

class ChangePalletEvent extends SimAllItemsEvent{
  final String data;
  const ChangePalletEvent({required this.data});
}


