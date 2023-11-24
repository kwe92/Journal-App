// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:diary_app/features/diary/ui/diary_view.dart' as _i1;
import 'package:diary_app/features/entry/ui/entry_view.dart' as _i2;
import 'package:diary_app/features/shared/models/entry.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    DiaryRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DiaryView(),
      );
    },
    EntryRoute.name: (routeData) {
      final args = routeData.argsAs<EntryRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EntryView(
          entry: args.entry,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.DiaryView]
class DiaryRoute extends _i3.PageRouteInfo<void> {
  const DiaryRoute({List<_i3.PageRouteInfo>? children})
      : super(
          DiaryRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiaryRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.EntryView]
class EntryRoute extends _i3.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({
    required _i4.Entry entry,
    _i5.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          EntryRoute.name,
          args: EntryRouteArgs(
            entry: entry,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EntryRoute';

  static const _i3.PageInfo<EntryRouteArgs> page =
      _i3.PageInfo<EntryRouteArgs>(name);
}

class EntryRouteArgs {
  const EntryRouteArgs({
    required this.entry,
    this.key,
  });

  final _i4.Entry entry;

  final _i5.Key? key;

  @override
  String toString() {
    return 'EntryRouteArgs{entry: $entry, key: $key}';
  }
}
