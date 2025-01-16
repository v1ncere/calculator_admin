import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:calculator_admin/repository/repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required FirebaseAuthRepository authRepository
  }) : _authRepository = authRepository,
  super(const ForgotPasswordState()) {
    on<EmailInputChanged>(_onEmailInputChanged);
    on<RequestSubmitted>(_onRequestSubmitted);
  }
  final FirebaseAuthRepository _authRepository;

  void _onEmailInputChanged(EmailInputChanged event, Emitter<ForgotPasswordState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email));
  }

  void _onRequestSubmitted(RequestSubmitted event, Emitter<ForgotPasswordState> emit) async {
    if(state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authRepository.requestResetPassword(email: state.email.value);
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
          message: "Password reset email sent. Please check your inbox."
        ));
      } catch (e) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          message: "Error: ${e.toString().replaceAll("Exception: ", "")}"
        ));
      }
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        message: 'Oops! Something went wrong.'
      ));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
}
