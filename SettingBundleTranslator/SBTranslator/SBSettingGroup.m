//
//  SBSettingGroup.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
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
