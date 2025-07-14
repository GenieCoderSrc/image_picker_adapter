import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

typedef ImageCallback = Function(XFile? xFile);
typedef VoidImageCallback = void Function(XFile? file);
typedef WidgetImageBuilder = Widget Function(XFile? file);

typedef MountedCheck = bool Function();
