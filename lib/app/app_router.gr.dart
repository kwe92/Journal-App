// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:journal_app/features/addEntry/ui/add_entry_view.dart' as _i1;
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view.dart'
    as _i5;
import 'package:journal_app/features/authentication/ui/signIn/signin_view.dart'
    as _i8;
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view.dart'
    as _i9;
import 'package:journal_app/features/entry/ui/entry_view.dart' as _i3;
import 'package:journal_app/features/journal/ui/journal_view.dart' as _i4;
import 'package:journal_app/features/mood/ui/mood_view.dart' as _i6;
import 'package:journal_app/features/profile/edit_profile/edit_profile_view.dart'
    as _i2;
import 'package:journal_app/features/profile/profile_settings/ui/profile_settings_view.dart'
    as _i7;
import 'package:journal_app/features/shared/models/journal_entry.dart' as _i12;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AddEntryRoute.name: (routeData) {
      final args = routeData.argsAs<AddEntryRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddEntryView(
          moodType: args.moodType,
          key: args.key,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.EditProfileView(),
      );
    },
    EntryRoute.name: (routeData) {
      final args = routeData.argsAs<EntryRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.EntryView(
          entry: args.entry,
          key: args.key,
        ),
      );
    },
    JournalRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.JournalView(),
      );
    },
    MemberInfoRoute.name: (routeData) {
      final args = routeData.argsAs<MemberInfoRouteArgs>(
          orElse: () => const MemberInfoRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.MemberInfoView(key: args.key),
      );
    },
    MoodRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MoodView(),
      );
    },
    ProfileSettingsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfileSettingsView(),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>(
          orElse: () => const SignInRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SignInView(key: args.key),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.SignUpView(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AddEntryView]
class AddEntryRoute extends _i10.PageRouteInfo<AddEntryRouteArgs> {
  AddEntryRoute({
    required String moodType,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          AddEntryRoute.name,
          args: AddEntryRouteArgs(
            moodType: moodType,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEntryRoute';

  static const _i10.PageInfo<AddEntryRouteArgs> page =
      _i10.PageInfo<AddEntryRouteArgs>(name);
}

class AddEntryRouteArgs {
  const AddEntryRouteArgs({
    required this.moodType,
    this.key,
  });

  final String moodType;

  final _i11.Key? key;

  @override
  String toString() {
    return 'AddEntryRouteArgs{moodType: $moodType, key: $key}';
  }
}

/// generated route for
/// [_i2.EditProfileView]
class EditProfileRoute extends _i10.PageRouteInfo<void> {
  const EditProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EntryView]
class EntryRoute extends _i10.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({
    required _i12.JournalEntry entry,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          EntryRoute.name,
          args: EntryRouteArgs(
            entry: entry,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EntryRoute';

  static const _i10.PageInfo<EntryRouteArgs> page =
      _i10.PageInfo<EntryRouteArgs>(name);
}

class EntryRouteArgs {
  const EntryRouteArgs({
    required this.entry,
    this.key,
  });

  final _i12.JournalEntry entry;

  final _i11.Key? key;

  @override
  String toString() {
    return 'EntryRouteArgs{entry: $entry, key: $key}';
  }
}

/// generated route for
/// [_i4.JournalView]
class JournalRoute extends _i10.PageRouteInfo<void> {
  const JournalRoute({List<_i10.PageRouteInfo>? children})
      : super(
          JournalRoute.name,
          initialChildren: children,
        );

  static const String name = 'JournalRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MemberInfoView]
class MemberInfoRoute extends _i10.PageRouteInfo<MemberInfoRouteArgs> {
  MemberInfoRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          MemberInfoRoute.name,
          args: MemberInfoRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MemberInfoRoute';

  static const _i10.PageInfo<MemberInfoRouteArgs> page =
      _i10.PageInfo<MemberInfoRouteArgs>(name);
}

class MemberInfoRouteArgs {
  const MemberInfoRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'MemberInfoRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.MoodView]
class MoodRoute extends _i10.PageRouteInfo<void> {
  const MoodRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MoodRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoodRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ProfileSettingsView]
class ProfileSettingsRoute extends _i10.PageRouteInfo<void> {
  const ProfileSettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileSettingsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SignInView]
class SignInRoute extends _i10.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i10.PageInfo<SignInRouteArgs> page =
      _i10.PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.SignUpView]
class SignUpRoute extends _i10.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i10.PageInfo<SignUpRouteArgs> page =
      _i10.PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}
