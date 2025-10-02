import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../data/datasources/auth_remote_data_source.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDataSource authDataSource;

  AuthBloc(this.authDataSource) : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      // 1. Get request token
      final requestToken = await authDataSource.getRequestToken();

      // 2. Validate login
      final validatedToken = await authDataSource.validateLogin(
        username: event.username,
        password: event.password,
        requestToken: requestToken,
      );

      // 3. Create session
      final sessionId = await authDataSource.createSession(validatedToken);

      // 4. Get account info
      final user = await authDataSource.getAccount(sessionId);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
