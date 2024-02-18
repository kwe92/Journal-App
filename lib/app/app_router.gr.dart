// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i18;

import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:journal_app/features/addEntry/ui/add_entry_view.dart' as _i1;
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view.dart'
    as _i8;
import 'package:journal_app/features/authentication/ui/signIn/signin_view.dart'
    as _i13;
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view.dart'
    as _i14;
import 'package:journal_app/features/calendar/ui/calendar_view.dart' as _i2;
import 'package:journal_app/features/entry/ui/entry_view.dart' as _i4;
import 'package:journal_app/features/farewell/farewell_view.dart' as _i5;
import 'package:journal_app/features/journal/ui/journal_view.dart' as _i6;
import 'package:journal_app/features/mood/ui/mood_view.dart' as _i9;
import 'package:journal_app/features/profile/edit_profile/edit_profile_view.dart'
    as _i3;
import 'package:journal_app/features/profile/profile_settings/ui/profile_settings_view.dart'
    as _i11;
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view.dart'
    as _i7;
import 'package:journal_app/features/quotes/randomQuotes/ui/random_quotes_view.dart'
    as _i12;
import 'package:journal_app/features/shared/models/journal_entry.dart' as _i17;
import 'package:journal_app/features/shared/ui/navigation_view.dart' as _i10;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    AddEntryRoute.name: (routeData) {
      final args = routeData.argsAs<AddEntryRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddEntryView(
          moodType: args.moodType,
          key: args.key,
        ),
      );
    },
    CalendarRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CalendarView(
          focusedDay: args.focusedDay,
          key: args.key,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EditProfileView(),
      );
    },
    EntryRoute.name: (routeData) {
      final args = routeData.argsAs<EntryRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.EntryView(
          entry: args.entry,
          key: args.key,
        ),
      );
    },
    FarewellRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.FarewellView(),
      );
    },
    JournalRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.JournalView(),
      );
    },
    LikedQuotesRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LikedQuotesView(),
      );
    },
    MemberInfoRoute.name: (routeData) {
      final args = routeData.argsAs<MemberInfoRouteArgs>(
          orElse: () => const MemberInfoRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.MemberInfoView(key: args.key),
      );
    },
    MoodRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MoodView(),
      );
    },
    NavigationRoute.name: (routeData) {
      final args = routeData.argsAs<NavigationRouteArgs>(
          orElse: () => const NavigationRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.NavigationView(
          backgroundColor: args.backgroundColor,
          key: args.key,
        ),
      );
    },
    ProfileSettingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ProfileSettingsView(),
      );
    },
    RandomQuotesRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.RandomQuotesView(),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>(
          orElse: () => const SignInRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.SignInView(key: args.key),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.SignUpView(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AddEntryView]
class AddEntryRoute extends _i15.PageRouteInfo<AddEntryRouteArgs> {
  AddEntryRoute({
    required String moodType,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          AddEntryRoute.name,
          args: AddEntryRouteArgs(
            moodType: moodType,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEntryRoute';

  static const _i15.PageInfo<AddEntryRouteArgs> page =
      _i15.PageInfo<AddEntryRouteArgs>(name);
}

class AddEntryRouteArgs {
  const AddEntryRouteArgs({
    required this.moodType,
    this.key,
  });

  final String moodType;

  final _i16.Key? key;

  @override
  String toString() {
    return 'AddEntryRouteArgs{moodType: $moodType, key: $key}';
  }
}

/// generated route for
/// [_i2.CalendarView]
class CalendarRoute extends _i15.PageRouteInfo<CalendarRouteArgs> {
  CalendarRoute({
    required DateTime focusedDay,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          CalendarRoute.name,
          args: CalendarRouteArgs(
            focusedDay: focusedDay,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const _i15.PageInfo<CalendarRouteArgs> page =
      _i15.PageInfo<CalendarRouteArgs>(name);
}

class CalendarRouteArgs {
  const CalendarRouteArgs({
    required this.focusedDay,
    this.key,
  });

  final DateTime focusedDay;

  final _i16.Key? key;

  @override
  String toString() {
    return 'CalendarRouteArgs{focusedDay: $focusedDay, key: $key}';
  }
}

/// generated route for
/// [_i3.EditProfileView]
class EditProfileRoute extends _i15.PageRouteInfo<void> {
  const EditProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EntryView]
class EntryRoute extends _i15.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({
    required _i17.JournalEntry entry,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          EntryRoute.name,
          args: EntryRouteArgs(
            entry: entry,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EntryRoute';

  static const _i15.PageInfo<EntryRouteArgs> page =
      _i15.PageInfo<EntryRouteArgs>(name);
}

class EntryRouteArgs {
  const EntryRouteArgs({
    required this.entry,
    this.key,
  });

  final _i17.JournalEntry entry;

  final _i16.Key? key;

  @override
  String toString() {
    return 'EntryRouteArgs{entry: $entry, key: $key}';
  }
}

/// generated route for
/// [_i5.FarewellView]
class FarewellRoute extends _i15.PageRouteInfo<void> {
  const FarewellRoute({List<_i15.PageRouteInfo>? children})
      : super(
          FarewellRoute.name,
          initialChildren: children,
        );

  static const String name = 'FarewellRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.JournalView]
class JournalRoute extends _i15.PageRouteInfo<void> {
  const JournalRoute({List<_i15.PageRouteInfo>? children})
      : super(
          JournalRoute.name,
          initialChildren: children,
        );

  static const String name = 'JournalRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LikedQuotesView]
class LikedQuotesRoute extends _i15.PageRouteInfo<void> {
  const LikedQuotesRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LikedQuotesRoute.name,
          initialChildren: children,
        );

  static const String name = 'LikedQuotesRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MemberInfoView]
class MemberInfoRoute extends _i15.PageRouteInfo<MemberInfoRouteArgs> {
  MemberInfoRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          MemberInfoRoute.name,
          args: MemberInfoRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MemberInfoRoute';

  static const _i15.PageInfo<MemberInfoRouteArgs> page =
      _i15.PageInfo<MemberInfoRouteArgs>(name);
}

class MemberInfoRouteArgs {
  const MemberInfoRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'MemberInfoRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.MoodView]
class MoodRoute extends _i15.PageRouteInfo<void> {
  const MoodRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MoodRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoodRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.NavigationView]
class NavigationRoute extends _i15.PageRouteInfo<NavigationRouteArgs> {
  NavigationRoute({
    _i18.Color? backgroundColor,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          NavigationRoute.name,
          args: NavigationRouteArgs(
            backgroundColor: backgroundColor,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'NavigationRoute';

  static const _i15.PageInfo<NavigationRouteArgs> page =
      _i15.PageInfo<NavigationRouteArgs>(name);
}

class NavigationRouteArgs {
  const NavigationRouteArgs({
    this.backgroundColor,
    this.key,
  });

  final _i18.Color? backgroundColor;

  final _i16.Key? key;

  @override
  String toString() {
    return 'NavigationRouteArgs{backgroundColor: $backgroundColor, key: $key}';
  }
}

/// generated route for
/// [_i11.ProfileSettingsView]
class ProfileSettingsRoute extends _i15.PageRouteInfo<void> {
  const ProfileSettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileSettingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.RandomQuotesView]
class RandomQuotesRoute extends _i15.PageRouteInfo<void> {
  const RandomQuotesRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RandomQuotesRoute.name,
          initialChildren: children,
        );

  static const String name = 'RandomQuotesRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SignInView]
class SignInRoute extends _i15.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i15.PageInfo<SignInRouteArgs> page =
      _i15.PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.SignUpView]
class SignUpRoute extends _i15.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i15.PageInfo<SignUpRouteArgs> page =
      _i15.PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}
