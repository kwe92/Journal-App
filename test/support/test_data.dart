import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/features/shared/factory/factory.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';

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

final testEntry = JournalEntry(
  entryId: 1,
  uid: 1,
  content: 'calmness in activity',
  moodType: MoodType.okay.text,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);
