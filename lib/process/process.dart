import 'package:memory_dart/generic/ffi.dart';
import 'package:memory_dart/memory/memory_access.dart';
import 'package:memory_dart/module_enumerator/enum_modules.dart';
import 'package:memory_dart/process/ffi.dart';
import 'package:memory_dart/process/scanning.dart';
import 'package:memory_dart/process_enumerator/enum_processes.dart';

class MemoryProcess {
  int _processHandle = 0;
  int get processHandle => _processHandle;

  int _pid = 0;
  int get pid => _pid;

  bool get isValid =>
      _processHandle != 0 &&
      GenericFFI.GetExitCodeProcess(_processHandle) == 259; // STILL_ACTIVE

  MemoryProcess(String procName) {
    ProcessEnumerator.enumerate(
      (name, pid) => name == procName ? _pid = pid : null,
      returnParentPID: true,
    );

    if (pid <= 0) {
      print('[MemoryProcess] Failed to find process: $procName');
      return;
    }
    print("[MemoryProcess] Found process: $procName with pid: $pid");

    final PROCESS_ALL_ACCESS = (0x000F0000 | 0x00100000 | 0xFFF);
    final processHandle =
        MemoryProcessFFI.OpenProcess(PROCESS_ALL_ACCESS, false, pid);

    if (processHandle == 0) {
      print('[MemoryProcess] Failed to open process: ${procName}');
      return;
    }

    print('[MemoryProcess] Opened process: ${procName}');
    _processHandle = processHandle;
  }

  List<int> readBytes(int address, int numberOfBytes) =>
      MemoryAccess.ReadMemory(this, address, numberOfBytes);

  String readString(int address, int length) => readBytes(address, length)
      .map((byte) => String.fromCharCode(byte))
      .join();

  List<int> find_in_module(String module, List<int> bytes,
      {bool stopAtFirst = false}) {
    List<int> matches = [];
    ModuleEnumerator.enumerate(
      this,
      (name, base, size) => name == module
          ? matches.addAll(find(bytes,
              startAddress: base, searchSize: size, stopAtFirst: stopAtFirst))
          : null,
    );
    return matches;
  }

  List<int> find(List<int> bytes,
          {int startAddress = 0x400000,
          int searchSize = 0x7FFFFFFF,
          bool stopAtFirst = false}) =>
      MemoryScanning.find(this, bytes, startAddress, searchSize, stopAtFirst);

  void dispose() {
    if (_processHandle != 0) {
      MemoryProcessFFI.CloseHandle(_processHandle);
      _processHandle = 0;
    }
  }
}
