import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/randomQuotes/ui/random_quotes_view_model.dart';
import 'package:journal_app/features/shared/ui/navigation_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class NavigationView extends StatelessWidget {
  final Color? backgroundColor;

  const NavigationView({
    this.backgroundColor,
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
          backgroundColor: backgroundColor ?? AppColors.darkGrey1,
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
                backgroundColor: AppColors.darkGrey1,
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
                    label: "Liked Quotes",
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
