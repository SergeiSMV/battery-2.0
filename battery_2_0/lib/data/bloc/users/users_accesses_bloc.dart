
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class UsersAccessesBloc extends Bloc<UsersAccessesEvent, List> {
  UsersAccessesBloc() : super([]) {
    on<UsersAccessesChange>(_onChangeValueEvent);
  }

  _onChangeValueEvent(UsersAccessesChange event, Emitter<List> emit){
    emit(event.data);
  }

}


abstract class UsersAccessesEvent extends Equatable {
  const UsersAccessesEvent();

  @override
  List<Object> get props => [];
}


class UsersAccessesChange extends UsersAccessesEvent{
  final List data;
  const UsersAccessesChange({required this.data});
}