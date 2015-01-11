//
//  SBSettingItem.m
//  SettingBundleTranslator
//
//  Created by Justus on 11/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBSettingItem.h"
#import "SBSettingItemGroup.h"
#import "SBSettingItemTextField.h"
#import "SBSettingItemToggleSwitch.h"
#import "SBSettingItemSlider.h"


@implementation SBSettingItem

- (instancetype) initWithDictionary:(NSDictionary *)preferenceDictionary {
    NSString *type = [preferenceDictionary objectForKey:@"Type"];
    if ([type isEqualToString:@"PSGroupSpecifier"]) {
        return [[SBSettingItemGroup alloc]initWithDictionary:preferenceDictionary];
    } else if ([type isEqualToString:@"PSTextFieldSpecifier"]) {
        return [[SBSettingItemTextField alloc]initWithDictionary:preferenceDictionary];
    } else if ([type isEqualToString:@"PSToggleSwitchSpecifier"]) {
        return [[SBSettingItemToggleSwitch alloc]initWithDictionary:preferenceDictionary];
    } else if ([type isEqualToString:@"PSSliderSpecifier"]) {
        return [[SBSettingItemSlider alloc]initWithDictionary:preferenceDictionary];
    } else {
        @throw [NSException exceptionWithName:@"UnknownTypeException" reason:@"Unknown Setting Item Type" userInfo:nil];
    }
}

- (BOOL) isGroupItem {
    return [self.type isEqualToString:@"PSGroupSpecifier"];
}

- (BOOL) isTextFieldItem {
    return [self.type isEqualToString:@"PSTextFieldSpecifier"];
}

- (BOOL) isToggleSwitchItem {
    return [self.type isEqualToString:@"PSToggleSwitchSpecifier"];
}

- (BOOL) isSliderItem {
    return [self.type isEqualToString:@"PSSliderSpecifier"];
}

@end
