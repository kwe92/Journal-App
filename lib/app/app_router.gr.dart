// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i6;
import 'package:journal_app/features/entry/ui/entry_view.dart' as _i1;
import 'package:journal_app/features/journal/ui/journal_view.dart' as _i2;
import 'package:journal_app/features/shared/models/entry.dart' as _i5;
import 'package:journal_app/features/signin/signin_view.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    EntryRoute.name: (routeData) {
      final args = routeData.argsAs<EntryRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.EntryView(
          entry: args.entry,
          key: args.key,
        ),
      );
    },
    JournalRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.JournalView(),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>(
          orElse: () => const SignInRouteArgs());
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.SignInView(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.EntryView]
class EntryRoute extends _i4.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({
    required _i5.Entry entry,
    _i6.Key? key,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          EntryRoute.name,
          args: EntryRouteArgs(
            entry: entry,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EntryRoute';

  static const _i4.PageInfo<EntryRouteArgs> page =
      _i4.PageInfo<EntryRouteArgs>(name);
}

class EntryRouteArgs {
  const EntryRouteArgs({
    required this.entry,
    this.key,
  });

  final _i5.Entry entry;

  final _i6.Key? key;

  @override
  String toString() {
    return 'EntryRouteArgs{entry: $entry, key: $key}';
  }
}

/// generated route for
/// [_i2.JournalView]
class JournalRoute extends _i4.PageRouteInfo<void> {
  const JournalRoute({List<_i4.PageRouteInfo>? children})
      : super(
          JournalRoute.name,
          initialChildren: children,
        );

  static const String name = 'JournalRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SignInView]
class SignInRoute extends _i4.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i6.Key? key,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i4.PageInfo<SignInRouteArgs> page =
      _i4.PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}
