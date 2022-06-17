import 'dart:ffi';

import 'package:memory_dart/util/string_unwrapper.dart';

class PROCESSENTRY32 extends Struct {
  @Int32()
  external int dwSize;
  @Int32()
  external int cntUsage;
  @Int32()
  external int th32ProcessID;

  external Pointer<Uint32> th32DefaultHeapID;
  @Int32()
  external int th32ModuleID;
  @Int32()
  external int cntThreads;
  @Int32()
  external int th32ParentProcessID;
  @Int32()
  external int pcPriClassBase;
  @Int32()
  external int dwFlags;
  @Array(260)
  external Array<Uint8> _szExeFile;

  String get szExeFile => StringUnwrapper.unwrap(_szExeFile);
}
