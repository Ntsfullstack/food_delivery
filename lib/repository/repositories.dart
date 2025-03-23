

import 'package:food_delivery_app/models/food/dishes.dart';
import 'package:food_delivery_app/repository/dashboard_repository/dashboard_repository.dart';
import 'package:food_delivery_app/repository/dishes_repository/dishes_repository.dart';

import '../base/networking/api.dart';
import 'auth_repository/auth_repository.dart';
import 'get_list_customer_repository/customer_repository.dart';


///
/// --------------------------------------------
/// In this class where the [Function]s correspond to the API.
/// Which function here you will make it and you will consume it.
/// You can find and use on your Controller wich is the Controller extends [BaseController].
mixin class Repositories {

  // late HomeRepositories homeRepositories;
  late AuthRepository authRepositories;
  late UsersRepository usersRepositories;
  late ProductRepositories productRepositories;
  late DashboardRepositories dashboardRepositories;
  initBaseRepositories({required ApiService apiService}) {
    authRepositories = AuthRepository(apiService: apiService);
    usersRepositories = UsersRepository(apiService: apiService);
    productRepositories = ProductRepositories(apiService: apiService);
    dashboardRepositories = DashboardRepositories(apiService: apiService);


  }
}
