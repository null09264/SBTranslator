//
//  SBSettingGroup.m
//  SettingBundleTranslator
//
//  Created by Justus on 11/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBSettingGroup.h"

@implementation SBSettingGroup

- (instancetype) init {
    self = [super init];
    if (self) {
        self.groupItem = nil;
        self.otherItems = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
