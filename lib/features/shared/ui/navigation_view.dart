import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/quotes/randomQuotes/ui/random_quotes_view_model.dart';
import 'package:journal_app/features/shared/ui/navigation_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class NavigationView extends StatelessWidget {
  const NavigationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavigationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => RandomQuotesViewModel(),
        ),
      ],
      builder: (context, _) {
        final model = context.watch<NavigationViewModel>();

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
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
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book_online_rounded),
                    label: "Journal",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.article_outlined),
                    label: "Quotes",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outline),
                    label: "Favorite",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_rounded),
                    label: "Meanings",
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
