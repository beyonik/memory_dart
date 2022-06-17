import 'dart:ffi';

import 'package:memory_dart/util/dylib_wrapper.dart';
import 'package:memory_dart/util/win_path.dart';

export 'package:memory_dart/process/process.dart';
export 'package:memory_dart/memory/memory_access.dart';

class Memory {
  static DynamicLibrary? _kernel32;
  static DynamicLibrary? get kernel32 => _kernel32;

  static void initialize() {
    _kernel32 = load_dylib('${getWindowsFolder()}\\System32\\Kernel32.dll');
    if (_kernel32 == null) return;
  }
}
