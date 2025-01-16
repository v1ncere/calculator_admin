part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    required this.status,
    this.user = User.empty
  });
  final User user;
  final AppStatus status;

  AppState copyWith({
    User? user,
    AppStatus? status,
  }) {
    return AppState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [ user, status ];
}

enum AppStatus { forgotPassword, unauthenticated, authenticated }