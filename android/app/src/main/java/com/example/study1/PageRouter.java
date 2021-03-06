package com.example.study1;

import android.content.Context;
import android.content.Intent;

public class PageRouter {
    public static final String NATIVE_PAGE_URL = "boost://nativePage";
    public static final String FLUTTER_PAGE_URL = "boost://flutterPage";
    public static final String FLUTTER_FRAGMENT_PAGE_URL = "boost://flutterFragmentPage";

    public static boolean openPageByUrl(Context context, String url) {
        return openPageByUrl(context, url, 0);
    }

    public static boolean openPageByUrl(Context context, String url, int requestCode) {
        try {
            if (url.startsWith(FLUTTER_PAGE_URL)) {
//                context.startActivity(new Intent(context, FlutterPageActivity.class));
                return true;
            } else if (url.startsWith(FLUTTER_FRAGMENT_PAGE_URL)) {
//                context.startActivity(new Intent(context, FlutterFragmentPageActivity.class));
                return true;
            } else if (url.startsWith(NATIVE_PAGE_URL)) {
//                context.startActivity(new Intent(context, NativePageActivity.class));
                return true;
            } else {
                return false;
            }
        } catch (Throwable t) {
            return false;
        }
    }
}
