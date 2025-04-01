import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_menu_state.dart';

class NavigationMenuCubit extends Cubit<NavigationMenuState> {
  NavigationMenuCubit() : super(InitNavigationMenuState());
  
  void changePage(int index) {
    emit(UpdateNavigationMenuState(index));
  }
}
