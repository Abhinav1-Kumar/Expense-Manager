import 'package:expense_manager/data/class.dart';

List<trans> abcd_top() {
  trans snap_food = trans();
  snap_food.time = 'jan 30,2022';
  snap_food.image = 'mac.jpg';
  snap_food.credit = false;
  snap_food.amount = '- \$ 100';
  snap_food.name = 'macdonald';
  trans snap = trans();
  snap.image = 'cre.png';
  snap.time = 'today';
  snap.credit = false;
  snap.name = 'Transfer';
  snap.amount = '-\$ 60';

  return [snap_food, snap];
}