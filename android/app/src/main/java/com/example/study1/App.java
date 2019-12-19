package com.example.study1;

import android.app.Activity;
import android.app.Application;
import android.content.Context;

import androidx.annotation.CallSuper;

import java.util.Map;

import io.flutter.view.FlutterMain;

public class App extends Application {
    private Activity mCurrentActivity = null;

    public App() {
    }

    @CallSuper
    public void onCreate() {
        super.onCreate();
        FlutterMain.startInitialization(this);

        // JPushInterface.setDebugMode(true); // 设置开启日志,发布时请关闭日志
        // JPushInterface.init(this); // 初始化 JPush
        // UMConfigure.setEncryptEnabled(true);

        // flutterboost 初始化
        // FlutterBoostPlugin.init(new IPlatform() {
        // @Override
        // public Application getApplication() {
        // return App.this;
        // }
        //
        // /**
        // * 获取应用入口的Activity,这个Activity在应用交互期间应该是一直在栈底的
        // * @return
        // */
        // @Override
        // public Activity getMainActivity() {
        // if (MainActivity.sRef != null) {
        // return MainActivity.sRef.get();
        // }
        // return null;
        // }
        //
        // @Override
        // public boolean isDebug() {
        // return false;
        // }
        //
        // /**
        // * 如果flutter想打开一个本地页面，将会回调这个方法，页面参数将会拼接在url中
        // *
        // * 例如：sample://nativePage?aaa=bbb
        // *
        // * 参数就是类似 aaa=bbb 这样的键值对
        // *
        // * @param context
        // * @param url
        // * @param requestCode
        // * @return
        // */
        // @Override
        // public boolean startActivity(Context context, String url, int requestCode) {
        // return PageRouter.openPageByUrl(context,url,requestCode);
        // }
        //
        // @Override
        // public Map getSettings() {
        // return null;
        // }
        // });
    }

    public Activity getCurrentActivity() {
        return this.mCurrentActivity;
    }

    public void setCurrentActivity(Activity mCurrentActivity) {
        this.mCurrentActivity = mCurrentActivity;
    }
}
// // flutter Application
// public class FlutterApplication extends Application {
// private Activity mCurrentActivity = null;
//
// public FlutterApplication() {
// }
//
// @CallSuper
// public void onCreate() {
// super.onCreate();
// FlutterMain.startInitialization(this);
// }
//
// public Activity getCurrentActivity() {
// return this.mCurrentActivity;
// }
//
// public void setCurrentActivity(Activity mCurrentActivity) {
// this.mCurrentActivity = mCurrentActivity;
// }
// }
