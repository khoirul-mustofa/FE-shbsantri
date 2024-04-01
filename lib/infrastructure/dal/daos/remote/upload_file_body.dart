import 'dart:convert';

import 'param.dart';

class UploadImageBody extends RequestBody {
  final String fileName;
  final List<int> fileBytes;

  UploadImageBody(this.fileName, this.fileBytes);

  @override
  Map<String, dynamic> toJson() =>
      {'fileName': fileName, 'file': base64Encode(fileBytes)};
}

class UploadFileBody extends RequestBody {
  final String fileName;
  final String type;
  final String path;

  UploadFileBody(this.fileName, this.type, this.path);

  @override
  Map<String, dynamic> toJson() => {'fileName': fileName, 'file': path};
}
