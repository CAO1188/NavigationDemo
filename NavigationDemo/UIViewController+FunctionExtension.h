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

@property (nonatomic, strong) UIColor      * currentNavigationBarBackgroundColor;
@property (nonatomic, strong) UIColor      * currentNavigationItemForegroundColor;
@property (nonatomic, strong) NSDictionary * currentNavigationBarTextAttributes;

@end