
//  YGPNavController.h

#import <UIKit/UIKit.h>

/**
 *  找了几个滑动控件都没有找到能支持地图和webView的，然后综合别人写的增加了手势。
 *
 *  如果使用此滑动建议关闭IOS7自带的滑动返回，设置方法在下。
 *  self.navigationController.interactivePopGestureRecognizer.enabled=NO;
 *
 *  有不完善的地方或涉及版权问题可加我Q:286677411,相互学习探讨
 */

@interface YGPNavController : UINavigationController<UIGestureRecognizerDelegate>

@property (assign, nonatomic) CGPoint startTouchPoint;      //手指开始点击的位置
@property (strong, nonatomic) UIImageView * prePushViewImg; //上一个pushView的Img
@property (strong, nonatomic) NSMutableArray * pushViewList;//装载截图
@property (assign, nonatomic) BOOL  isMoveing;              //判断是否移动
@property (assign, nonatomic) float moveValue;              //获得移动值



@end
