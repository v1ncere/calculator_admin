part of 'update_bloc.dart';

class UpdateState extends Equatable {
  const UpdateState({
    this.user = Users.empty,
    this.status = Status.initial,
    this.date,
    this.message,
  });
  final Users user;
  final Status status;
  final DateTime? date;
  final String? message;

  UpdateState copyWith({
    Users? user,
    Status? status,
    DateTime? date,
    String? message
  }) {
    return UpdateState(
      user: user ?? this.user,
      status: status ?? this.status,
      date: date ?? this.date,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object?> get props => [ user, status, date, message ];
}