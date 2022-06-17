import 'dart:ffi';

import 'package:memory_dart/memory.dart';

typedef OpenProcessNative = IntPtr Function(
    Int32 dwDesiredAccess, Bool bInheritHandle, Int32 dwProcessId);
typedef OpenProcessDart = int Function(
    int dwDesiredAccess, bool bInheritHandle, int dwProcessId);

typedef CloseHandleNative = Bool Function(IntPtr handle);
typedef CloseHandleDart = bool Function(int handle);

class MemoryProcessFFI {
  static int OpenProcess(int access, bool inheritHandle, int pID) =>
      Memory.kernel32!.lookupFunction<OpenProcessNative, OpenProcessDart>(
          "OpenProcess")(access, inheritHandle, pID);

  static bool CloseHandle(int handle) =>
      Memory.kernel32!.lookupFunction<CloseHandleNative, CloseHandleDart>(
          "CloseHandle")(handle);
}
