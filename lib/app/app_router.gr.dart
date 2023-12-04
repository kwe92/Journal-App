// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:journal_app/features/addEntry/ui/add_entry_view.dart' as _i1;
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view.dart'
    as _i4;
import 'package:journal_app/features/authentication/ui/signIn/signin_view.dart'
    as _i6;
import 'package:journal_app/features/entry/ui/entry_view.dart' as _i2;
import 'package:journal_app/features/journal/ui/journal_view.dart' as _i3;
import 'package:journal_app/features/mood/ui/mood_view.dart' as _i5;
import 'package:journal_app/features/shared/models/entry.dart' as _i9;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AddEntryRoute.name: (routeData) {
      final args = routeData.argsAs<AddEntryRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddEntryView(
          moodType: args.moodType,
          key: args.key,
        ),
      );
    },
    EntryRoute.name: (routeData) {
      final args = routeData.argsAs<EntryRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EntryView(
          entry: args.entry,
          key: args.key,
        ),
      );
    },
    JournalRoute.name: (routeData) {
      final args = routeData.argsAs<JournalRouteArgs>(
          orElse: () => const JournalRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.JournalView(key: args.key),
      );
    },
    MemberInfoRoute.name: (routeData) {
      final args = routeData.argsAs<MemberInfoRouteArgs>(
          orElse: () => const MemberInfoRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.MemberInfoView(key: args.key),
      );
    },
    MoodRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MoodView(),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>(
          orElse: () => const SignInRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SignInView(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AddEntryView]
class AddEntryRoute extends _i7.PageRouteInfo<AddEntryRouteArgs> {
  AddEntryRoute({
    required String moodType,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          AddEntryRoute.name,
          args: AddEntryRouteArgs(
            moodType: moodType,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEntryRoute';

  static const _i7.PageInfo<AddEntryRouteArgs> page =
      _i7.PageInfo<AddEntryRouteArgs>(name);
}

class AddEntryRouteArgs {
  const AddEntryRouteArgs({
    required this.moodType,
    this.key,
  });

  final String moodType;

  final _i8.Key? key;

  @override
  String toString() {
    return 'AddEntryRouteArgs{moodType: $moodType, key: $key}';
  }
}

/// generated route for
/// [_i2.EntryView]
class EntryRoute extends _i7.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({
    required _i9.Entry entry,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          EntryRoute.name,
          args: EntryRouteArgs(
            entry: entry,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EntryRoute';

  static const _i7.PageInfo<EntryRouteArgs> page =
      _i7.PageInfo<EntryRouteArgs>(name);
}

class EntryRouteArgs {
  const EntryRouteArgs({
    required this.entry,
    this.key,
  });

  final _i9.Entry entry;

  final _i8.Key? key;

  @override
  String toString() {
    return 'EntryRouteArgs{entry: $entry, key: $key}';
  }
}

/// generated route for
/// [_i3.JournalView]
class JournalRoute extends _i7.PageRouteInfo<JournalRouteArgs> {
  JournalRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          JournalRoute.name,
          args: JournalRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'JournalRoute';

  static const _i7.PageInfo<JournalRouteArgs> page =
      _i7.PageInfo<JournalRouteArgs>(name);
}

class JournalRouteArgs {
  const JournalRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'JournalRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.MemberInfoView]
class MemberInfoRoute extends _i7.PageRouteInfo<MemberInfoRouteArgs> {
  MemberInfoRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          MemberInfoRoute.name,
          args: MemberInfoRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MemberInfoRoute';

  static const _i7.PageInfo<MemberInfoRouteArgs> page =
      _i7.PageInfo<MemberInfoRouteArgs>(name);
}

class MemberInfoRouteArgs {
  const MemberInfoRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'MemberInfoRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.MoodView]
class MoodRoute extends _i7.PageRouteInfo<void> {
  const MoodRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MoodRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoodRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.SignInView]
class SignInRoute extends _i7.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i7.PageInfo<SignInRouteArgs> page =
      _i7.PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}
