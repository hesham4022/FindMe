import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:find_me_app/core/resources/images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

DateTime? dateTimeFromJson(String? json) =>
    json != null ? DateTime.parse(json).toLocal() : null;

/// Convert DateTime to utc then to iso8601 string
String? dateTimeToString(DateTime? date) => date?.toUtc().toIso8601String();

bool checkFor<T>(T object) {
  if (object != null) {
    if (object is String) {
      if (object.isNotEmpty) {
        return true;
      }
      return false;
    }
    //
    else if (object is List) {
      if (object.isNotEmpty) {
        return true;
      }
      return false;
    }
    //
    else if (object is Map) {
      if (object.isNotEmpty) {
        return true;
      }
      return false;
    }
    return true;
  }
  return false;
}

class WriteToFileArgs {
  final Object data;
  final RootIsolateToken token;

  WriteToFileArgs(
    this.data,
    this.token,
  );
}

/// Encode data to json and write to temp file
Future<File> kWriteToFile(WriteToFileArgs args) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(args.token);

  final jsonString = jsonEncode(args.data);

  File tempFile = File('${Directory.systemTemp.path}/temp.json');
  return await tempFile.writeAsString(jsonString);
}

//---------------------------- Image Picker ------------------------------------
/// Pick Image from source and compress it 50%
Future<UploadFile?> kPickImage(
    [ImageSource imageSource = ImageSource.gallery]) async {
  try {
    final result = await ImagePicker().pickImage(source: imageSource);
    if (result == null) {
      return null;
    }

    return UploadFile(
      file: File(result.path),
      name: result.name,
    );
  } catch (e) {
    log("Pick file error: ${e.toString()}");
    return null;
  }
}

Future<UploadFile?> kPickFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx'
      ], // Specify file types
    );

    if (result == null) {
      return null;
    }

    return UploadFile(
      file: File(result.files.first.path!),
      name: result.files.first.name,
      ext: result.files.first.extension!,
      size: result.files.first.size / 1024,
    );
  } catch (e) {
    log("Pick file error: ${e.toString()}");
    return null;
  }
}

// Future<File?> cropSquareImage(
//   File? imageFile, [
//   bool crop = true,
//   CropAspectRatioPreset cropAspectRatio = CropAspectRatioPreset.square,
//   CropStyle cropStyle = CropStyle.rectangle,
// ]) async {
//   if (imageFile == null) return null;

//   final croppedFile = await ImageCropper.platform.cropImage(
//     sourcePath: imageFile.path,
//     // aspectRatio: cropAspectRatio,
//     compressQuality: 0,
//     compressFormat: ImageCompressFormat.png,
//     // cropStyle: cropStyle,
//     // aspectRatioPresets: [cropAspectRatio],
//     uiSettings: [
//       AndroidUiSettings(
//         toolbarTitle: AppStrings.cropImageDesc.tr(),
//         showCropGrid: false,
//         toolbarColor: AppColors.daisyBush800,
//         toolbarWidgetColor: Colors.white,
//         hideBottomControls: true,
//         initAspectRatio: CropAspectRatioPreset.square,
//         lockAspectRatio: crop,
//         cropStyle: cropStyle,
//       ),
//     ],
//   );

//   if (croppedFile == null) return null;

//   final size = await croppedFile.readAsBytes();

//   log("----------------\nImage size: ${size.lengthInBytes / 1024}");
//   return File(croppedFile.path);
// }

String kGetFileExtension(String? fileName) {
  if (fileName == null || fileName.isEmpty) {
    return '';
  }
  return fileName.split('.').last;
}

// Widget kGetFileIcon(String ext) {
//   switch (ext) {
//     // case 'pdf':
//     //   return SvgPicture.asset(
//     //     AppImages.pdf,
//     //     width: 32.sp,
//     //     height: 32.sp,
//     //   );
//     // case 'doc' || 'docx':
//     //   return SvgPicture.asset(
//     //     AppImages.word,
//     //     width: 32.sp,
//     //     height: 32.sp,
//     //   );
//     // case 'xls' || 'xlsx':
//     //   return SvgPicture.asset(
//     //     AppImages.excel,
//     //     width: 32.sp,
//     //     height: 32.sp,
//     //   );

//     // default:
//     //   return SvgPicture.asset(
//     //     AppImages.image,
//     //     width: 32.sp,
//     //     height: 32.sp,
//     //   );

//   }
// }

Future<String> get kGetBuildNumber async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Map<String, String> kParseOneLineData(String data) {
  Map<String, String> dataMap = {};

  // Split the string into lines
  List<String> lines = data.split('\n');

  for (String line in lines) {
    // Use regular expression to match the key-value pairs
    RegExp regExp = RegExp(r"(\w+)\s*:\s*\((.*?)\)");
    Match? match = regExp.firstMatch(line);

    if (match != null) {
      String key = match.group(1)!.trim();
      String value = match.group(2)!.trim();

      // Handle duplicate keys (e.g., From Time)
      if (dataMap.containsKey(key)) {
        // Append to existing value if the key already exists (e.g., From Time)
        dataMap[key] = '${dataMap[key]}, $value';
      } else {
        dataMap[key] = value;
      }
    }
  }

  return dataMap;
}
