
import 'dart:math';

import 'package:all_of_football/component/local_storage.dart';
import 'package:all_of_football/component/svg_icon.dart';
import 'package:all_of_football/widgets/component/custom_container.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  final TextEditingController _textController = TextEditingController();

  Set<String> recentlySearchWord = {};
  bool recentlySearchIsDisable = false;

  addWord(String word) {
    setState(() {
      recentlySearchWord = {word, ...recentlySearchWord};
    });
  }
  deleteWord(String word) {
    setState(() {
      recentlySearchWord.remove(word);
    });
  }
  deleteAllWord() {
    setState(() {
      recentlySearchWord = {};
      recentlySearchIsDisable = true;
    });
  }

  textClear() {
    _textController.clear();
    setState(() {
      recentlySearchIsDisable = false;
    });
  }

  initRecentlySearchWord() async {
    Set<String> words = Set.of(await LocalStorage.getRecentlySearchWords());
    setState(() => recentlySearchWord = words);
  }

  onTapRecentlyWord(String word) {
    _textController.text = word;
    onChange(word);
    onSubmit(word);
  }

  onSubmit(String word) {
    if (word.isEmpty) return;
    addWord(word); // 최근
    print('onSubmit $word' );// 검색어 추가
  }

  onChange(String word) {
    setState(() => recentlySearchIsDisable = word.isNotEmpty);
  }

  @override
  void initState() {
    initRecentlySearchWord();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    LocalStorage.saveByRecentlySearchWord(recentlySearchWord.toList());
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  onSubmitted: (value) => onSubmit(value),
                  onChanged: (value) => onChange(value),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '구장을 입력해주세요.',
                    hintStyle: TextStyle(
                      color: Color(0xFF908E9B),
                    ),
                  ),
                  autofocus: true,
                ),
              ),
              const SizedBox(width: 10,),
              if (_textController.text.isNotEmpty)
                GestureDetector(
                  onTap: () => textClear(),
                  child: const Icon(Icons.cancel,
                    color: Color(0xFF797979),
                    size: 22,
                  ),
                ),
              const SizedBox(width: 10,),
              SvgIcon.asset(sIcon: SIcon.search),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32)
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          // 키보드 만큼의 padding을 줘야함
          padding: EdgeInsets.only(
            left: 20, right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!recentlySearchIsDisable && recentlySearchWord.isNotEmpty)
                  RecentlySearchWord(
                    words : recentlySearchWord.toList(),
                    addWord : addWord,
                    deleteWord : deleteWord,
                    deleteAllWord : deleteAllWord,
                    onTap : onTapRecentlyWord,
                  ),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecentlySearchWord extends StatefulWidget {

  final List<String> words;
  final Function(String word) addWord;
  final Function(String word) deleteWord;
  final Function() deleteAllWord;
  final Function(String word) onTap;

  const RecentlySearchWord({super.key, required this.words, required this.addWord, required this.deleteWord, required this.deleteAllWord, required this.onTap});



  @override
  State<RecentlySearchWord> createState() => _RecentlySearchWordState();
}

class _RecentlySearchWordState extends State<RecentlySearchWord> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('최근 검색어',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.deleteAllWord(),
                  child: Text('전체삭제',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                      color: Theme.of(context).colorScheme.secondary
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          CustomContainer(
            child: GridView.builder(
              shrinkWrap: true, // chid 위젯의 크기를 정해주지 않아싿면 true로 지정해줘야한다.
              physics: const NeverScrollableScrollPhysics(), // 스크롤 금지
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisExtent: 30,
                  mainAxisSpacing: 10
              ),
              itemCount: min(widget.words.length, 6),

              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => widget.onTap(widget.words[index]),
                        child: Text(widget.words[index],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () {
                        widget.deleteWord(widget.words[index]);
                      },
                      child: Icon(Icons.close,
                        size: 13,
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
