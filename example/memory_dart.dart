import 'package:memory_dart/memory.dart';
import 'package:memory_dart/process/process.dart';

void main(List<String> arguments) {
  Memory.initialize();

  final process = MemoryProcess("Spotify.exe");
  if (!process.isValid) return;
  final tokenAddress = process.find(
    [
      0x42,
      0x65,
      0x61,
      0x72,
      0x65,
      0x72,
      0x20,
    ],
    stopAtFirst: true,
    startAddress: 0x20000000,
  )[0];
  print(tokenAddress.toRadixString(16));
  final token = process.readString(tokenAddress, 386);
  print(token);
  final trackIdAddress = process.find_in_module(
      "chrome_elf.dll",
      [
        0x73,
        0x70,
        0x6f,
        0x74,
        0x69,
        0x66,
        0x79,
        0x3a,
        0x74,
        0x72,
        0x61,
        0x63,
        0x6b,
        0x3a
      ],
      stopAtFirst: true)[0];
  final trackId = process.readString(trackIdAddress, 36);
  print(trackId);
  process.dispose();
}
