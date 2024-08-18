
import 'package:all_of_football/domain/field/field_simp.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/favorite_icon_button.dart';
import 'package:all_of_football/widgets/pages/poppages/field_detail_page.dart';
import 'package:flutter/material.dart';

class FavoriteFieldListWidget extends StatelessWidget {

  final FieldSimp _fieldSimp;
  final Function(FieldSimp) onChanged;

  const FavoriteFieldListWidget({super.key, required FieldSimp fieldSimp, required this.onChanged}): _fieldSimp = fieldSimp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FieldDetailWidget(fieldId: _fieldSimp.fieldId);
        },));
      },
      child: CustomContainer(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_fieldSimp.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
              ),
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text(_fieldSimp.region.ko,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w400,
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  ),
                ),
                const SizedBox(width: 5,),

                Expanded(
                  child: Text(_fieldSimp.address,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400,
                      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                      decoration: TextDecoration.underline
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 5,),
                FavoriteIconButtonWidget(
                  fieldId: _fieldSimp.fieldId,
                  on: _fieldSimp.favorite,
                  size: 15,
                  onChanged: (favorite) {
                    print('favorite : $favorite');
                    onChanged(_fieldSimp);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
