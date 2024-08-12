
import 'package:all_of_football/component/svg_icon.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 170, bottom: MediaQuery.of(context).padding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: SvgIcon.asset(sIcon: SIcon.logo)),

            Column(
              children: [
                _SocialBtn(
                  title: '라인으로 계속하기',
                  fontColor: Colors.white,
                  color: const Color(0xFF08BF5B),
                  sIcon: SIcon.lineLogo,
                  onPressed: () {},
                ),
                const SizedBox(height: 12,),
                _SocialBtn(
                  title: '카카오로 계속하기',
                  fontColor: const Color(0xFF181602),
                  color: const Color(0xFFF3DA01),
                  sIcon: SIcon.kakaoLogo,
                  onPressed: () {},
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF666666).withOpacity(0.5)
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text('다른 계정으로 계속하기'),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF666666).withOpacity(0.5)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const _SmallSocialBtn(
                  icon: Icon(Icons.apple, color: Colors.white, size: 25,),
                  color: Color(0xFF434343),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class _SocialBtn extends StatelessWidget {

  final String title;
  final Color color;
  final Color fontColor;
  final SIcon sIcon;
  final Function() onPressed;

  const _SocialBtn({required this.title, required this.color, required this.fontColor, required this.sIcon, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Row(
        children: [
          SvgIcon.asset(sIcon: sIcon, style: SvgIconStyle(
            width: 20, height: 20, color: fontColor
          )),
          Expanded(
            child: Center(
              child: Text(title,
                style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Theme.of(context).textTheme.displaySmall!.fontSize
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SmallSocialBtn extends StatelessWidget {
  
  final Icon icon;
  final Color color;

  const _SmallSocialBtn({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}


