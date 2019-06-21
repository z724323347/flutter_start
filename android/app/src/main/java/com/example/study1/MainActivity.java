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
import android.widget.Toast;

import androidx.core.app.NotificationManagerCompat;

import com.google.android.material.button.MaterialButton;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "native.plugin";
  // 获取电池电量通道
  private static final String CHANNEL_BATTERY = "native.flutter.io/battery";

  private static final String CHANNEL_JPUSH = "jpush.native/android";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    //自定义插件 1
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

}
