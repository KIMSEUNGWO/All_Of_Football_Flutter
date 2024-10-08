
import 'package:all_of_football/api/service/user_service.dart';
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/domain/user/social_result.dart';
import 'package:all_of_football/notifier/user_notifier.dart';
import 'package:all_of_football/widgets/component/custom_scroll_refresh.dart';
import 'package:all_of_football/widgets/form/field_image_preview.dart';
import 'package:all_of_football/widgets/pages/mainDisplayLists/favorite_field_display.dart';
import 'package:all_of_football/widgets/pages/mainDisplayLists/match_soon_display.dart';
import 'package:all_of_football/widgets/pages/mainDisplayLists/recently_visit_match_display.dart';
import 'package:all_of_football/widgets/pages/mainDisplayLists/region_match_display.dart';
import 'package:all_of_football/widgets/pages/poppages/login_page.dart';
import 'package:all_of_football/widgets/pages/poppages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeWidget extends ConsumerStatefulWidget {
  const HomeWidget({super.key});

  @override
  ConsumerState<HomeWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeWidget> with AutomaticKeepAliveClientMixin {

  UniqueKey _refreshMatchSoon = UniqueKey();

  _refresh() {
    setState(() {
      _refreshMatchSoon = UniqueKey();
    });
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    if (state != null) _refreshMatchSoon = UniqueKey();
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
      body: CustomScrollView(
        slivers: [
          CustomScrollRefresh(onRefresh: _refresh),
          const SliverToBoxAdapter(child: _Banners(),),
          SliverToBoxAdapter(
            child: MatchSoonDisplay(
              key: _refreshMatchSoon,
            ),
          ),
          SliverToBoxAdapter(
            child: FavoriteFieldDisplay(),
          ),
          SliverToBoxAdapter(
            child: RecentlyVisitMatchDisplay(),
          ),
          SliverToBoxAdapter(
            child: RegionMatchDisplay(),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 36,),),

          SliverToBoxAdapter(
            child: Column(
              children: [
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
          )
        ],
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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 24),
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

