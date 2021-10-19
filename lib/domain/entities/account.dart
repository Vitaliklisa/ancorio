import 'package:ancorio_rp/data/entities/account_entity.dart';

class Account {
  Account({
    this.uid,
    required this.customerId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.isAdmin,
  });
  String? uid;
  String customerId;
  String fullName;
  String email;
  String phoneNumber;
  bool? isAdmin;


}

extension AccountExtension on Account {
  AccountEntity toEntity() {
    return AccountEntity(
      uid: uid,
      customerId: customerId,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      isAdmin: isAdmin,
    );
  }
}
