import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';
import 'package:journal_app/features/quotes/randomQuotes/ui/random_quotes_view_model.dart';
import 'package:journal_app/features/shared/services/scaffold_navigation_controller.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ScaffoldWithNavigationView extends StatelessWidget {
  final Color? backgroundColor;

  const ScaffoldWithNavigationView({
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: scaffoldNavigationController,
        ),
        ChangeNotifierProvider(
          create: (context) => RandomQuotesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LikedQuotesViewModel(),
        ),
      ],
      builder: (context, _) {
        final model = context.watch<ScaffoldNavigationController>();

        return Scaffold(
          backgroundColor: backgroundColor ?? const Color(0xff131b24),
          body: Center(
            child: model.widgetOptions[model.selectedIndex],
          ),
          bottomNavigationBar: Builder(builder: (context) {
            return Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                backgroundColor: const Color(0xff131b24),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book_online_rounded),
                    label: 'Journal',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.article_outlined),
                    label: 'Quotes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline),
                    label: 'Liked Quotes',
                  ),
                ],
                currentIndex: model.selectedIndex,
                selectedItemColor: Colors.white70,
                unselectedItemColor: Colors.white30,
                onTap: model.onItemTapped,
              ),
            );
          }),
        );
      },
    );
  }
}
