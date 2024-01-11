import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/authentication/services/auth_service.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/services/token_service.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:journal_app/features/journal/services/journal_entry_service.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/models/new_entry.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:journal_app/features/shared/services/time_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'test_helpers.mocks.dart';

// Generating Mock CLasses to be Stubbed

//   - @GenerateNiceMocks is an annotation used by mockito
//     to generate a mock library with build_runner

//   - To add a new mocked class to the generated library
//     pass the class as a Type to MockSpec<T>() within
//     the constant mock list and run 'dart run build_runner build'
//   - With Nice Mocks we no longer have to manually mock all of our classes individually

@GenerateNiceMocks([
  MockSpec<UserService>(),
  MockSpec<JournalEntryService>(),
  MockSpec<MockRouter>(as: Symbol('MockAppRouter')),
  MockSpec<Client>(),
  MockSpec<MoodService>(),
  MockSpec<TokenService>(),
  MockSpec<TimeService>(),
  MockSpec<ImageService>(),
  MockSpec<AuthService>(),
])
class MockRouter extends Mock implements AppRouter {}

Future<void> registerSharedServices() async {
  await locator.reset();
  getAndRegisterClientMock();
  getAndRegisterAppRouterMock();
  getAndRegisterUserServiceMock();
  getAndRegisterJournalEntryServiceMock();
  getAndRegisterTokenServiceMock();
  // getAndRegisterMoodServiceMock();
}

// Individual Services and Utility Functions

void unregisterServices() {
  _removeRegistrationIfExists<UserService>();
  _removeRegistrationIfExists<JournalEntryService>();
  _removeRegistrationIfExists<AppRouter>();
  _removeRegistrationIfExists<Client>();
  _removeRegistrationIfExists<MoodService>();
  _removeRegistrationIfExists<TokenService>();
}

AppRouter getAndRegisterAppRouterMock() {
  //  remove service if registered
  _removeRegistrationIfExists<AppRouter>();

  // instantiate mock service
  final MockRouter router = MockAppRouter();

  // register mocked service as singleton
  locator.registerSingleton<MockRouter>(router);

  return router;
}

JournalEntryService getAndRegisterJournalEntryServiceMock({
  List<JournalEntry> initialEntries = const [],
  NewEntry newEntry = const NewEntry(moodType: '', content: ''),
}) {
  //  remove service if registered
  _removeRegistrationIfExists<JournalEntryService>();

  // represents deserialized data instantiated into domain models
  final List<JournalEntry> loadedEntries = initialEntries;

  final addedEntry = newEntry;

  // instantiate mock service
  final JournalEntryService service = MockJournalEntryService();

  // stub mocked methods and properties...
  when(service.journalEntries).thenReturn(loadedEntries);

  when(service.getAllEntries()).thenAnswer(
    (_) async => Future.value(
      Response('{"data":${loadedEntries.map((entry) => jsonEncode(entry.toJSON()))}}', 200),
    ),
  );

  // TODO: verify functionality is working | atm not working
  when(service.addEntry(addedEntry)).thenAnswer(
    (_) async => Future.value(
      Response('{"data": ${jsonEncode(addedEntry.toJSON())}}', 200),
    ),
  );

  // register mocked service as singleton
  locator.registerSingleton<JournalEntryService>(service);

  return service;
}

UserService getAndRegisterUserServiceMock([BaseUser? authenticatedUser]) {
  final currentUser = authenticatedUser;

  //  remove service if registered
  _removeRegistrationIfExists<UserService>();

  // instantiate mock service
  final UserService service = MockUserService();

  // stub mocked methods and properties...
  when(service.clearUserData()).thenReturn(null);

  when(service.currentUser).thenReturn(currentUser);

  // register mocked service as singleton
  locator.registerSingleton<UserService>(service);

  return service;
}

Client getAndRegisterClientMock() {
  //  remove service if registered
  _removeRegistrationIfExists<Client>();

  // instantiate mock service
  final Client service = MockClient();

  // register mocked service as singleton
  locator.registerSingleton<Client>(service);

  return service;
}

