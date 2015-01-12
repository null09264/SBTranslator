//
//  SBSettingItemRadioGroup.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 12/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItemRadioGroup.h"

@implementation SBSettingItemRadioGroup

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary {
    self = [super init];
    
    if (self) {
        assert([[preferenceDictionary objectForKey:@"Type"] isEqualToString:@"PSRadioGroupSpecifier"]);
        self.title = [preferenceDictionary objectForKey:@"Title"];
        self.footerText = [preferenceDictionary objectForKey:@"FooterText"];
        self.key = [preferenceDictionary objectForKey:@"Key"];
        self.titles = [preferenceDictionary objectForKey:@"Titles"];
        self.values = [preferenceDictionary objectForKey:@"Values"];
        self.defaultValue = [preferenceDictionary objectForKey:@"DefaultValue"];
        self.displaySortedByTitle = [preferenceDictionary objectForKey:@"DisplaySortedByTitle"];
        self.type = @"PSRadioGroupSpecifier";
    }
    
    return self;
}

@end
