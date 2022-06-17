import 'dart:ffi';

import 'package:memory_dart/memory.dart';

typedef ReadProcessMemoryNative = Bool Function(
    IntPtr hProcess,
    Pointer<Void> lpBaseAddress,
    Pointer<Void> lpBuffer,
    IntPtr nSize,
    Pointer<IntPtr> lpNumberOfBytesRead);
typedef ReadProcessMemoryDart = bool Function(
    int hProcess,
    Pointer<Void> lpBaseAddress,
    Pointer<Void> lpBuffer,
    int nSize,
    Pointer<IntPtr> lpNumberOfBytesRead);

class MemoryFFI {
  static bool ReadProcessMemory(
          int hProcess,
          Pointer<Void> lpBaseAddress,
          Pointer<Void> lpBuffer,
          int nSize,
          Pointer<IntPtr> lpNumberOfBytesRead) =>
      Memory.kernel32!
              .lookupFunction<ReadProcessMemoryNative, ReadProcessMemoryDart>(
                  "ReadProcessMemory")(
          hProcess, lpBaseAddress, lpBuffer, nSize, lpNumberOfBytesRead);
}
