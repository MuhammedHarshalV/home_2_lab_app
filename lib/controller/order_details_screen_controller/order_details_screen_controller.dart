import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/order_details_screen_controller/order_details_screen_state.dart';

class OrderDetailsScreenController
    extends StateNotifier<OrderDetailsScreenState> {
  OrderDetailsScreenController() : super(const OrderDetailsScreenState());

  void changeTab(int index) {
    state = state.copyWith(selectedTabIndex: index);
  }
}

final orderDetailsScreenProvider =
    StateNotifierProvider<
      OrderDetailsScreenController,
      OrderDetailsScreenState
    >((ref) {
      return OrderDetailsScreenController();
    });
