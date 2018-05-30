//
//  NSObject+deepCopy.m
//  demoForCopy
//
//  Created by miaoy on 2018/5/14.
//  Copyright © 2018年 demoForApi. All rights reserved.
//

#import "NSObject+deepCopy.h"
#import <objc/runtime.h>

@implementation NSObject (deepCopy)

- (instancetype)deepCopy {
    id obj = nil;
    @try {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
    }
    @catch (NSException *exception){
        NSLog(@"%@", exception);
    }
    return obj;
}

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self) {
        unsigned int count = 0;
        Ivar *vars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; ++i) {
            Ivar *var = &vars[i];
            const char *name = ivar_getName(*var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(vars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    
    Ivar *vars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; ++i) {
        Ivar *var = &vars[i];
        const char* name = ivar_getName(*var);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(vars);
}


@end
