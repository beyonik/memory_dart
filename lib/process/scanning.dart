import 'package:memory_dart/process/process.dart';

class MemoryScanning {
  static int? _inBuffer(List<int> buffer, List<int> bytes) {
    for (int i = 0; i < buffer.length - bytes.length; i++) {
      bool found = true;
      for (int j = 0; j < bytes.length; j++) {
        if (buffer[i + j] != bytes[j]) {
          found = false;
          break;
        }
      }
      if (found) {
        return i;
      }
    }
    return null;
  }

  static List<int> find(MemoryProcess process, List<int> bytes,
      int startAddress, int searchSize, bool stopAtFirst) {
    final bufferSize = 4096;
    var address = startAddress;
    List<int> matches = [];

    while (address < startAddress + searchSize) {
      final buffer = process.readBytes(address, bufferSize);
      final offsetInBuffer = _inBuffer(buffer, bytes);
      if (offsetInBuffer != null) {
        matches.add(address + offsetInBuffer);
        if (stopAtFirst) return matches;
      }

      address += bufferSize;
    }

    return matches;
  }
}
