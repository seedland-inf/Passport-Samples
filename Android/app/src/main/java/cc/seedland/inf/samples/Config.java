package cc.seedland.inf.samples;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by xuchunlei on 2017/11/23.
 */

public class Config {

    private static final String CACHE_NAME = "demo_cache";
//    private static final String KEY_TOKEN = "token";
    private static final String KEY_NICK_NAME = "nick_name";
    private static final String KEY_UID = "uid";
    private static final String KEY_MOBILE = "mobile";

    private Config() {

    }

//    public static void saveToken(String token) {
//        save(KEY_TOKEN, token);
//    }
//
//    public static String getToken() {
//        return obtain(KEY_TOKEN, "");
//    }

    public static void saveUid(String uid) {
        save(KEY_UID, uid);
    }

    public static String getUid() {
        return obtain(KEY_UID, "");
    }

    public static void saveNickName(String nickName) {
        save(KEY_NICK_NAME, nickName);
    }

    public static String getNickName() {
        return obtain(KEY_NICK_NAME, "");
    }

    public static void saveMobile(String mobile) {
        save(KEY_MOBILE, mobile);
    }

    public static String getMobile() {
        return obtain(KEY_MOBILE, "");
    }

    private static void save(String key, String value) {
        if(SampleApplication.CONTEXT != null) {
            SharedPreferences pref = SampleApplication.CONTEXT.getSharedPreferences(CACHE_NAME, Context.MODE_PRIVATE);
            SharedPreferences.Editor editor = pref.edit();
            editor.putString(key, value);
            editor.commit();
        }else {
            throw new NullPointerException("initialize CONTEXT before using it");
        }
    }

    private static String obtain(String key, String def) {
        if(SampleApplication.CONTEXT != null) {
            SharedPreferences pref = SampleApplication.CONTEXT.getSharedPreferences(CACHE_NAME, Context.MODE_PRIVATE);
            return pref.getString(key, def);
        }
        throw new NullPointerException("initialize CONTEXT before using it");
    }




}
