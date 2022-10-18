import 'package:tatsam/Screens/instantScreen/data/model/instant_delete_response_model.dart';

class InstantDeleteStateModel {
  final String? userId;
  final InstantDeleteResponseModel? responseModel;

  InstantDeleteStateModel(
      {required this.userId, required this.responseModel});
}
