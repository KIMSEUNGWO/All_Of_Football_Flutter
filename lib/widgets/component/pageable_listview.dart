

import 'package:all_of_football/component/pageable.dart';
import 'package:flutter/cupertino.dart';

class PageableListView<T> extends StatefulWidget {

  final int size;
  final IndexedWidgetBuilder separatorBuilder;
  final PageFutureCallback<T> future;
  final PageableViewWidget<T> builder;

  const PageableListView({super.key, required this.size, required this.separatorBuilder, required this.future, required this.builder});


  @override
  State<PageableListView<T>> createState() => _PageableListViewState<T>();
}

class _PageableListViewState<T> extends State<PageableListView<T>> {

  final List<T> _items = [];
  late Pageable _pageable;
  bool _loading = true;

  _fetch() async {
    List<T> moreData = await widget.future(_pageable);
    print('items size : ${_items.length}, moreData size : ${moreData.length}');
    setState(() {
      _pageable.hasMore = _pageable.size <= moreData.length;
      _items.addAll(moreData);
      _pageable.nextPage();
    });
  }
  _initData() async {
    List<T> data = await widget.future(_pageable);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _pageable.hasMore = _pageable.size <= data.length;
        _items.addAll(data);
        _loading = false;
      });
    },);
  }

  _initPageable() {
    _pageable = Pageable(
      size: widget.size,
    );
  }

  @override
  void initState() {
    _initPageable();
    _initData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (_loading) return Text('로딩중');
    return ListView.separated(
      separatorBuilder: widget.separatorBuilder,
      itemCount: _items.length,
      itemBuilder: (context, index) {

        return widget.builder(_items[index]);
      },
    );
  }
}
