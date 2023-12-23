import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../helper/show_snack_bar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginUser({required String email,required String password})async {
    emit(LoginLoading());
    try{
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

   emit(LoginSuccess());
    }
    on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(error: 'user not found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(error: 'wrong-password'));
      }
    } catch (ex) {
      emit(LoginFailure(error: 'there was an error'));

    }

  }
}
