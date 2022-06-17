import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:memory_dart/generic/ffi.dart';
import 'package:memory_dart/module_enumerator/ffi.dart';
import 'package:memory_dart/module_enumerator/types.dart';
import 'package:memory_dart/process/ffi.dart';
import 'package:memory_dart/process/process.dart';
import 'package:memory_dart/process_enumerator/ffi.dart';

class ModuleEnumerator {
  static void enumerate(MemoryProcess process,
      Function(String name, int base, int size) predicate) {
    Pointer<MODULEENTRY32> lpm = calloc<MODULEENTRY32>();
    lpm.ref.dwSize = 1064;

    final TH32CS_SNAPMODULES =
        0x00000008 | 0x00000010; // TH32CS_SNAPMODULE | TH32CS_SNAPMODULE32
    final snapshot = ProcessEnumeratorFFI.CreateToolhelp32Snapshot(
        TH32CS_SNAPMODULES, process.pid);

    if (ModuleEnumeratorFFI.Module32First(snapshot, lpm)) {
      while (ModuleEnumeratorFFI.Module32Next(snapshot, lpm)) {
        final name = lpm.ref.szModule;
        final base = lpm.ref.modBaseAddr;
        final size = lpm.ref.modBaseSize;

        predicate(name, base, size);
      }
    }

    calloc.free(lpm);
    MemoryProcessFFI.CloseHandle(snapshot);
  }
}
