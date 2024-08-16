
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/domain/enums/field_enums.dart';
import 'package:all_of_football/domain/field/field.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/form/detail_default_form.dart';
import 'package:flutter/material.dart';

class FieldDetailFormWidget extends StatelessWidget {
  final Field field;
  const FieldDetailFormWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return DetailDefaultFormWidget(
      title: '구장정보',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomContainer(
                  radius: BorderRadius.circular(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    children: [
                      SvgIcon.asset(sIcon: SIcon.soccer, style: SvgIconStyle(
                          color: Theme.of(context).colorScheme.secondary
                      )),
                      const SizedBox(width: 10,),
                      Text('${field.fieldData.sizeX}m x ${field.fieldData.sizeY}m',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 7,),
              Expanded(
                child: CustomContainer(
                  radius: BorderRadius.circular(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    children: [
                      SvgIcon.asset(sIcon: SIcon.car, style: SvgIconStyle(
                          color: Theme.of(context).colorScheme.secondary
                      )),
                      const SizedBox(width: 10,),
                      Text(Parking.getName(field.fieldData.parking),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7,),
          Row(
            children: [
              Expanded(
                child: CustomContainer(
                  radius: BorderRadius.circular(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    children: [
                      SvgIcon.asset(sIcon: SIcon.shower, style: SvgIconStyle(
                          color: Theme.of(context).colorScheme.secondary
                      )),
                      const SizedBox(width: 10,),
                      Text(Shower.getName(field.fieldData.shower),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 7,),
              Expanded(
                child: CustomContainer(
                  radius: BorderRadius.circular(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Row(
                    children: [
                      SvgIcon.asset(sIcon: SIcon.toilet, style: SvgIconStyle(
                          color: Theme.of(context).colorScheme.secondary
                      )),
                      const SizedBox(width: 10,),
                      Text(Toilet.getName(field.fieldData.toilet),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 7,),
          CustomContainer(
            width: double.infinity,
            radius: BorderRadius.circular(10),
            constraints: const BoxConstraints(
                minHeight: 150
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgIcon.asset(sIcon: SIcon.megaphone, style: SvgIconStyle(
                        color: Theme.of(context).colorScheme.secondary
                    )),
                    const SizedBox(width: 10,),
                    Text('구장 특이사항',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Text(field.description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
