abstract class NavigationMenuState {
  final int currentPageIndex;

  NavigationMenuState({required this.currentPageIndex});
}

class InitNavigationMenuState extends NavigationMenuState {
  InitNavigationMenuState() : super(currentPageIndex: 0);

}
class UpdateNavigationMenuState extends NavigationMenuState {
  UpdateNavigationMenuState(pageIndex) : super(currentPageIndex: pageIndex);

}
