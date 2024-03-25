import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/analytics/ui/analytics_view_model.dart';
import 'package:journal_app/features/analytics/ui/widgets/indicator.dart';
import 'package:journal_app/features/shared/utilities/utils.dart';
import 'package:provider/provider.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AnalyticsViewModel>();

    return model.weightedMoods.isNotEmpty
        ? AspectRatio(
            aspectRatio: 1.3,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                model.setTouchedIndex(-1);
                                return;
                              }
                              model.setTouchedIndex(pieTouchResponse.touchedSection!.touchedSectionIndex);
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: List.generate(5, (i) {
                            final isTouched = i == model.touchedIndex;
                            final fontSize = isTouched ? 25.0 : 16.0;
                            final radius = isTouched ? 60.0 : 50.0;
                            const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
                            switch (i) {
                              case 0:
                                return PieChartSectionData(
                                  color: AppColors.moodAwesome,
                                  value: roundToNearest(4, (model.awesomeCount / model.totalMoodCount) * 100),
                                  title: '${roundToNearest(4, ((model.awesomeCount / model.totalMoodCount) * 100))}%',
                                  radius: radius,
                                  titleStyle: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: shadows,
                                  ),
                                );
                              case 1:
                                return PieChartSectionData(
                                  color: AppColors.moodHappy,
                                  value: roundToNearest(4, (model.happyCount / model.totalMoodCount) * 100),
                                  title: '${roundToNearest(4, ((model.happyCount / model.totalMoodCount) * 100))}%',
                                  radius: radius,
                                  titleStyle: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: shadows,
                                  ),
                                );
                              case 2:
                                return PieChartSectionData(
                                  color: AppColors.moodOkay,
                                  value: roundToNearest(4, (model.okayCount / model.totalMoodCount) * 100),
                                  title: '${roundToNearest(4, ((model.okayCount / model.totalMoodCount) * 100))}%',
                                  radius: radius,
                                  titleStyle: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: shadows,
                                  ),
                                );
                              case 3:
                                return PieChartSectionData(
                                  color: AppColors.moodBad,
                                  value: roundToNearest(4, (model.badCount / model.totalMoodCount) * 100),
                                  title: '${roundToNearest(4, ((model.badCount / model.totalMoodCount) * 100))}%',
                                  radius: radius,
                                  titleStyle: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: shadows,
                                  ),
                                );

                              case 4:
                                return PieChartSectionData(
                                  color: AppColors.moodTerrible,
                                  value: roundToNearest(4, (model.terribleCount / model.totalMoodCount) * 100),
                                  title: '${roundToNearest(4, ((model.terribleCount / model.totalMoodCount) * 100))}%',
                                  radius: radius,
                                  titleStyle: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: shadows,
                                  ),
                                );
                              default:
                                throw Error();
                            }
                          }),
                        ),
                      )),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Indicator(
                      color: AppColors.moodAwesome,
                      text: 'Awesome',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: AppColors.moodHappy,
                      text: 'Happy',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: AppColors.moodOkay,
                      text: 'Okay',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: AppColors.moodBad,
                      text: 'Bad',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: AppColors.moodTerrible,
                      text: 'Terrible',
                      isSquare: true,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          )
        : const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 100),
              child: Text(
                "No data to display...",
              ),
            ),
          );
  }
}
