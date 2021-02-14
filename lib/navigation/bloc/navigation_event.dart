import 'package:equatable/equatable.dart';
import 'package:fuzzgram/navigation/model/app_tab.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class TabTapped extends NavigationEvent {
  final AppTab tab;

  const TabTapped(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabTapped { tab: $tab }';
}