import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/analytics/ui/analytics_view_model.dart';
import 'package:journal_app/features/analytics/ui/widgets/line_chart.dart';
import 'package:journal_app/features/analytics/ui/widgets/pie_chart.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:journal_app/features/shared/ui/hideable_mood_count.dart';
import 'package:journal_app/features/shared/ui/widgets/container_with_shadow.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnalyticsViewModel(),
      builder: (context, _) {
        return ViewModelBuilder<AnalyticsViewModel>.reactive(
          viewModelBuilder: () => AnalyticsViewModel(),
          builder: (context, AnalyticsViewModel model, _) {
            return BaseScaffold(
              title: "Analytics",
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      model.isMonthlyView ? 'Monthly Mood Statistics' : 'Weekly Mood Statistics',
                      style: const TextStyle(
                        color: AppColors.mainThemeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: NestedScrollView(
                      floatHeaderSlivers: true,
                      // MOOD COUNT
                      headerSliverBuilder: (context, _) => [
                        HideableMoodCount<AnalyticsViewModel>(
                          showFilter: false,
                        )
                      ],
                      body: const SizedBox(),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.23,
                          child: Stack(
                            children: <Widget>[
                              ContainerWithShadow(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 42,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 16, left: 6),
                                        child: LineChartWidget(
                                          spots: [
                                            for (int i = 0; i < model.groupedMoodsData.length; i++)
                                              () {
                                                // print("model.groupedMoodsData.length: ${model.groupedMoodsData.length}");
                                                final entry = model.groupedMoodsData[i].entries.toList()[0];

                                                // debugPrint("entry: $entry");

                                                return FlSpot(i + 1.0, entry.value * 4);
                                              }()
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const ContainerWithShadow(
                          child: PieChartWidget(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
