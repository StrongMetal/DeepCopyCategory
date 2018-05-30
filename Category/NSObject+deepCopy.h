//
//  NSObject+deepCopy.h
//  demoForCopy
//
//  Created by miaoy on 2018/5/14.
//  Copyright © 2018年 demoForApi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (deepCopy) <NSCoding>

- (instancetype)deepCopy;

@end
