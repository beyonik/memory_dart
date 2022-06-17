import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:memory_dart/memory/ffi.dart';
import 'package:memory_dart/process/process.dart';

class MemoryAccess {
  static List<int> ReadMemory(
      MemoryProcess process, int address, int numberOfBytes) {
    final buffer = malloc<Uint8>(numberOfBytes * sizeOf<Uint8>());
    final numberOfBytesRead = malloc<IntPtr>();
    MemoryFFI.ReadProcessMemory(
        process.processHandle,
        Pointer<Void>.fromAddress(address),
        buffer.cast<Void>(),
        numberOfBytes,
        numberOfBytesRead);

    //print(
    //    "[MemoryAccess] ReadProcessMemory: Read ${numberOfBytesRead.value} bytes from address: ${address.toRadixString(16)}");

    final retn = buffer.asTypedList(numberOfBytes).toList();

    malloc.free(buffer);
    malloc.free(numberOfBytesRead);
    return retn;
  }
}
