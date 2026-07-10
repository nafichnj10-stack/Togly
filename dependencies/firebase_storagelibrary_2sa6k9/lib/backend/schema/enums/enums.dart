import 'package:collection/collection.dart';
import 'package:ff_commons/flutter_flow/enums.dart';
export 'package:ff_commons/flutter_flow/enums.dart';

enum StorageListType {
  files,
  prefixes,
  filesAndPrefixes,
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (StorageListType):
      return StorageListType.values.deserialize(value) as T?;
    default:
      return null;
  }
}
