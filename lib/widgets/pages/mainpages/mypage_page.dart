
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:all_of_football/widgets/component/user_profile_wiget.dart';
import 'package:flutter/material.dart';

class MyPageWidget extends StatefulWidget {
  const MyPageWidget({super.key});

  @override
  State<MyPageWidget> createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgIcon.asset(sIcon: SIcon.settings, style: SvgIconStyle(
              width: 25, height: 25
            )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 유저 정보
              CustomContainer(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // NavigatorHelper.push(context, const ProfileEditPage());
                          },
                          child: Stack(
                            children: [
                              const UserProfileWidget(diameter: 60),
                              Positioned(
                                bottom: 0, right: 0,
                                child: SvgIcon.asset(sIcon: SIcon.pen,
                                ),
                              ),
                            ]
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Text('닉네임닉네임',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: Theme.of(context).textTheme.displaySmall!.fontSize
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double containerWidth = constraints.maxWidth / 3;
                          return Row(
                            children: [
                              SizedBox(
                                width: containerWidth,
                                child: Column(
                                  children: [
                                    Text('5',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    const Text('즐겨찾기',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: containerWidth,
                                child: Column(
                                  children: [
                                    Text('5',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    const Text('어떤무언가',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: containerWidth,
                                child: Column(
                                  children: [
                                    Text('5',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    const Text('쿠폰',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),

              // 캐시
              CustomContainer(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('잔액',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                          ),
                        ),
                        Expanded(
                          child: Text('999,999,999원',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('충전',
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Text('내역',
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF6663E8)
                ),
                child: Text('함께하고 싶은 친구에게 공유해보세요',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize
                  ),
                ),
              ),
              const SizedBox(height: 15,),

              CustomContainer(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    _Menu(
                      svgIcon: SvgIcon.asset(sIcon: SIcon.clipboard,
                        style: SvgIconStyle(
                          width: 20, height: 20, color: Theme.of(context).colorScheme.primary
                        )
                      ),
                      title: '경기내역',
                      onPressed: (){

                      },
                    ),
                    const SizedBox(height: 10,),
                    _Menu(
                      svgIcon: SvgIcon.asset(sIcon: SIcon.coupon),
                      title: '쿠폰',
                      onPressed: (){

                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Menu extends StatelessWidget {

  final SvgIcon svgIcon;
  final String title;
  final Function() onPressed;

  const _Menu({super.key, required this.svgIcon, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 30,
          child: svgIcon,
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Text(title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        Icon(Icons.arrow_forward_ios_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 12,
        )

      ],
    );
  }
}

