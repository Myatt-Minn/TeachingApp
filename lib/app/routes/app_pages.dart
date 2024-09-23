import 'package:get/get.dart';
import 'package:teamx/app/modules/forgot_password/views/ResetPasswordView.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/auth_gate/bindings/auth_gate_binding.dart';
import '../modules/auth_gate/views/auth_gate_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/on_boarding/bindings/on_boarding_binding.dart';
import '../modules/on_boarding/views/on_boarding_view.dart';
import '../modules/read_doc/bindings/read_doc_binding.dart';
import '../modules/read_doc/views/read_doc_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/useraccounts/bindings/useraccounts_binding.dart';
import '../modules/useraccounts/views/useraccounts_view.dart';
import '../modules/watch_training/bindings/watch_training_binding.dart';
import '../modules/watch_training/views/watch_training_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const ON_BOARDING = Routes.ON_BOARDING;
  static const MY_HOME = Routes.HOME; // change back to HOME
  static const INITIAL = Routes.SPLASH; // change back to HOME

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => const AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_GATE,
      page: () => const AuthGateView(),
      binding: AuthGateBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.READ_DOC,
      page: () => const ReadDocView(),
      binding: ReadDocBinding(),
    ),
    GetPage(
      name: _Paths.WATCH_TRAINING,
      page: () => const WatchTrainingView(),
      binding: WatchTrainingBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.USERACCOUNTS,
      page: () => const UseraccountsView(),
      binding: UseraccountsBinding(),
    ),
    GetPage(
      name: _Paths.RESETPASSWORD,
      page: () => ResetPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
