import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unb/common/cubits/auth/auth_cubit.dart';
import 'package:unb/common/interfaces/i_http_service.dart';
import 'package:unb/common/services/dio_http_service.dart';
import 'package:unb/common/storage/user_preferences.dart';
import 'package:unb/main_module.dart';
import 'package:unb/main_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  final userPreferences = UserPreferences();
  final IHttpService dioHttpService = DioHttpService();
  final authCubit = AuthCubit(userPreferences, dioHttpService);

  return runApp(
    ModularApp(
      module: AppModule(authCubit: authCubit),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => authCubit..tryToLoadUserFromStorage()),
        ],
        child: const AppWidget(),
      ),
    ),
  );
}
