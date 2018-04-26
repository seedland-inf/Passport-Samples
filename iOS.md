
# 目录

* [使用](#USE)
    * [SDK与Demo下载](#DOWNLOAD)
    * [添加Passport对应的framework](#REPO)
    * [修改工程配置](#SETUP)
    * [注意事项](#NOTICE)
    * [添加开发者支持](#SUPPORT)
* [DEMO](#DEMO)
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
![](https://img.shields.io/badge/version-1.0.0-brightgreen.svg)

### <a name=“DOWNLOAD”></a>1.SDK与Demo下载
（1）打开 https://github.com/seedland-inf/Passport-Samples

（2）选择 iOS.md。此文件为Passport SDK文档。

（3）选择 iOS版本。路径/iOS/PassportDemo/

**说明：**
在PassportDemo中有Framework和PassportDemo两个文件夹。

Framework：为Passport SDK。可直接将该部分内容加入工程。

PassportDemo：为Passport 的使用Demo。举例列举了Passport的使用方法。



### <a name=“REPO”></a>2.添加Passport对应的framework
![](https://raw.githubusercontent.com/seedland-passport/PassportDemo/master/Passport.jpg)

**如图所示，将SDPassportKit.bundle和SDPassportKit.framework导入工程。**

### <a name="SETUP"></a>3.修改工程配置

**在工程project文件中配置如下内容**

方法（1）：依次打开：Targets-->Build Settings-->搜索‘Linking’-->Linking-->Other Linker Flags，将Other Linker Flags内容设置为-ObjC或-all_load，如果无效请多试几次。

方法（2）：依次打开：Targets-->Build Settings-->搜索‘Search Paths’-->Search Paths-->Library Search Paths，将Framework文件路径拖入，保存。

方法（3）：如上述两种方法均无效，请使用本方法。打开解压后的SDK文件夹，复制SDPassportKit.bundle和SDPassportKit.framework到项目根目录，即.xcodeproj所在文件夹。运行即可。

**如果出现问题：错误信息为clang: error: linker command failed with exit code 1 (use -v to see invocation)
可以检查工程中配置是否正确。**

### <a name="NOTICE"></a>4.注意事项
**请注意：SDPassportKit.framework 最低适配系统版本为iOS 8。否则会报错。**

### <a name="SUPPORT"></a>5.添加开发者支持

**获取开发者channel和开发者key**

（wiki）

**将开发者channel及key到工程**

在App目录下的自定义配置文件中，或者AppDelegate.m中声明选用的chanel和key。


## <a name="DEMO"></a>DEMO
工程PassportDemo 为passport sdk使用的demo。可以参考工程中的使用方法和工程配置。

## <a name="DOC"></a>文档

### <a name="INITIAL"></a>1. 初始化

为工程创建自定义Application，并执行SDK的初始化方法

```objective-C

#import "SDKitManager.h"


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ...
    
    [[SDKitManager shareKitManager] initSdkWithChannel:@"test" andKey:@"hay8qwz"];
    
    ...
    
    return YES;
}
```

在AppDelegate.m文件中，如果出现编译提示错误，请将SDKitManager.h文件导入。

### <a name="CALL"></a>2. 刷新Token。

在AppDelegate.m文件中，需要在applicationWillEnterForeground函数中加入刷新Token操作。方法如下：

```objective-C

- (void)applicationWillEnterForeground:(UIApplication *)application {
	...
	 
    [[SDKitManager shareKitManager] updateToken];
    
    ...
}
```

### <a name="CALL"></a>3. 调用

SDK统一使用SDKitManager类下的方法，调用支持Passport 库的界面，包括以下步骤：

1. 在需要调用Passport界面的代码中，加入调用语句。可直接启动界面，并处理返回结果。

**以密码登录界面为例**

1. 启动实例并在block中接受和返回结果

```objective-C

- (void)onLoginButton:(UIButton *)sender
{
    ...
    
    [[SDKitManager shareKitManager] openLoginViewAndAllowClose:YES loginComplete:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
    }];
    
    ...
}
    
```

2.结果处理

如上例，可以看出返回的结果在block中传递。
其中，dict为字典类型。返回需要处理的字段。可根据需要解析使用。


调用passport后的结果是

**<a name="REGISTER"></a>注册**

* 调用方法：

```objective-C

...
[[SDKitManager shareKitManager] openRegisterViewAndCompletion:^(NSDictionary *dict){}];
...

```

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

* 调用方法：

``` objective-C

...
[[SDKitManager shareKitManager] openLoginViewAndAllowClose:YES loginComplete:^(NSDictionary *dict) {}];
...
```
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

* 调用方法：

```objective-C
...
[[SDKitManager shareKitManager] openVerifyCodeLoginViewAndAllowClose:YES loginComplete:^(NSDictionary *dict) {}];
...

```

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

* 调用方法：

```objective-C
...
[[SDKitManager shareKitManager] openForgotPasswordViewAndCompletion:^(NSDictionary *dict) {}];
...
```

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

* 调用方法：

```objective-C
...
[[SDKitManager shareKitManager] openModifyPasswordViewAndCompletion:^(NSDictionary *dict) {}];
...
```
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

```objective-C
...
NSString *token = [[SDKitManager shareKitManager] getToken];
...
```

**<a name="LOGOUT"></a>登出**

_当APP退出登录状态时调用_

调用方法:

```objective-C
...
[[SDKitManager shareKitManager] logoutAccount];
...
```
