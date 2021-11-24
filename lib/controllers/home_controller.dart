import 'package:get/get.dart';

class HomeController extends GetxController {
  final _isExpanded = false.obs;

  changeExpanded(outside) {
    _isExpanded.value = outside;
    print(_isExpanded.value);
  }

  get isExpanded => this._isExpanded.value;
}
