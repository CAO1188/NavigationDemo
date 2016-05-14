//
//  UIViewController+FunctionExtension.h
//  PersistentStorageUsage
//
//  Created by 李阳 on 7/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (FunctionExtension)

@end


@interface UIViewController (UINavigationBarAttributesControl) <UINavigationControllerDelegate>

/// 导航栏背景颜色
@property (nonatomic, strong) UIColor      * currentBarTintColor;
/// 导航Item前景颜色
@property (nonatomic, strong) UIColor      * currentTintColor;
/// 导航title文本属性
@property (nonatomic, strong) NSDictionary * currentBarTextAttributes;

@end