MoodService getAndRegisterMoodServiceMock(String moodType, double imageSize) {
  //  remove service if registered
  _removeRegistrationIfExists<MoodService>();

  // instantiate mock service
  final MoodService service = MockMoodService();

  // stub mocked methods and properties...
  when(service.createMoodByType(moodType, imageSize)).thenReturn(Mood(
    moodColor: AppColors.mainThemeColor,
    moodImagePath: '',
    imageSize: imageSize,
    moodText: moodType,
  ));

  // stub mocked methods and properties...
  when(service.getMoodColorByType(moodType)).thenReturn(switch (moodType) {
    StaticMoodType.awesome => AppColors.moodAwesome,
    StaticMoodType.happy => AppColors.moodHappy,
    StaticMoodType.okay => AppColors.moodOkay,
    StaticMoodType.bad => AppColors.moodBad,
    StaticMoodType.terrible => AppColors.moodTerrible,
    String() => AppColors.moodAwesome,
  });

  // register mocked service as singleton
  locator.registerSingleton<MoodService>(service);

  return service;
}

TokenService getAndRegisterTokenServiceMock() {
  //  remove service if registered
  _removeRegistrationIfExists<TokenService>();

  // instantiate mock service
  final TokenService service = MockTokenService();

  // stub mocked methods and properties...
  when(service.removeAccessTokenFromStorage()).thenAnswer((_) async => Future.value());

  var token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
      '.eyJpc3MiOiJodHRwczovL2V4YW1wbGUuYXV0aDAuY29tLyIsImF1ZCI6Imh0dHBzOi8vYXBpLmV4YW1wbGUuY29tL2NhbGFuZGFyL3YxLyIsInN1YiI6InVzcl8xMjMiLCJpYXQiOjE0NTg3ODU3OTYsImV4cCI6MTQ1ODg3MjE5Nn0'
      '.CA7eaHjIHz5NxeIJoFK9krqaeZrPLwmMmgI_XiQiIkQ';

  var responseBody = {'jwt': token};

  when(service.saveTokenData(responseBody)).thenAnswer((_) async => Future.value());

  when(service.saveAccessTokenToStorage(token)).thenAnswer((realInvocation) async => Future.value());

  when(service.getAccessTokenFromStorage()).thenAnswer((realInvocation) async => Future.value(token));

  // register mocked service as singleton
  locator.registerSingleton<TokenService>(service);

  return service;
}

TimeService getAndRegisterTimeServiceMock(DateTime now) {
  //  remove service if registered
  _removeRegistrationIfExists<TimeService>();

  // instantiate mock service
  final TimeService service = MockTimeService();

  // stub mocked methods and properties...
  when(service.getContinentalTime(now)).thenReturn(DateFormat.H().format(now));

  //   int get continentalTime {
  //   return int.parse(timeService.getContinentalTime(now));
  // }

  // String get dayOfWeekByName => timeService.dayOfWeekByName(now);

  // String get timeOfDay => timeService.timeOfDay(now);

  // register mocked service as singleton

  locator.registerSingleton<TimeService>(service);

  return service;
}

ImageService getAndRegisterImageServiceMock() {
  //  remove service if registered
  _removeRegistrationIfExists<ImageService>();

  // instantiate mock service
  final ImageService service = MockImageService();

  // stub mocked methods and properties...
  when(service.getRandomMindfulImage()).thenReturn(Image.asset("assets/images/mindful01.avif").image);

  locator.registerSingleton<ImageService>(service);

  return service;
}

AuthService getAndRegisterAuthService() {
  //  remove service if registered
  _removeRegistrationIfExists<AuthService>();

  // instantiate mock service
  final AuthService service = MockAuthService();

  // stub mocked methods and properties...

  locator.registerSingleton<AuthService>(service);

  return service;
}

T getAndRegisterService<T extends Object>(dynamic service, {bool singleton = true, bool lazySingleton = false}) {
  assert(service.runtimeType == T);

  _removeRegistrationIfExists<T>();

  if (lazySingleton) {
    locator.registerLazySingleton<T>(() => service);
  } else if (singleton) {
    locator.registerSingleton<T>(service);
  } else {
    locator.registerFactory<T>(() => service);
  }

  return locator.get<T>();
}

/// unregister an instance of an object or a factory / singleton by Type [T]
Future<void> _removeRegistrationIfExists<T extends Object>() async {
  if (locator.isRegistered<T>()) {
    await locator.unregister<T>();
  }
}

// base get and register function

//  getAndRegister_Mock() {
//   //  remove service if registered
//   _removeRegistrationIfExists<>();

//   // instantiate mock service
//   final  service = ();

//   // register mocked service as singleton
//   locator.registerSingleton<>(service);

//   // stub mocked methods and properties...

//   return service;
// }
