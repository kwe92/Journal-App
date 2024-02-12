import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';
import 'package:journal_app/features/quotes/shared/utils/functions.dart';
import 'package:journal_app/features/quotes/shared/widgets/favorite_button.dart';
import 'package:journal_app/features/quotes/shared/widgets/share_button.dart';
import 'package:provider/provider.dart';

class LikedQuotesView extends StatelessWidget {
  const LikedQuotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LikedQuotesViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xff131b24),
      appBar: model.likedQuotes.isNotEmpty
          ? AppBar(
              scrolledUnderElevation: 0.0,
              backgroundColor: const Color(0xff131b24),
              title: Container(
                height: 52,
                width: 52,
                margin: const EdgeInsets.only(bottom: 16),
                child: SvgPicture.asset(
                  "assets/images/lotus-flower-bloom.svg",
                  color: Colors.pink[100],
                  fit: BoxFit.cover,
                ),
              ),
            )
          : null,
      body: model.likedQuotes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Find your inspiration...",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: SvgPicture.asset(
                      "assets/images/lotus-flower-bloom.svg",
                      // TODO: find a pink color you like
                      color: Colors.pink[100],
                      // color: Color(0xffe7bfd9),

                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: model.likedQuotes.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  margin: EdgeInsets.only(
                    left: 24,
                    top: !(index == 0) ? 24 : 0,
                    right: 24,
                    bottom: model.likedQuotes.length - 1 == index ? 24 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff1d2530),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        model.likedQuotes[index].quote,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShareButton(
                            size: 26.0,
                            contentToShare: shareQuote(model.likedQuotes[index]),
                          ),
                          Text(
                            model.likedQuotes[index].author,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          FavoriteButton(
                            onPressed: () => model.setLikedForQuote(model.likedQuotes[index]),
                            size: 26,
                            isLiked: model.likedQuotes[index].isLiked,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
