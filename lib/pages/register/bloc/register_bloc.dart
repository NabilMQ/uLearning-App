import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_events.dart';
import 'package:ulearning_app/pages/register/bloc/register_states.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
   RegisterBloc() : super(RegisterStates()) {
     on <UsernameEvent>(_usernameEvent);
     on <EmailEvent>(_emailEvent);
     on <PasswordEvent>(_passwordEvent);
     on <RePasswordEvent>(_rePasswordEvent);
   }

   void _usernameEvent(UsernameEvent event, Emitter <RegisterStates> emit ){
    emit(state.copyWith(username: event.username));
   }

   void _emailEvent(EmailEvent event, Emitter <RegisterStates> emit ){
    emit(state.copyWith(email: event.email));
   }

   void _passwordEvent(PasswordEvent event, Emitter <RegisterStates> emit ){
    emit(state.copyWith(password: event.password));
   }

   void _rePasswordEvent(RePasswordEvent event, Emitter <RegisterStates> emit ){
    emit(state.copyWith(rePassword: event.rePassword));
   }
}