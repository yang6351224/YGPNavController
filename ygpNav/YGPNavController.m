//
//  YGPNavController.m
//  ygpNav
//
//  Created by mac on 14-3-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "YGPNavController.h"

#define KEY_WINDOW    [[UIApplication sharedApplication]keyWindow]
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define OFF_X 0
#define REBOUND_VALUE 150
#define TRIGGER_POINT 30

@interface YGPNavController ()
{
     UIPanGestureRecognizer *  panRecognizer; //平移手势
}
@end

@implementation YGPNavController
@synthesize startTouchPoint;
@synthesize pushViewList;
@synthesize prePushViewImg;
@synthesize isMoveing;
@synthesize moveValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    pushViewList = [[NSMutableArray alloc]initWithCapacity:10];
    
    panRecognizer  = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                            action:@selector(paningGestureReceive:)];
    
    panRecognizer.delegate=self;
    [panRecognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:panRecognizer];
    

}

#pragma mark - 屏幕截图
/**
 *  获取当面屏幕的截图
 *
 *  @return 返回截取当面屏幕的图片
 */
-(UIImage*)screenshot
{
   
     UIGraphicsBeginImageContextWithOptions(self.view.bounds.size,YES, 0.0);
     [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
     UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
     
     return image;

}

/**
 *  将截图的当前屏幕添加到下一个视图控制器图层的最下方
 */
-(void)addViewImg
{
     UIImage * currViewImg = [self.pushViewList lastObject];
     prePushViewImg = [[UIImageView alloc]initWithImage:currViewImg];
     [prePushViewImg setFrame:self.view.bounds];
     [self.view.superview insertSubview:prePushViewImg belowSubview:self.view];
    
}

#pragma mark - 手势

//pan手势
-(void)paningGestureReceive:(UIPanGestureRecognizer*)recognizer
{

     if (self.viewControllers.count<=1) return;
    
     //获取当前激活窗口点击坐标
     CGPoint touchPoint = [recognizer locationInView:KEY_WINDOW];
    
     //判断是否在滑动状态
     if (recognizer.state==UIGestureRecognizerStateBegan)
     {
          startTouchPoint = touchPoint;
         
         if (startTouchPoint.x<TRIGGER_POINT)
             isMoveing=YES;
         else
             isMoveing=NO;

         
     }else if (recognizer.state==UIGestureRecognizerStateEnded)
     {
          isMoveing=NO;
         
          //滑动结束，判断滑动值是否大于回弹值
         if (moveValue>=REBOUND_VALUE) {
             
             [UIView animateWithDuration:0.2 animations:^{
                 
                 [self mainViewMoveX:SCREEN_WIDTH];
                 
             } completion:^(BOOL finished){
                 
                 [self popViewControllerAnimated:NO];
                 
                 //设置push后视图的X:这里的self.View 是返回的视图
                 CGRect frame = self.view.frame;
                 frame.origin.x = OFF_X;
                 self.view.frame = frame;
                 
             }];
         }
         else
         {
             [UIView animateWithDuration:0.1 animations:^{
                 
                 [self mainViewMoveX:OFF_X];
                 
             } completion:^(BOOL finished){
                 
                 isMoveing=NO;
                 
             }];
             
         }
          return;
         
     }else if (recognizer.state==UIGestureRecognizerStateChanged)
     {

         if (isMoveing)
         {
             moveValue = touchPoint.x-startTouchPoint.x;
             [self mainViewMoveX:moveValue];
         }

     }
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/**
 *  改变主视图的位置
 *
 *  @param x 移动值
 */
-(void)mainViewMoveX:(float)x
{
     x = x>SCREEN_WIDTH?SCREEN_HEIGHT:x;
     x = x<OFF_X?OFF_X:x;
     
     CGRect frame = self.view.frame;
     frame.origin.x=x;
     self.view.frame=frame;
     
 /* 当滑动时上一页视图也会慢慢像有移动 */
    
      prePushViewImg.frame = (CGRect){-SCREEN_WIDTH/2+(x/2),0,SCREEN_WIDTH,SCREEN_HEIGHT};

}

#pragma mark - PUSH POP 方法

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.pushViewList addObject:[self screenshot]];  //添加当前view的截图
    [super pushViewController:viewController animated:animated];
    [self addViewImg];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.pushViewList removeLastObject];
    [self addViewImg];
    return [super popViewControllerAnimated:animated];
}

#pragma mark - 内存管理

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
