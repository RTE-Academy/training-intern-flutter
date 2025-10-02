import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/entities/user.dart';

abstract class AuthEvent {}
class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent(this.username, this.password);
}

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase(event.username, event.password);
      result.fold(
            (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
            (user) => emit(AuthSuccess(user)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    return "Login failed!";
  }
}
