package com.example.study1;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
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
                  //获取电池电量
                  int batteryLevel = getBatteryLevel();
                  if(batteryLevel != -1){
                      //回调native方法的结果
                      result.success(batteryLevel);
                  }else{
                      result.error("UNAVAILABLE", "Battery level not available.", null);
                  }
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
}
