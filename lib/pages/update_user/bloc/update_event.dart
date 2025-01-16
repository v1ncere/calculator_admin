part of 'update_bloc.dart';

sealed class UpdateEvent extends Equatable {
  const UpdateEvent();

  @override
  List<Object> get props => [];
}

final class UserLoaded extends UpdateEvent {
  const UserLoaded(this.user);
  final Users user;

  @override
  List<Object> get props => [user];
}

final class UserUpdated extends UpdateEvent {}

final class DatePickerChanged extends UpdateEvent {
  const DatePickerChanged(this.date);
  final DateTime date;

  @override
  List<Object> get props => [date];
}

