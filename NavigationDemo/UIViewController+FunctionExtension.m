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
//
//- (void)finalize {
//    [super finalize];
//}
//
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

    viewController.navigationController.navigationBar.barTintColor = viewController.currentNavigationBarBackgroundColor;
    viewController.navigationController.navigationBar.tintColor    = viewController.currentNavigationItemForegroundColor;
    [viewController.navigationController.navigationBar setTitleTextAttributes:viewController.currentNavigationBarTextAttributes];
}

static const char * __UIViewControllerCurrentNavigationBarBackgroundColor = "__UIViewControllerCurrentNavigationBarBackgroundColor";

- (void)setCurrentNavigationBarBackgroundColor:(UIColor *)currentNavigationBarBackgroundColor {
    if (self.navigationController.delegate == nil) {
        self.navigationController.delegate = self;
    }
    objc_setAssociatedObject(self, __UIViewControllerCurrentNavigationBarBackgroundColor, currentNavigationBarBackgroundColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)currentNavigationBarBackgroundColor {
    return objc_getAssociatedObject(self, __UIViewControllerCurrentNavigationBarBackgroundColor);
}

static const char * __UIViewControllerCurrentNavigationItemForegroundColor = "__UIViewControllerCurrentNavigationItemForegroundColor";

- (void)setCurrentNavigationItemForegroundColor:(UIColor *)currentNavigationItemForegroundColor {
    objc_setAssociatedObject(self, __UIViewControllerCurrentNavigationItemForegroundColor, currentNavigationItemForegroundColor, OBJC_ASSOCIATION_RETAIN);
}

- (UIColor *)currentNavigationItemForegroundColor {
    return objc_getAssociatedObject(self, __UIViewControllerCurrentNavigationItemForegroundColor);
}

static const char * __UIViewControllerCurrentNavigationBarTextAttributes = "__UIViewControllerCurrentNavigationBarTextAttributes";

- (void)setCurrentNavigationBarTextAttributes:(NSDictionary *)currentNavigationBarTextAttributes {
    objc_setAssociatedObject(self, __UIViewControllerCurrentNavigationBarTextAttributes, currentNavigationBarTextAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)currentNavigationBarTextAttributes {
    return objc_getAssociatedObject(self, __UIViewControllerCurrentNavigationBarTextAttributes);
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self);
}

@end
