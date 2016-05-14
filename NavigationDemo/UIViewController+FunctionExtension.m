//
//  UIViewController+FunctionExtension.m
//  PersistentStorageUsage
//
//  Created by 李阳 on 7/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import "UIViewController+FunctionExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (FunctionExtension)

/// 不同实例生产会多次掉用 不建议在此方法中
//+ (void)initialize {
//    [super initialize];
//}

//- (void)finalize {
//    [super finalize];
//}

+ (void)load {
    [super load];
//    NSLog(@"%s", __func__);
    Method originMethod = class_getInstanceMethod([UIViewController class], @selector(loadView));
    Method destinationMethod = class_getInstanceMethod([self class], @selector(extensionLoadView));
    method_exchangeImplementations(originMethod, destinationMethod);
}

- (void)extensionLoadView {
    [self extensionLoadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end

@implementation UIViewController (UINavigationBarAttributesControl)

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.navigationController.navigationBar.barTintColor = viewController.currentBarTintColor;
    viewController.navigationController.navigationBar.tintColor    = viewController.currentTintColor;
    [viewController.navigationController.navigationBar setTitleTextAttributes:viewController.currentBarTextAttributes];
}

static const char * __UIViewControllerCurrentBarTintColor = "__UIViewControllerCurrentBarTintColor";
- (void)setCurrentBarTintColor:(UIColor *)currentBarTintColor {
    if (self.navigationController.delegate == nil) {
        self.navigationController.delegate = self;
    }
    objc_setAssociatedObject(self, __UIViewControllerCurrentBarTintColor, currentBarTintColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)currentBarTintColor {
    return objc_getAssociatedObject(self, __UIViewControllerCurrentBarTintColor);
}

static const char * __UIViewControllerCurrentTintColor = "__UIViewControllerCurrentTintColor";
- (void)setCurrentTintColor:(UIColor *)currentTintColor {
    if (self.navigationController.delegate == nil) {
        self.navigationController.delegate = self;
    }
    objc_setAssociatedObject(self, __UIViewControllerCurrentTintColor, currentTintColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)currentTintColor {
    return objc_getAssociatedObject(self, __UIViewControllerCurrentTintColor);
}


/// 文本属性
static const char * __UIViewControllerCurrentBarTextAttributes = "__UIViewControllerCurrentBarTextAttributes";
- (void)setCurrentBarTextAttributes:(NSDictionary *)currentBarTextAttributes {
    if (self.navigationController.delegate == nil) {
        self.navigationController.delegate = self;
    }
    objc_setAssociatedObject(self, __UIViewControllerCurrentBarTextAttributes, currentBarTextAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)currentBarTextAttributes {
    return objc_getAssociatedObject(self, __UIViewControllerCurrentBarTextAttributes);
}

@end
