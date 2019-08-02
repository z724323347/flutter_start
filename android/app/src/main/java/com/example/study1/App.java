package com.example.study1;

import android.app.Activity;
import android.app.Application;

import androidx.annotation.CallSuper;

import com.umeng.commonsdk.UMConfigure;

import io.flutter.view.FlutterMain;

public class App extends Application {
    private Activity mCurrentActivity = null;

    public App() {
    }

    @CallSuper
    public void onCreate() {
        super.onCreate();
        FlutterMain.startInitialization(this);
        UMConfigure.init(this, UMConfigure.DEVICE_TYPE_PHONE, "5d383b343fc1957401000796");
        UMConfigure.setLogEnabled(true);
//        UMConfigure.setEncryptEnabled(true);
    }

    public Activity getCurrentActivity() {
        return this.mCurrentActivity;
    }

    public void setCurrentActivity(Activity mCurrentActivity) {
        this.mCurrentActivity = mCurrentActivity;
    }
}
// // flutter Application
//public class FlutterApplication extends Application {
//    private Activity mCurrentActivity = null;
//
//    public FlutterApplication() {
//    }
//
//    @CallSuper
//    public void onCreate() {
//        super.onCreate();
//        FlutterMain.startInitialization(this);
//    }
//
//    public Activity getCurrentActivity() {
//        return this.mCurrentActivity;
//    }
//
//    public void setCurrentActivity(Activity mCurrentActivity) {
//        this.mCurrentActivity = mCurrentActivity;
//    }
//}

