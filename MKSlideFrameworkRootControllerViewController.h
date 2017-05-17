//
//  MKSlideFrameworkRootControllerViewController.h
//  meituan-30
//
//  Created by MIST on 16/05/2017.
//  Copyright © 2017 MIST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKSlideFrameworkRootControllerViewController : UIViewController

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *rightViewController;

+ (instancetype)slideFrameworkRootControllerViewControllerWithLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController;
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController andRightViewController:(UIViewController *)rightViewController;

@end
