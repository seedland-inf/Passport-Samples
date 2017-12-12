
## 目录

* [使用](#USE)
    * [添加代码仓库](#REPO)
    * [添加依赖](#DEPENENCY)
    * [添加开发者支持](#SUPPORT)
* [文档](#DOC)
    * [1.初始化](#INITIAL)
    * [2.调用](#CALL)
        * [注册](#REGISTER)
        * [密码登录](#LOGIN-PASSWORD)
        * [验证码登录](#LOGIN-CAPTCHA)
        * [重置（忘记）密码](#PASSWORD-RESET)
        * [修改密码](#PASSWORD-MODIFY)
        * [获取Token](#TOKEN)
        * [登出](#LOGOUT)

## <a name="USE"></a>使用
[![](https://img.shields.io/badge/API-16%2B-brightgreen.svg?style=flat)](https://android-arsenal.com/api?level=16) [![](https://img.shields.io/badge/platform-android-brightgreen.svg)](https://developer.android.com/index.html) ![](https://img.shields.io/badge/version-1.0.0-brightgreen.svg)

### <a name=“REPO”></a>1.添加代码仓库

**项目根目录的build.gradle文件中，添加**
```gradle
allprojects {
    repositories {
        google()
        jcenter()
        maven {url "http://developer.seedland.cc/nexus/repository/maven-public/"}
    }
}
```
### <a name="DEPENENCY"></a>2.添加依赖

**在App的build.gradle文件的dependencies块中，添加**

* 3.0.0及以后版本
```gradle
dependencies {
    implementation('cc.seedland.inf:passport:1.0.0@aar'){
            transitive=true
    }
}
```

* 2.3.3及以前版本
```gradle
dependencies {
    compile('cc.seedland.inf:passport:1.0.0@aar'){
            transitive=true
    }
}
```

### <a name="SUPPORT"></a>3.添加开发者支持

**获取开发者channel和开发者key**

（wiki）

**将开发者channel及key到工程**

在App目录下的gradle.build文件中，选用以下两种方式任意一种添加：

* 在defaultConfig统一添加
```gradle
defaultConfig {
        // passport_channel和passport-key为资源名，可任意命名，但必须满足资源命名规则
        resValue "string", "passport_channel", "your channel"      // PassportSDK的渠道号
        resValue "string", "passport-key", "your key"              // PassportSDK的开发者Key
}
```

## <a name="DOC"></a>文档

### <a name="INITIAL"></a>1. 初始化

为工程创建自定义Application，并执行SDK的初始化方法

```java
public class SampleApplication extends Application {

    ...

    @Override
    public void onCreate() {
        super.onCreate();
        // 初始化，传入开发者channel和开发者key
        PassportHome.getInstance().init(this, getString(R.string.passport_channel), getString(R.string.passport_key));
        
        ...
    }
}
```

在AndroidManifest.xml文件中，使用自定义的Application，如
```xml
<application
        android:name=".SampleApplication"
        ...
</application>
```
### <a name="CALL"></a>2. 调用

SDK统一使用startActivityForResult的方式调用支持Passport APIs的界面，包括以下步骤：

1. 定义RequestCode
2. 启动活动
3. 在onActivityResult回调中接收和处理返回结果

    * 解析结果：通过data.getBundleExtra("result")获得，以键值对形式提供，保存在Bundle对象中
    * 原始结果：通过data.getStringExtra("raw_result")获得，为API返回的json数据，供用户自行解析

以密码登录界面为例

1. 定义请求码
```java
...
private static final int REQUEST_CODE_LOGIN = 1; // 可以是任意整型数字
...
```

2. 启动活动

```java
...
// this为Activity的实例
PassportHome.getInstance().startLoginByPassword(this, REQUEST_CODE_LOGIN);
...
```

3. 接收和处理结果

```java
...

执行操作返回码为*RESULT_OK*，未执行操作返回码为*RESULT_CANCELED*

@Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(resultCode == RESULT_OK) {
            switch (requestCode) {
                case REQUEST_CODE_LOGIN:
                    Bundle args = data.getBundleExtra("result");
                    String uid = args.getString("uid");
                    String nickname = args.getString("nickname");
                    String mobile = args.getString("mobile");
                    String rawResult = data.getStringExtra("raw_result");
                    ...
                    break;
               ...
            }
        }else if(resultCode == RESULT_CANCELED) {
            switch(requestCode) {
                case REQUEST_CODE_LOGIN:
                    ....
                    break;
            }
            ...
        }
        ...
    }
...
```

**<a name="REGISTER"></a>注册**

* 调用方法：PassportHome.getInstance().startRegister(this, REQUEST_CODE_REGISTER);
* 返回内容
    * 解析数据  
        * uid
        * mobile
        * nickname
        * ip          
    * 原始数据   
```json
{
        "uid":99,
        "mobile":"13800138000",
        "nickname":"User_13800138000",
        "register_ip":"192.168.232.2"
    }
```

**<a name="LOGIN-PASSWORD"></a>密码登录**

* 调用方法：PassportHome.getInstance().startLoginByPassword(this, REQUEST_CODE_LOGIN);
* 返回内容
    * 解析数据
        * uid
        * mobile
        * nickname
        * ip
        * token
    * 原始数据  
```json
         {
                "uid":99,
                "mobile":"13800138000",
                "nickname":"User_13800138000",
                "register_ip":"192.168.232.2",
                "sso_tk":"UnmdO3T2CbiOjp/GWTnTdBh+cNh816nDlFegYdZ02yOoEAfe12XFmSbklBlUyC7AS0F5CfDVuzPKNn/pV4uUBiUso/hhF3PqKSj6XmACwk/yr+71Aff2ha+nax9+xtYoH/F+c8urDWLTZcqJCuzkTmpr0e5G/eXQNCmxC+S+kl0="
         }
```

**<a name="LOGIN-CAPTCHA"></a>验证码登录**

* 调用方法：PassportHome.getInstance().startLoginByCaptcha(this, REQUEST_CODE_LOGIN_CAPTCHA);
* 返回内容
    * 解析数据 
        * uid
        * mobile
        * nickname
        * ip
        * token       
    * 原始数据 
```json
{
        "uid":99,
        "mobile":"13800138000",
        "nickname":"User_13800138000",
        "register_ip":"192.168.232.2",
        "sso_tk":"TNELR9yBoGDZ50jf8y8CSyQWbwloEE8oGLGvT9uIib//iyhbFO3oChPLPwnEXTwQmI3larhKmQbH0sZGh82tQTxz86eGyhRr9DdC/7m9fl0ODviTdDOvKjelYZrlTwJRwhSjQwawPL/pkfjPYIeHCeq1OHbaL9piK8+gB/6140I="
}
```

**<a name="PASSWORD-RESET"></a>重置（忘记）密码**

* 调用方法：PassportHome.getInstance().startResetPassword(this, REQUEST_CODE_RESET_PASSWORD);
* 返回内容
    * 解析数据
        * uid
        * mobile
        * nickname
        * ip    
    * 原始数据 
```json
{
    "uid":99,
    "mobile":"13800138000",
    "nickname":"User_3800138000",
    "register_ip":"192.168.232.2"
}
```
**<a name="PASSWORD-MODIFY"></a>修改密码**

*修改密码后，用户未执行登录操作，请您在onActivityResult回调中利用RESULT_CANCELED自行处理*

* 调用方法：PassportHome.getInstance().startModifyPassword(this, REQUEST_CODE_PASSWORD);
* 返回内容-修改后登录
    * 解析数据
        * uid
        * mobile
        * nickname
        * ip
        * token
    * 原始数据  
```json
         {
                "uid":99,
                "mobile":"13800138000",
                "nickname":"User_13800138000",
                "register_ip":"192.168.232.2",
                "sso_tk":"UnmdO3T2CbiOjp/GWTnTdBh+cNh816nDlFegYdZ02yOoEAfe12XFmSbklBlUyC7AS0F5CfDVuzPKNn/pV4uUBiUso/hhF3PqKSj6XmACwk/yr+71Aff2ha+nax9+xtYoH/F+c8urDWLTZcqJCuzkTmpr0e5G/eXQNCmxC+S+kl0="
         }
```
* 返回内容-修改后未登录
    * 解析数据
        * uid
        * mobile
        * nickname
        * ip      
    * 原始数据 
```json
{
        "uid":99,
        "mobile":"13800138000",
        "nickname":"User_1380038000",
        "register_ip":"192.168.232.2"
}
```

**<a name="TOKEN"></a>获取Token**

_调用方请使用SDK提供的获取Token的方式_

调用方法：
```java
...
String token = PassportHome.getInstance().getToken();
...
```

**<a name="LOGOUT"></a>登出**

_当APP退出登录状态时调用_

调用方法:
```java
...
PassportHome.getInstance().logout();
...
```
