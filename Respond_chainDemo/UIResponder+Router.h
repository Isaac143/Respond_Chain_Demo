//
//  UIResponder+Router.h
//  viewCDemo
//
//  Created by Isaac on 17/8/1.
//  Copyright © 2017年 Isaac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

- (NSInvocation *)createInvocationWithSelector:(SEL)selector;

@end
