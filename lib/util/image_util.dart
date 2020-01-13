import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pro/widget/toast/toast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUtil {
  static String imagePath;
  Future<void> saveImageBase64(GlobalKey repaintKey) async {
    // 在这里添加需要的权限
    await PermissionHandler().requestPermissions(<PermissionGroup>[
      PermissionGroup.storage,
    ]);

    if (Platform.isAndroid) {
      PermissionStatus permissionStorage = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permissionStorage != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissionStatus =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        permissionStorage = permissionStatus[PermissionGroup.storage] ??
            PermissionStatus.unknown;
        if (permissionStorage != PermissionStatus.granted) {
          print("❌----------has no Permission");
          return;
        }
      }
    }
    _getWidgetImage(repaintKey).then((v) async {
      var result;
      try {
        // 请前往image_gallery_saver android插件 ImageGallerySaverPlugin中 saveImageToGallery方法
        // Ln67 Col7  把  return uri.toString()  修改为  return Uri.decode(uri.toString())
        result = await ImageGallerySaver.saveImage(v);
        print('result  _$result ');
      } catch (e) {
        result = null;
      }
      imagePath = '${result.toString()}';
      CommonFun.toast(result == null || result == '' ? '图片保存失败' : '成功保存到手机');
    });
  }

  Future<Uint8List> _getWidgetImage(GlobalKey repaintKey) async {
    try {
      RenderRepaintBoundary boundary =
          repaintKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
