
import 'package:all_of_football/domain/field/field_data.dart';
import 'package:all_of_football/widgets/component/image_detail_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:skeletonizer/skeletonizer.dart';

class FieldImages extends StatefulWidget {

  final List<FieldImage> images;
  const FieldImages({super.key, required this.images});

  @override
  State<FieldImages> createState() => _FieldImagesState();
}

class _FieldImagesState extends State<FieldImages> {

  int _currentImageIndex = 1;

  void onImageChanged(int index) {
    setState(() => _currentImageIndex = index);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      height: 280,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
      ),
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1, // 각 슬라이드의 크기 조정 (0.8 = 80%)
              height: double.infinity,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 7),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                onImageChanged(index + 1);
              },
            ),
            items: widget.images
                .map((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImageDetailView(image: e.image)
                          ,fullscreenDialog: true
                      ));
                },
                child: e.image,
              );
            },)
                .toList(),
          ),

          Positioned(
            bottom: 10, right: 15,
            child: Container(
              width: 45,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF252525).withOpacity(0.7)
              ),
              child: Skeleton.ignore(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$_currentImageIndex',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                      ),
                    ),
                    Text(' / ${widget.images.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}