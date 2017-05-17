# iOS-MKAdd-On
## 容器视图侧滑框架v0.1 Beta
### 介绍
* 自定义容器视图实现
* 客制化右侧子控制器视图滑动终止位置
* 客制化右侧子控制器视图滑动动画的最长时间
* 客制化右侧子控制器视图滑动灵敏度
### 使用方式
1. 将`MKSlideFrameworkRootControllerViewController.h`和`MKSlideFrameworkRootControllerViewController.m`文件置入项目中
2. 在需要使用的文件中引入头文件, 例如:
```
#import "MKSlideFrameworkRootControllerViewController.h"
```
3. 设定右侧子控制器视图滑动终止位置, 在引入头文件的语句之上加入宏定义, 例如设定右侧子控制器视图滑动终止位置为距离左侧215个点的距离:
```
#define RIGHTVIEW_POSITION_X 215
```
4. 设定右侧子控制器视图滑动动画的最长时间, 在引入头文件的语句之上加入宏定义, 例如设定右侧子控制器视图滑动动画的最长时间为0.5秒:
```
#define ANIMATE_DURATION 0.5
```
5. 设定右侧子控制器视图滑动灵敏度, 在引入头文件的语句之上加入宏定义, 此处建议值为300, 设定范围最好在200~1600之间, 例如设定右侧子控制器视图滑动灵敏度为300:
```
#define THRESHOLD 300
```
