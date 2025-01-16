import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:calculator_admin/repository/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required FirebaseAuthRepository authRepository,
    required FirebaseDatabaseRepository databaseRepository,
  }) : _authRepository = authRepository,
  super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoggedInWithCredentials>(_onLoggedInWithCredentials);
    on<PasswordObscured>(_onPasswordObscured);
  }
  final FirebaseAuthRepository _authRepository;

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password));
  }

  void _onPasswordObscured(PasswordObscured event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObscure: !state.isObscure));
  }

  void _onLoggedInWithCredentials(LoggedInWithCredentials event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final credential = await _authRepository.logInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value
        );

        final isModerator = (await customClaims)!['admin'] == true;
        if (credential != null && credential.user!.emailVerified != true) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            message: "Please verify your email address to continue. We've sent a verification link to your email.",
          ));
        } else if (credential != null && !isModerator) {
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            message: 'Login failed. Moderator privileges required.',
          ));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        }
      } catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          message: "Error: ${e.toString().replaceAll("Exception: ", "")}"
        ));
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure, 
        message: 'Oops! It looks like you missed some required fields. Please make sure to complete all the fields before submitting your form. Thank you!'
      ));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  Future<Map<dynamic, dynamic>?> get customClaims async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.getIdTokenResult(true);
    return token?.claims;
  }
}
