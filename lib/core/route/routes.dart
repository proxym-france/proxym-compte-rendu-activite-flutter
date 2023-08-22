import 'package:mycra_timesheet_app/core/domain/entity/router.dart';

final root = Router('root', '/', 'Home');
final onBoarding = Router('onBoarding', '/onboarding', 'On boarding');
final login = Router('login', '/login', 'Login');
final error = Router('error', '/error', 'Error');
