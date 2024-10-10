import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/app/app_router.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/authentication/services/auth_service.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/authentication/services/token_service.dart';
import 'package:journal_app/features/authentication/services/user_service.dart';
import 'package:journal_app/features/journal/services/journal_entry_service.dart';
import 'package:journal_app/features/mood/models/mood.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote_provider.dart';
import 'package:journal_app/features/quotes/shared/services/liked_quotes_service.dart';
import 'package:journal_app/features/quotes/shared/services/zen_quotes_api_service.dart';
import 'package:journal_app/features/shared/abstractions/base_user.dart';
import 'package:journal_app/features/shared/factory/factory.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/services/database_service.dart';
import 'package:journal_app/features/shared/services/device_size_service.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:journal_app/features/shared/services/mood_service.dart';
import 'package:journal_app/features/shared/services/time_service.dart';
import 'package:journal_app/features/shared/services/toast_service.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';
import 'package:journal_app/features/shared/utilities/string_extensions.dart';
import 'package:journal_app/features/shared/utilities/widget_keys.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'test_data.dart';
import 'test_helpers.mocks.dart';

// TODO: SQL Database needs to be mocked properly

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
  MockSpec<ToastService>(),
  MockSpec<LikedQuotesService>(),
  MockSpec<ZenQuotesApiService>(),
  MockSpec<DatabaseService>(),
  MockSpec<LikedQuoteProvider>()
])
class MockRouter extends Mock implements AppRouter {}

Future<void> registerSharedServices() async {
  await locator.reset();
  getAndRegisterClientMock();
  getAndRegisterAppRouterMock();
  getAndRegisterUserServiceMock();
  getAndRegisterJournalEntryServiceMock();
  getAndRegisterTokenServiceMock();
  getAndRegisterService<DeviceSizeService>(DeviceSizeService());
  getAndRegisterService<FlutterSecureStorage>(const FlutterSecureStorage());
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
  final router = MockAppRouter();

  // register mocked service as singleton
  locator.registerSingleton<AppRouter>(router);

  return router;
}

