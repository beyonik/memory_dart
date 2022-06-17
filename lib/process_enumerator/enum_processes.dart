import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:memory_dart/process/ffi.dart';
import 'package:memory_dart/process_enumerator/ffi.dart';
import 'package:memory_dart/process_enumerator/types.dart';

class ProcessEnumerator {
  static enumerate(Function(String name, int pid) predicate,
      {bool returnParentPID = false}) {
    Pointer<PROCESSENTRY32> lppe = calloc<PROCESSENTRY32>();
    lppe.ref.dwSize = 556;

    final TH32CS_SNAPPROCESS = 0x00000002;

    int hSnapshot =
        ProcessEnumeratorFFI.CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

    if (ProcessEnumeratorFFI.Process32First(hSnapshot, lppe)) {
      while (ProcessEnumeratorFFI.Process32Next(hSnapshot, lppe)) {
        final name = lppe.ref.szExeFile;
        final pid = returnParentPID
            ? lppe.ref.th32ParentProcessID
            : lppe.ref.th32ProcessID;
        predicate(name, pid);
      }
    }

    calloc.free(lppe);
    MemoryProcessFFI.CloseHandle(hSnapshot);
  }
}
