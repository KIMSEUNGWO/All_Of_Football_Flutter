
import 'package:all_of_football/api/service/user_service.dart';
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/domain/user/social_result.dart';
import 'package:all_of_football/widgets/form/field_image_preview.dart';
import 'package:all_of_football/widgets/pages/mainDisplayLists/favorite_field_display.dart';
import 'package:all_of_football/widgets/pages/mainDisplayLists/match_soon_display.dart';
import 'package:all_of_football/widgets/pages/mainDisplayLists/recently_visit_match_display.dart';
import 'package:all_of_football/widgets/pages/mainDisplayLists/region_match_display.dart';
import 'package:all_of_football/widgets/pages/poppages/login_page.dart';
import 'package:all_of_football/widgets/pages/poppages/register_page.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomeWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgIcon.asset(sIcon: SIcon.bell),
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16,),
            const _Banners(),
            const SizedBox(height: 24,),
            MatchSoonDisplay(),
            const SizedBox(height: 36,),
            FavoriteFieldDisplay(),
            const SizedBox(height: 36,),
            RecentlyVisitMatchDisplay(),
            RegionMatchDisplay(),
            const SizedBox(height: 36,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginWidget();
                }, fullscreenDialog: true));
              },
              child: Text('로그인 페이지 이동',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterWidget(social: SocialResult(socialId: 'asdfasdf', provider: SocialProvider.LINE, accessToken: 'accesstokenasdlfkajelfi13'));
                },));
              },
              child: Text('회원가입 페이지 이동',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                UserService.test();
              },
              child: Text('테스트 데이터 로드',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Banners extends StatelessWidget {
  const _Banners();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ImageSlider(
        images: [Image.asset('assets/banners/1.png', fit: BoxFit.cover,)],
        option: ImageSliderOption(
          height: 100,
          borderRadius: BorderRadius.circular(16),
          autoplay: false
        ),
      ),
    );
  }
}

