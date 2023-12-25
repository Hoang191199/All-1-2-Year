// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// import 'package:mooc_app/infrastructure/core/mooc_api_injectable_module.dart';
// import 'package:mooc_app/application/auth/sign_in_form/sign_in_form_bloc.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  required String environment,
  EnvironmentFilter? environmentFilter,
}) {
  // final gh = GetItHelper(get, environment, environmentFilter);
  // gh.lazySingleton<IMOOCAPI>(() => moocAPIInjectableModule.api);
  // gh.lazySingleton<ICourseRepository>(() => CourseRepository());
  return get;
}