JournalEntryService getAndRegisterJournalEntryServiceMock({
  List<JournalEntry> initialEntries = const [],
  JournalEntry? newEntry,
}) {
  newEntry ??= JournalEntry(entryID: 1, moodType: '', content: '', createdAt: DateTime.now(), updatedAt: DateTime.now());

  //  remove service if registered
  _removeRegistrationIfExists<JournalEntryService>();

  // represents deserialized data instantiated into domain models
  final List<JournalEntry> loadedEntries = initialEntries;

  final addedEntry = newEntry;

  final updatedEntry =
      JournalEntry(moodType: testEntry.moodType, content: testEntry.content, createdAt: DateTime.now(), updatedAt: DateTime.now());

  // instantiate mock service
  final JournalEntryService service = MockJournalEntryService();

  // stub mocked methods and properties...
  when(service.journalEntries).thenReturn(loadedEntries);

  when(service.getAllEntries()).thenAnswer(
    (_) async => Future.value(),
  );

  when(service.updateEntry(updatedEntry)).thenAnswer(
    (_) async => Future.value(),
  );

  when(service.addEntry(addedEntry)).thenAnswer(
    (_) async => Future.value(
      addedEntry.entryID,
    ),
  );

  when(service.deleteEntry(addedEntry)).thenAnswer(
    (_) async => Future.value(),
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

  when(service.updateUserInfo(AbstractFactory.createUser(
    userType: UserType.updatedUser,
    firstName: testCurrentUser.firstName!.toLowerCase().capitalize().trim(),
    lastName: testCurrentUser.lastName!.toLowerCase().capitalize().trim(),
    email: testCurrentUser.email!.toLowerCase().trim(),
    phoneNumber: testCurrentUser.phoneNumber!.trim(),
  ))).thenAnswer(
    (_) async => Future.value(
      Response('{"success": "user updated"}', 200),
    ),
  );

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
    MoodTypeFilterOptions.awesome => AppColors.moodAwesome,
    MoodTypeFilterOptions.happy => AppColors.moodHappy,
    MoodTypeFilterOptions.okay => AppColors.moodOkay,
    MoodTypeFilterOptions.bad => AppColors.moodBad,
    MoodTypeFilterOptions.terrible => AppColors.moodTerrible,
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

AuthService getAndRegisterAuthServiceMock({BaseUser? user, String? availableEmail, String? loginEmail, String? loginPassword}) {
  //  remove service if registered
  _removeRegistrationIfExists<AuthService>();

  // instantiate mock service
  final AuthService service = MockAuthService();

  // stub mocked methods and properties...

  when(service.checkAvailableEmail(email: availableEmail ?? '')).thenAnswer((_) => Future.value(Response('', 200)));

  // TODO: figure out a way to return status code 200 without error json body string
  when(service.login(email: loginEmail ?? '', password: loginPassword ?? ''))
      .thenAnswer((_) => Future.value(Response('{"error": "there was an error"}', 200)));

  when(service.isLoggedIn).thenReturn(true);

  when(service.register(user: user ?? User())).thenAnswer((_) => Future.value(Response('{"error": "there was an error"}', 200)));

  when(service.deleteAccount()).thenAnswer((_) async => Future.value(Response('{"success": "so long farewell to you my friend"}', 200)));

  locator.registerSingleton<AuthService>(service);

  return service;
}

ToastService getAndRegisterToastServiceMock(BuildContext context, [Color? color]) {
  //  remove service if registered
  _removeRegistrationIfExists<ToastService>();

  // instantiate mock service
  final ToastService service = MockToastService();

  // stub mocked methods and properties...
  when(
    // Note: arguments and parameterized types must be an exact match to what is passed to the actual function called for stub to work
    service.popupMenu<bool>(
      context,
      color: color ?? Colors.white,
      parameters: const PopupMenuParameters(
        title: "Delete Entry",
        content: "Are you sure you want to delete this entry?",
        defaultResult: false,
        options: {
          "Delete Entry": true,
          "Cancel": false,
        },
      ),
    ),
  ).thenAnswer((_) async => Future.value(true));

  when(
    service.deleteAccountPopupMenu<bool>(
      context,
      parameters: const PopupMenuParameters(
        title: 'Permanantly delete account?',
        content: 'ALL account information will be removed from our system without recovery.',
        defaultResult: false,
        options: {
          "Delete": true,
          "Cancel": false,
        },
      ),
    ),
  ).thenAnswer((realInvocation) async => Future.value(true));

  locator.registerSingleton<ToastService>(service);

  return service;
}

LikedQuotesService getAndRegisterLikedQuotesService() {
  // remove service if exists
  _removeRegistrationIfExists<LikedQuotesService>();

  // mock service instantiation
  final LikedQuotesService service = MockLikedQuotesService();

  // mock class stubs
  when(service.likedQuotes).thenReturn(testLikedQuotes);

  when(service.getAllQuotes()).thenAnswer((_) => Future.value(Response('', 200)));

  when(service.addQuote(testQuotes[0])).thenAnswer((_) => Future.value(Response('', 200)));

  when(service.deleteLikedQuote(testLikedQuotes[0])).thenAnswer((_) => Future.value());

  // register mock to service locator
  locator.registerSingleton<LikedQuotesService>(service);

  return service;
}

ZenQuotesApiService getAndRegisterZenQuotesApiService() {
  _removeRegistrationIfExists<ZenQuotesApiService>();

  final ZenQuotesApiService service = MockZenQuotesApiService();

  locator.registerSingleton(service);

  when(service.quotes).thenReturn(testQuotes);

  when(service.fetchRandomQuotes()).thenAnswer((_) => Future.value());

  return service;
}

DatabaseService getAndRegisterDatabaseService() {
  // remove service if exists
  _removeRegistrationIfExists<DatabaseService>();

  // mock service instantiation
  final DatabaseService service = MockDatabaseService();

  // mock class stubs
  when(service.initialize()).thenAnswer((_) => Future.value());

  // register mock to service locator
  locator.registerSingleton<DatabaseService>(service);

  return service;
}

LikedQuoteProvider getAndRegisterLikedQuoteProvider() {
  _removeRegistrationIfExists<LikedQuoteProvider>();

  final LikedQuoteProvider service = MockLikedQuoteProvider();

  // mock class stubs
  // TODO: work on stubbing LikedQuoteProvider
  // when(service.de).thenAnswer((_) => Future.value());

  // register mock to service locator
  locator.registerSingleton<LikedQuoteProvider>(service);

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

/// overrides the functionality of overflow errors
void ignoreOverflowErrors(
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  bool ifIsOverflowError = false;
  bool isUnableToLoadAsset = false;

  // Detect overflow error.
  var exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
      (error) => error.value.toString().startsWith("A RenderFlex overflowed by"),
    );
    isUnableToLoadAsset = !exception.diagnostics.any(
      (error) => error.value.toString().startsWith("Unable to load asset"),
    );
  }

  // Ignore if is overflow error.
  if (ifIsOverflowError || isUnableToLoadAsset) {
    debugPrint('Ignored Error');
  } else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }
}

