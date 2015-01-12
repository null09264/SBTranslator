//
//  SBSettingItemRadioGroupElement.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 12/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItemRadioGroupElement.h"

@implementation SBSettingItemRadioGroupElement

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary {
    self = [super init];
    if (self) {
        assert([[preferenceDictionary objectForKey:@"Type"] isEqualToString:@"PSRadioGroupElementSpecifier"]);
        self.title = [preferenceDictionary objectForKey:@"Title"];
        self.value = [preferenceDictionary objectForKey:@"Value"];
        self.isSelected = NO;
        self.type = @"PSRadioGroupElementSpecifier";
    }
    
    return self;
}

@end
