# AJDevKit
个人集成开发框架

---

#### pod 依赖包

功能 | 名称 | 版本
------------ | ------------- | ------------
JSON 解析库 					| MJExtension  		| `3.0.7`
基于AFNetworking的文件下载库 	| AFDownloadRequestOperation  | `2.0.1`
网络请求库 					| AFNetworking 		| `2.6.3`
来自YYKit的分类 				| YYCategories  	| `0.9.3`
网络图片处理库  				| SDWebImage 		| `3.7.3`
键盘事件处理库    			| IQKeyboardManager | `3.3.4`
空内容处理库    				| DZNEmptyDataSet   | `1.7.2`
正则表达式处理库    			| RegexKitLite      | `4.0`
Facebook 动画库    			| pop  				 | `1.0.8`
Autolayout封装库    			| Masonry 			 | `0.6.3`
NSNotification封装库   	    | GLPubSub 			 | `1.0.1`
AOP处理库   				    | MOAspects 		 | `2.1.0`
AppStore评分封装库    		| iRate 		     | `1.11.4`
多图片显示库    				| MWPhotoBrowser 	 | `2.1.1`
系统图片选择库   				| MLSelectPhoto     |  `1.2.1`
上拉下拉刷新库    			| MJRefresh  		 |  `3.0.7`
新版本初始化处理库   			| MTMigration       | `0.0.5`
非关系型数据库    			| Realm             | `0.97.0`
具有正则匹配的UITextField     | TSValidatedTextField | `1.0.0`



---

#### 项目结构

* Controller : 项目中的控制器
* Model : 数据模型
* Network : AFNetworking框架封装
* View : 常用视图控件封装
* Tools : 常用工具类
* Category : 常用分类
* Library : 第三方框架、SDK包等
* Resource : 项目中资源，比如https证书、文件等，对于png格式图片放 Assets.xcassets 


---

#### 关于网络框架

项目中使用的网络框架是基于[YTKNetowrk](https://github.com/yuantiku/YTKNetwork) 和 [MJExtension](https://github.com/CoderMJLee/MJExtension) 封装，将原来 `YTKNetowrk`  中的请求参数和返回JSON解析交给了  `MJExtension`  框架处理。

[YTKNetowrk框架基础教程](BasicGuide.md)

[YTKNetowrk框架高级教程](ProGuide.md)

---

* 所有请求数据bean必须继承自 `RequestBeanBase` 
* 所有返回数据结果Bean必须继承自 `ResponseBeanBase` 
* 所有请求数据Bean命名规则：`RequestBean + 功能名称`。 例如登录请求数据Bean：`RequestBeanLogin`
* 所有返回数据结果Bean命名必须与请求数据Bean命名一致，只是将 `RequestBean` 换成 `ResponseBean`。 例如登录结果数据Bean：`ResponseBeanLogin`


---





