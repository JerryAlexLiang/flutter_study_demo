class PagingState2 {
  //默认页数50
  // int pageNum = 50;
  int pageNum = 10;

  int total = 0;
  // int page = 1;
  int page = -1;
  bool isLoading = false;
  bool isFirst = true;

  PagingState2({this.pageNum = 10});

  //是否加载完
  bool get isEnd => pageNum * page > total;

  //重置
  void reset() {
    isFirst = false;
    // page = 0;
    page = -1;
    isLoading = false;
  }

  //加载完成
  void loaded() {
    isLoading = false;
  }

  //加载下一页
  void nextPage() {
    if (isEnd) return;
    //如果没有到最后一页
    isLoading = true;
    page++;
  }

  @override
  String toString() {
    return 'PagingState{pageNum: $pageNum, total: $total, page: $page, isLoading: $isLoading, isFirst: $isFirst, isEnd:$isEnd}';
  }
}
