
import 'package:aura_maison_e_commerce/features/auth/data/datasources/register_service.dart';
import 'package:aura_maison_e_commerce/features/auth/data/models/register_model.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterService _registerService = RegisterService();

  RegisterCubit() : super(RegisterInitial());

  Future<void> register(RegisterModel registerModel) async {
    if (state is RegisterLoading) return;

    emit(RegisterLoading());

    try {
      await _registerService.signUp(registerModel);

      emit(RegisterSuccess(email: registerModel.email));
    } catch (e) {
      emit(
        RegisterFailure(
          msg: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
