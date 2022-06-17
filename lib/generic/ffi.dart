import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:memory_dart/memory.dart';

typedef GetLastErrorNative = IntPtr Function();
typedef GetLastErrorDart = int Function();

typedef GetExitCodeProcessNative = Bool Function(
    IntPtr hProcess, Pointer<IntPtr> lpExitCode);
typedef GetExitCodeProcessDart = bool Function(
    int hProcess, Pointer<IntPtr> lpExitCode);

class GenericFFI {
  static int GetLastError() => Memory.kernel32!
      .lookupFunction<GetLastErrorNative, GetLastErrorDart>("GetLastError")();

  static int GetExitCodeProcess(int handle) {
    final exitCode = calloc<IntPtr>();
    final result = Memory.kernel32!
        .lookupFunction<GetExitCodeProcessNative, GetExitCodeProcessDart>(
            "GetExitCodeProcess")(handle, exitCode);
    final exitCodeValue = exitCode.value;
    calloc.free(exitCode);
    return exitCodeValue;
  }
}
