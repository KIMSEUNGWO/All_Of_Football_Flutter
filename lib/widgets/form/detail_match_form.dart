
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/domain/enums/match_enums.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:flutter/material.dart';
import 'package:all_of_football/domain/match/match.dart';

class MatchDetailFormWidget extends StatelessWidget {

  final Match match;

  const MatchDetailFormWidget({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return DetailDefaultFormWidget(
      title: '경기정보',
      child: LayoutBuilder(builder: (context, constraints) {
        double totalWidth = constraints.maxWidth - (7 * 2); // 전체 너비 ( 간격 개수 - 1개만큼 곱)
        double containerWidth = totalWidth / 3; // 각 Container의 너비
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomContainer(
                    width: containerWidth,
                    radius: BorderRadius.circular(10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Row(
                      children: [
                        SvgIcon.asset(sIcon: SIcon.star, style: SvgIconStyle(
                          color: Theme.of(context).colorScheme.secondary
                        )),
                        const SizedBox(width: 10,),
                        Text('제한없음',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomContainer(
                    width: containerWidth,
                    radius: BorderRadius.circular(10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Row(
                      children: [
                        SvgIcon.asset(sIcon: SIcon.gender, style: SvgIconStyle(
                            color: Theme.of(context).colorScheme.secondary
                        )),
                        const SizedBox(width: 10,),
                        Text(SexType.getName(match.sexType),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomContainer(
                    width: containerWidth,
                    radius: BorderRadius.circular(10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    child: Row(
                      children: [
                        SvgIcon.asset(sIcon: SIcon.soccer, style: SvgIconStyle(
                            color: Theme.of(context).colorScheme.secondary
                        )),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Text('${match.person} vs ${match.person} ${match.matchCount}파전',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7,),
              CustomContainer(
                width: double.infinity,
                radius: BorderRadius.circular(10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Row(
                  children: [
                    SvgIcon.asset(sIcon: SIcon.manager, style: SvgIconStyle(
                        color: Theme.of(context).colorScheme.secondary
                    )),
                    const SizedBox(width: 10,),
                    Text('아직 매니저님이 정해지지 않았어요.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
      },),
    );
  }
}
