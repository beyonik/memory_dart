import 'dart:ffi';

import 'package:memory_dart/memory.dart';
import 'package:memory_dart/module_enumerator/types.dart';

typedef Module32Native = Bool Function(
    IntPtr hSnapshot, Pointer<MODULEENTRY32> lppe);
typedef Module32Dart = bool Function(
    int hSnapshot, Pointer<MODULEENTRY32> lppe);

class ModuleEnumeratorFFI {
  static bool Module32First(snapshot, lppe) => Memory.kernel32!
          .lookupFunction<Module32Native, Module32Dart>('Module32First')(
      snapshot, lppe);

  static bool Module32Next(snapshot, lppe) => Memory.kernel32!
          .lookupFunction<Module32Native, Module32Dart>('Module32Next')(
      snapshot, lppe);
}
