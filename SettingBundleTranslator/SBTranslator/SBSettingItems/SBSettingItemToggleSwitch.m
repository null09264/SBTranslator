//
//  SBSettingToggleSwitchItem.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItemToggleSwitch.h"

@implementation SBSettingItemToggleSwitch

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary {
    self = [super init];
    
    if (self) {
        assert([[preferenceDictionary objectForKey:@"Type"] isEqualToString:@"PSToggleSwitchSpecifier"]);
        self.defaultValue = [preferenceDictionary objectForKey:@"DefaultValue"];
        self.key = [preferenceDictionary objectForKey:@"Key"];
        self.title = [preferenceDictionary objectForKey:@"Title"];
        self.type = @"PSToggleSwitchSpecifier";
    }
    
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"ToggleSwitch: Title: %@; Key: %@; DefaultValue: %@;", self.title, self.key, self.defaultValue ? @"YES" : @"NO"];
}

@end
