package cc.seedland.inf.samples;

import android.app.Application;
import android.content.Context;

import cc.seedland.inf.passport.PassportHome;

/**
 * Created by xuchunlei on 2017/11/22.
 */

public class SampleApplication extends Application {

    public static Context CONTEXT;

    @Override
    public void onCreate() {
        super.onCreate();
        PassportHome.getInstance().init(this, getString(R.string.passport_channel), getString(R.string.passport_key));
        PassportHome.enableTokenUpdate(true);
        CONTEXT = this;
    }
}
