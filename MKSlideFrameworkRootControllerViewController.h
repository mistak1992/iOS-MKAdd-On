//
//  MKSlideFrameworkRootControllerViewController.h
//  meituan-30
//
//  Created by MIST on 16/05/2017.
//  Copyright © 2017 MIST. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef RIGHTVIEW_POSITION_X
#define RIGHTVIEW_POSITION_X 215
#endif
#ifndef ANIMATE_DURATION
#define ANIMATE_DURATION 0.5
#endif
#ifndef THRESHOLD
#define THRESHOLD 300
#endif

@interface MKSlideFrameworkRootControllerViewController : UIViewController

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *rightViewController;

+ (instancetype)slideFrameworkRootControllerViewControllerWithLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController;
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController;

@end
