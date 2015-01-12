//
//  SBSettingItemTitle.m
//  SettingBundleTranslator
//
//  Created by Justus on 12/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBSettingItemTitle.h"

@implementation SBSettingItemTitle

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary {
    self = [super init];
    
    if (self) {
        assert([[preferenceDictionary objectForKey:@"Type"] isEqualToString:@"PSTitleValueSpecifier"]);
        self.defaultValue = [preferenceDictionary objectForKey:@"DefaultValue"];
        self.key = [preferenceDictionary objectForKey:@"Key"];
        self.title = [preferenceDictionary objectForKey:@"Title"];
        self.titles = [preferenceDictionary objectForKey:@"Titles"];
        self.values = [preferenceDictionary objectForKey:@"Values"];
        self.type = @"PSTitleValueSpecifier";
    }
    
    return self;
}


@end
