import 'dart:convert';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:memory_dart/util/string_unwrapper.dart';

class MODULEENTRY32 extends Struct {
  @Int32()
  external int dwSize;
  @Int32()
  external int th32ModuleID;
  @Int32()
  external int th32ProcessID;
  @Int32()
  external int GlblcntUsage;
  @Int32()
  external int ProccntUsage;
  @IntPtr()
  external int modBaseAddr;
  @Int32()
  external int modBaseSize;
  @IntPtr()
  external int hModule;
  @Array(256)
  external Array<Uint8> _szModule;
  @Array(260)
  external Array<Uint8> _szExePath;

  String get szModule => StringUnwrapper.unwrap(_szModule);
  String get szExePath => StringUnwrapper.unwrap(_szExePath);
}
