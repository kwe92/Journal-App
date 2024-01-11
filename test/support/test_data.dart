import 'package:journal_app/features/shared/factory/factory.dart';

final testCurrentUser = AbstractFactory.createUser(
  userType: UserType.curentUser,
  firstName: 'Baki',
  lastName: 'Hanma',
  email: 'baki@grappler.io',
  phoneNumber: '+11234567890',
);

final testTempUser = AbstractFactory.createUser(
  userType: UserType.curentUser,
  firstName: 'Baki',
  lastName: 'Hanma',
  email: 'baki@grappler.io',
  phoneNumber: '+11234567890',
);
