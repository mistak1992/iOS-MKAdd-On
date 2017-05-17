//
//  MKSlideFrameworkRootControllerViewController.m
//  meituan-30
//
//  Created by MIST on 16/05/2017.
//  Copyright © 2017 MIST. All rights reserved.
//

#import "MKSlideFrameworkRootControllerViewController.h"

#define RIGHTVIEW_POSITION_X 215
#define ANIMATE_DURATION 0.5
#define THRESHOLD 300
@interface MKSlideFrameworkRootControllerViewController ()
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end

@implementation MKSlideFrameworkRootControllerViewController

+ (instancetype)slideFrameworkRootControllerViewControllerWithLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController{
    return [[self alloc] initWithLeftViewController:leftViewController andRightViewController:rightViewController];
}
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController{
    if (self = [super init]) {
        //告诉UIKit容器控制器正在管理子控制器
        [self addChildViewController:leftViewController];
        [self addChildViewController:rightViewController];
        //将子控制器的视图加入容器视图中
        [self.view addSubview:leftViewController.view];
        [self.view addSubview:rightViewController.view];
        //添加子控制器的视图, 略
        //调用didMoveToParentViewController方法
        [leftViewController didMoveToParentViewController:self];
        [rightViewController didMoveToParentViewController:self];
        //记录两个视图控制器
        self.leftViewController = leftViewController;
        self.rightViewController = rightViewController;
        //
        self.leftViewController.view.frame = self.view.bounds;
        self.rightViewController.view.frame = self.view.bounds;
        //创建滑动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideView:)];
        [self.rightViewController.view addGestureRecognizer:pan];
    }
    return self;
}

#pragma mark - 点击时的事件
- (void)tapClick:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.rightViewController.view.transform = CGAffineTransformTranslate(self.rightViewController.view.transform, - self.rightViewController.view.frame.origin.x, 0);
    } completion:^(BOOL finished) {
        //点击完成后移除
        [self.rightViewController.view removeGestureRecognizer:tap];
        self.tap = nil;
    }];
}

#pragma mark - 滑动时的事件
- (void)slideView:(UIPanGestureRecognizer *)pan{
    //自动创建点击手势
    if (self.tap == nil && self.rightViewController.view.frame.origin.x > 0) {
        //滑动时创建
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self.rightViewController.view addGestureRecognizer:tap];
        self.tap = tap;
    }else if(self.tap != nil && self.rightViewController.view.frame.origin.x == 0){
        //拖动归位时移除
        [self.rightViewController.view removeGestureRecognizer:self.tap];
        self.tap = nil;
    }
    CGPoint p = [pan translationInView:self.view];
    //滑动加速度阀值
    CGPoint v = [pan velocityInView:self.view];
    [pan setTranslation:CGPointZero inView:self.view];
    //不允许左滑
    if (self.rightViewController.view.frame.origin.x + p.x < 0) {
        return;
    }
    //自动归位
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            self.rightViewController.view.transform = CGAffineTransformTranslate(self.rightViewController.view.transform, p.x, 0);
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (v.x > THRESHOLD) {
            slideToRight:
                self.tap = self.tap;
                //自动向右归位
                //防止动画时间过短
                CGFloat duration = (RIGHTVIEW_POSITION_X - self.rightViewController.view.frame.origin.x) / v.x < ANIMATE_DURATION ? (RIGHTVIEW_POSITION_X - self.rightViewController.view.frame.origin.x) / v.x : ANIMATE_DURATION;
                [UIView animateWithDuration:duration animations:^{
                    self.rightViewController.view.transform = CGAffineTransformTranslate(self.rightViewController.view.transform, RIGHTVIEW_POSITION_X - self.rightViewController.view.frame.origin.x, 0);
                }];
            }else if (v.x < - THRESHOLD){
            slideToLeft:
                self.tap = self.tap;
                //自动向左归位
                //防止动画时间过短
                CGFloat duration = (self.rightViewController.view.frame.origin.x) / v.x < ANIMATE_DURATION ? (self.rightViewController.view.frame.origin.x) / v.x : ANIMATE_DURATION;
                [UIView animateWithDuration:duration animations:^{
                    self.rightViewController.view.transform = CGAffineTransformTranslate(self.rightViewController.view.transform, - self.rightViewController.view.frame.origin.x, 0);
                } completion:^(BOOL finished) {
                    //回弹时移除
                    [self.rightViewController.view removeGestureRecognizer:self.tap];
                    self.tap = nil;
                }];
            }else{
                if (self.rightViewController.view.frame.origin.x > RIGHTVIEW_POSITION_X * 0.5) {
                    goto slideToRight;
                }else{
                    goto slideToLeft;
                }
            }
            break;
        default:
            break;
    }
    //防止右滑出界
    if (self.rightViewController.view.frame.origin.x + p.x > RIGHTVIEW_POSITION_X) {
        return;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
