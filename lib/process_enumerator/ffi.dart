import 'dart:ffi';

import 'package:memory_dart/memory.dart';
import 'package:memory_dart/process_enumerator/types.dart';

typedef CreateToolhelp32SnapshotNative = IntPtr Function(
    Int32 dwFlags, Int32 th32ProcessID);
typedef CreateToolhelp32SnapshotDart = int Function(
    int dwFlags, int th32ProcessID);

typedef Process32Native = Bool Function(
    IntPtr hSnapshot, Pointer<PROCESSENTRY32> lppe);
typedef Process32Dart = bool Function(
    int hSnapshot, Pointer<PROCESSENTRY32> lppe);

class ProcessEnumeratorFFI {
  static int CreateToolhelp32Snapshot(int flags, int processID) =>
      Memory.kernel32!.lookupFunction<CreateToolhelp32SnapshotNative,
              CreateToolhelp32SnapshotDart>("CreateToolhelp32Snapshot")(
          flags, processID);

  static bool Process32First(int hSnapshot, Pointer<PROCESSENTRY32> lppe) =>
      Memory.kernel32!.lookupFunction<Process32Native, Process32Dart>(
          "Process32First")(hSnapshot, lppe);

  static bool Process32Next(int hSnapshot, Pointer<PROCESSENTRY32> lppe) =>
      Memory.kernel32!.lookupFunction<Process32Native, Process32Dart>(
          "Process32Next")(hSnapshot, lppe);
}
