

import '../base/networking/api.dart';
import 'auth_repository/auth_repository.dart';


///
/// --------------------------------------------
/// In this class where the [Function]s correspond to the API.
/// Which function here you will make it and you will consume it.
/// You can find and use on your Controller wich is the Controller extends [BaseController].
mixin class Repositories {

  // late HomeRepositories homeRepositories;
  late AuthRepository authRepositories;
  initBaseRepositories({required ApiService apiService}) {
    authRepositories = AuthRepository(apiService: apiService);
  }
}
