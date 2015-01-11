//
//  SBSettingItemSlider.m
//  SettingBundleTranslator
//
//  Created by Justus on 11/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBSettingItemSlider.h"

@implementation SBSettingItemSlider

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary {
    self = [super init];
    
    if (self) {
        assert([[preferenceDictionary objectForKey:@"Type"] isEqualToString:@"PSSliderSpecifier"]);
        self.defaultValue = [[preferenceDictionary objectForKey:@"DefaultValue"] doubleValue];
        self.key = [preferenceDictionary objectForKey:@"Key"];
        self.maximumValue = [[preferenceDictionary objectForKey:@"MaximumValue"] doubleValue];
        self.maximumValueImage = [preferenceDictionary objectForKey:@"MaximumValueImage"];
        self.minimumValue = [[preferenceDictionary objectForKey:@"MinimumValue"] doubleValue];
        self.minimumValueImage = [preferenceDictionary objectForKey:@"MinimumValueImage"];
        self.type = @"PSSliderSpecifier";
    }
    
    return self;
}

@end
