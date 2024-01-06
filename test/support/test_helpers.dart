import 'dart:convert';
import 'package:http/http.dart';
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:journal_app/features/journal/services/journal_entry_service.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'test_helpers.mocks.dart';

// TODO: Write Comments

//  TODO: implement unregisterServices function based on CareNav example

// annotation to generate mock classes
@GenerateNiceMocks([
  MockSpec<UserService>(),
  MockSpec<JournalEntryService>(),
  MockSpec<MockRouter>(as: Symbol('MockAppRouter')),
  MockSpec<Client>(),
  MockSpec<MoodService>(),
])

/// These annotations are used by mockito to generate mocks with build_runner
/// To add a new mocked class, just add it here and run 'dart run build_runner build'
/// With Nice Mocks we no longer have to stub out all our mocks

class MockRouter extends Mock implements AppRouter {}

Future<void> registerSharedServices() async {
  await locator.reset();
  getAndRegisterClientMock();
  getAndRegisterAppRouterMock();
  getAndRegisterUserServiceMock();
  getAndRegisterJournalEntryServiceMock();
  getAndRegisterMoodServiceMock();
}

// Individual Services and Utility Classes

AppRouter getAndRegisterAppRouterMock() {
  _removeRegistrationIfExists<AppRouter>();

  final MockRouter router = MockAppRouter();

  return router;
}

void unregisterServices() {
  _removeRegistrationIfExists<UserService>();
  _removeRegistrationIfExists<JournalEntryService>();
  _removeRegistrationIfExists<AppRouter>();
  _removeRegistrationIfExists<Client>();
  _removeRegistrationIfExists<MoodService>();
}

JournalEntryService getAndRegisterJournalEntryServiceMock({List<JournalEntry> initialEntries = const []}) {
  //  remove service if it is registered
  _removeRegistrationIfExists<JournalEntryService>();

  // represents deserialized data instantiated into domain models
  final List<JournalEntry> loadedEntries = initialEntries;

  // mock service
  final JournalEntryService service = MockJournalEntryService();

  // stub mocked methods and properties...
  when(service.journalEntries).thenReturn(loadedEntries);

  when(service.getAllEntries()).thenAnswer(
    (_) async => Future.value(
      Response('{"data":${loadedEntries.map((entry) => jsonEncode(entry.toJSON()))}}', 200),
    ),
  );

  // register mocked service as a singleton
  locator.registerSingleton<JournalEntryService>(service);

  return service;
}

// TODO: mock functions (methods) of UserService
UserService getAndRegisterUserServiceMock() {
  _removeRegistrationIfExists<UserService>();

  final UserService service = MockUserService();

  locator.registerSingleton<UserService>(service);

  return service;
}

Client getAndRegisterClientMock() {
  _removeRegistrationIfExists<Client>();

  final Client service = MockClient();

  locator.registerSingleton<Client>(service);

  return service;
}

MoodService getAndRegisterMoodServiceMock() {
  _removeRegistrationIfExists<MoodService>();

  final MoodService service = MockMoodService();

  // TODO: try using a map instead of MpEntry

  // when(service.getMoodByType(MoodType.okay)).thenReturn(
  //   const MapEntry(
  //     MoodType.okay,
  //     (
  //       color: AppColors.moodOkay,
  //       imagePath: MoodImagePath.moodOkay,
  //       defaultSize: MoodService.commonDefaultSize,
  //     ),
  //   ),
  // );

  locator.registerSingleton<MoodService>(service);

  return service;
}

/// unregisters an instance of an object or a factory / singleton by Type [T]
Future<void> _removeRegistrationIfExists<T extends Object>() async {
  if (locator.isRegistered<T>()) {
    await locator.unregister<T>();
  }
}
