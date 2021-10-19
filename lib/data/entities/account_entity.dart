import 'package:ancorio_rp/domain/entities/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountEntity {


  AccountEntity({
    this.uid,
    required this.customerId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.isAdmin,
  });

  factory AccountEntity.fromSnapshot(DocumentSnapshot snapshot) {
    return AccountEntity(
      uid: snapshot.id,
      customerId: snapshot['customerId'] as String,
      fullName: snapshot['fullName'] as String,
      email: snapshot['email'] as String,
      phoneNumber: snapshot['phoneNumber'] as String ,
      isAdmin: snapshot['isAdmin'] as bool,
    );
  }
  String? uid;
  String customerId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final bool? isAdmin;
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'customerId': customerId,
      'isAdmin': isAdmin,
    };
  }
}

extension AccountEntityExtension on AccountEntity {
  Account mapEntity() {
    return Account(
      uid: uid,
      customerId: customerId,
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      isAdmin: isAdmin,
    );
  }
}

extension AccountEntitiesExtension on List<AccountEntity> {
  List<Account> mapEntityList() {
    final List<Account> _accounts = [];
    forEach((_account) {
      _accounts.add(_account.mapEntity());
    });
    return _accounts;
  }
}

extension FutureAccountEntitiesExtension on Future<List<AccountEntity>> {
  Future<List<Account>> mapFutureList() async {
    return then((accounts) => accounts.mapEntityList());
  }
}
