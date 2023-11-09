part of 'bottom_navigation_bloc.dart';

class BottomNavigationState extends Equatable {
  final PageIndex pageIndex;

  const BottomNavigationState({this.pageIndex = PageIndex.add});

  @override
  List<Object> get props => [
        pageIndex,
      ];

  BottomNavigationState copyWith({
    PageIndex? pageIndex,
  }) {
    return BottomNavigationState(
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}

enum PageIndex {
  add,
  sort,
  search,
}

extension PageIndexExt on PageIndex {
  String lableOf() {
    switch (this) {
      case PageIndex.add:
        return "Thêm Mã Mới";
      case PageIndex.sort:
        return "Xếp Chỗ";
      case PageIndex.search:
        return "Tìm kiếm";
    }
  }

  Widget get page {
    switch (this) {
      case PageIndex.add:
        return const AddNewCodeWrapperPage();
      case PageIndex.sort:
        return const SortWrapperPage();
      case PageIndex.search:
        return const CardStudentWrapperPage();

      default:
        return const EmptyWidget();
    }
  }
}