/// unregister an instance of an object or a factory / singleton by Type [T]
Future<void> _removeRegistrationIfExists<T extends Object>() async {
  if (locator.isRegistered<T>()) {
    await locator.unregister<T>();
  }
}

/// Necessary because Scaffolds require MediaQuery ancestor widget (MaterialApp)
/// https://stackoverflow.com/questions/48498709/widget-test-fails-with-no-mediaquery-widget-found
class TestingWrapper extends StatelessWidget {
  final Widget child;

  final bool portal;

  const TestingWrapper(
    this.child, {
    super.key,
    this.portal = false,
  });

  const TestingWrapper.portal(
    this.child, {
    super.key,
    this.portal = true,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        scaffoldMessengerKey: WidgetKey.rootScaffoldMessengerKey,
        locale: const Locale('en'),
        home: portal
            ? Portal(
                child: MediaQuery(
                data: const MediaQueryData(size: Size(1080, 2160)),
                child: Material(child: child),
              ))
            : MediaQuery(
                data: const MediaQueryData(size: Size(1080, 2160)),
                child: Material(child: child),
              ),
      );
}

Future<void> pumpView<T extends ChangeNotifier>(
  WidgetTester tester, {
  required Widget view,
  T? viewModel,
  T? changeNotifierValue,
}) async {
  await tester.pumpWidget(
    TestingWrapperv2<T>(
      view: view,
      viewModel: viewModel,
      changeNotifierValue: changeNotifierValue,
    ),
  );
}

class TestingWrapperv2<T extends ChangeNotifier> extends StatelessWidget {
  final Widget view;
  final T? viewModel;
  final T? changeNotifierValue;

  const TestingWrapperv2({
    required this.view,
    this.viewModel,
    this.changeNotifierValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel != null && changeNotifierValue != null) {
      throw Exception(
          'You can only provide a viewModel or a changeNotifierValue but not both, as you can not create two ChangeNotifiers for one ChangeNotifierProvider.');
    }
    return MaterialApp(
        scaffoldMessengerKey: WidgetKey.rootScaffoldMessengerKey,
        home: Portal(
          child: viewModel != null
              ? ChangeNotifierProvider<T>(
                  create: (context) => viewModel!,
                  builder: (context, _) => view,
                )
              : changeNotifierValue != null
                  ? ChangeNotifierProvider<T>.value(
                      value: changeNotifierValue!,
                      builder: (context, child) => view,
                    )
                  : view,
        ));
  }
}
