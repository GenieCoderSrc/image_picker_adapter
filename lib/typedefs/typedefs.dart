import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef ImageCallback = Function(XFile? xFile);
typedef VoidImageCallback = void Function(XFile? file);
typedef WidgetImageBuilder = Widget Function(XFile? file);

typedef MountedCheck = bool Function();
