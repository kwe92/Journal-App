import 'dart:convert';
import 'package:http/http.dart';
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:journal_app/features/journal/services/journal_entry_service.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'test_helpers.mocks.dart';

// TODO: Write Comments

//  TODO: implement unregisterServices function based on CareNav example

@GenerateNiceMocks([
  MockSpec<UserService>(),
  MockSpec<JournalEntryService>(),
  MockSpec<MockRouter>(as: Symbol('MockAppRouter')),
  MockSpec<Client>(),
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
}

// Individual Services and Utility Classes

AppRouter getAndRegisterAppRouterMock() {
  _removeRegistrationIfExists<AppRouter>();

  final MockRouter router = MockAppRouter();

  return router;
}

JournalEntryService getAndRegisterJournalEntryServiceMock({List<JournalEntry> initialEntries = const []}) {
  //  remove service if it is registered
  _removeRegistrationIfExists<JournalEntryService>();

  // represents deserialized data instantiated into domain models
  List<JournalEntry> loadedEntries = initialEntries;

  // mock service
  final JournalEntryService service = MockJournalEntryService();

  // stub mocked methods and properties...
  when<List<JournalEntry>>(service.journalEntries).thenReturn(loadedEntries);

  when<Future<Response>>(service.getAllEntries()).thenAnswer(
    (_) async => Future<Response>.value(
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

/// unregisters an instance of an object or a factory / singleton by Type [T]
Future<void> _removeRegistrationIfExists<T extends Object>() async {
  if (locator.isRegistered<T>()) {
    await locator.unregister<T>();
  }
}
