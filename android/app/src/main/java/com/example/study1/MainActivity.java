package com.example.study1;

import android.app.AlertDialog;
import android.content.ContextWrapper;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Toast;

import androidx.core.app.NotificationManagerCompat;

import com.azhon.appupdate.base.BaseHttpDownloadManager;
import com.azhon.appupdate.listener.OnDownloadListener;
import com.azhon.appupdate.manager.DownloadManager;
import com.azhon.appupdate.service.DownloadService;
import com.example.study1.util.UpdateAppHttpUtil;
import com.flutter.app.android.R;
import com.google.android.material.button.MaterialButton;
import com.vector.update_app.SilenceUpdateCallback;
import com.vector.update_app.UpdateAppBean;
import com.vector.update_app.UpdateAppManager;
import com.vector.update_app.utils.AppUpdateUtils;

import java.io.File;
import java.lang.ref.WeakReference;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {

  public static WeakReference<MainActivity> sRef;

  private static final String CHANNEL = "native.plugin";
  // 获取电池电量通道
  private static final String CHANNEL_BATTERY = "native.flutter.io/battery";

  private static final String CHANNEL_JPUSH = "jpush.native/android";

  private static final String CHANNEL_UP = "native.flutter.io/up";

  private DownloadManager manager;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    //自定义插件 1  //更新插件
     new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler(new MethodCallHandler() {
       @Override
       public void onMethodCall(MethodCall methodCall, Result result) {
          if(methodCall.method.equals("interaction")){
              //跳转native 页面
//              Intent intent = new Intent(MainActivity.this,KotilnDemo.class);
//              startActivity(intent);
//              result.success("success");
          } else {
              result.notImplemented();
          }
       }
     });

      //自定义插件 2
      new MethodChannel(getFlutterView(),CHANNEL_BATTERY).setMethodCallHandler(new MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall methodCall, Result result) {
              if (methodCall.method.equals("getBatteryLevel")){

//                  int batteryLevel = getBatteryLevel();
//                  if(batteryLevel != -1){
//                      //回调native方法的结果
//                      result.success(batteryLevel);
//                  }else{
//                      result.error("UNAVAILABLE", "Battery level not available.", null);
//                  }
                  String status = "unknown";
                  boolean isOpened = false;
                  try{
                      isOpened = NotificationManagerCompat.from(MainActivity.this).areNotificationsEnabled();
                      if(isOpened){
                          status = "open";
                          goToSetting();
                      } else {
                          status = "close";
                      }
                  }catch (Exception e){
                      e.printStackTrace();
                      isOpened = false;
                  }
                  result.success(status);
              } else {
                  result.notImplemented();
              }
          }
      });

      //自定义插件 3
      new MethodChannel(getFlutterView(),CHANNEL_JPUSH).setMethodCallHandler(new MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall methodCall, Result result) {
              if (methodCall.method.equals("status")){
                  boolean isOpened = false;
                  String status = "unknown";
                  try{
                      isOpened = NotificationManagerCompat.from(MainActivity.this).areNotificationsEnabled();
                      if(isOpened){
                          status = "open";
                          goToSetting();
                      } else {
                          status = "close";
                      }
                  }catch (Exception e){
                      e.printStackTrace();
                      isOpened = false;
                  }
                  result.success(status);
              } else {
                  result.notImplemented();
              }
          }
      });

      //更新插件
      new  MethodChannel(getFlutterView(),CHANNEL_UP).setMethodCallHandler((methodCall, result) -> {
          if (methodCall.method.equals("up")){

              new UpdateAppManager
                      .Builder()
                      //当前Activity
                      .setActivity(this)
                      //更新地址
                      .setUpdateUrl("https://raw.githubusercontent.com/WVector/AppUpdateDemo/master/json/json.txt")
                      //实现httpManager接口的对象
                      .setHttpManager(new UpdateAppHttpUtil())
                      //只有wifi下进行，静默下载(只对静默下载有效)
                      .setOnlyWifi()
                      .build()
                      .checkNewApp(new SilenceUpdateCallback() {
                          @Override
                          protected void showDialog(UpdateAppBean updateApp, UpdateAppManager updateAppManager, File appFile) {
                              showSilenceDiyDialog(updateApp, appFile);
                          }
                      });

//              manager = DownloadManager.getInstance(this);
//              manager.setApkName("appupdate.apk")
//                      .setApkUrl("https://raw.githubusercontent.com/azhon/AppUpdate/master/apk/appupdate.apk")
//                      .setSmallIcon(R.mipmap.ic_launcher)
//                      .setShowNewerToast(true)
////                      .setConfiguration(configuration)
////                .setDownloadPath(Environment.getExternalStorageDirectory() + "/AppUpdate")
//                      .setApkVersionCode(2)
//                      .setApkVersionName("2.1.8")
//                      .setApkSize("20.4")
//                      .setAuthorities(getPackageName())
//                      .setApkDescription("1.支持断点下载\n2.支持Android N\n3.支持Android O\n4.支持自定义下载过程\n5.支持 设备>=Android M 动态权限的申请\n6.支持通知栏进度条展示(或者自定义显示进度)")
//                      .download();

              result.success("ok 进入更新插件了");
          }else {
              result.notImplemented();
          }
      });


    GeneratedPluginRegistrant.registerWith(this);
  }


    /**
     * native 获取电池电量
     * @return
     */
    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
        return batteryLevel;
    }


    private void goToSetting(){

        Toast.makeText(this,".........",Toast.LENGTH_LONG).show();

        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("提示");
        builder.setMessage("是否打开系统设置");
        builder.setPositiveButton("前去设置", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Intent intent = new Intent();
                if (Build.VERSION.SDK_INT >= 26) {
                    // android 8.0引导
                    intent.setAction("android.settings.APP_NOTIFICATION_SETTINGS");
                    intent.putExtra("android.provider.extra.APP_PACKAGE", getPackageName());
                } else if (Build.VERSION.SDK_INT >= 21) {
                    // android 5.0-7.0
                    intent.setAction("android.settings.APP_NOTIFICATION_SETTINGS");
                    intent.putExtra("app_package", getPackageName());
                    intent.putExtra("app_uid", getApplicationInfo().uid);
                } else {
                    // 其他
                    intent.setAction("android.settings.APPLICATION_DETAILS_SETTINGS");
                    intent.setData(Uri.fromParts("package", getPackageName(), null));
                }
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(intent);
            }
        });
        builder.setNegativeButton("关闭", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        builder.create().show();
    }


    /**
     * 静默下载自定义对话框
     *
     * @param updateApp
     * @param appFile
     */
    private void showSilenceDiyDialog(final UpdateAppBean updateApp, final File appFile) {
        String targetSize = updateApp.getTargetSize();
        String updateLog = updateApp.getUpdateLog();

        String msg = "";

        if (!TextUtils.isEmpty(targetSize)) {
            msg = "新版本大小：" + targetSize + "\n\n";
        }

        if (!TextUtils.isEmpty(updateLog)) {
            msg += updateLog;
        }

        new AlertDialog.Builder(this)
                .setTitle(String.format("是否升级到%s版本？", updateApp.getNewVersion()))
                .setMessage(msg)
                .setPositiveButton("安装", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        AppUpdateUtils.installApp(MainActivity.this, appFile);
                        dialog.dismiss();
                    }
                })
                .setNegativeButton("暂不升级", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                })
                .create()
                .show();
    }
}
