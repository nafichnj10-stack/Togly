import "package:firebase_storagelibrary_2sa6k9/backend/schema/enums/enums.dart"
    as firebase_storagelibrary_2sa6k9_enums;
import 'package:ff_commons/flutter_flow/enums.dart';
export 'package:ff_commons/flutter_flow/enums.dart';

enum HeartbeatStatus {
  pending,
  completed,
  expired,
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (HeartbeatStatus):
      return HeartbeatStatus.values.deserialize(value) as T?;
    case (firebase_storagelibrary_2sa6k9_enums.StorageListType):
      return firebase_storagelibrary_2sa6k9_enums.StorageListType.values
          .deserialize(value) as T?;
    default:
      return null;
  }
}
