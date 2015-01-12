//
//  SBSettingItem.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItem.h"
#import "SBSettingItemGroup.h"
#import "SBSettingItemTextField.h"
#import "SBSettingItemToggleSwitch.h"
#import "SBSettingItemSlider.h"
#import "SBSettingItemMultiValue.h"
#import "SBSettingItemTitle.h"
#import "SBSettingItemRadioGroup.h"
#import "SBSettingItemRadioGroupElement.h"

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
    } else if ([type isEqualToString:@"PSMultiValueSpecifier"]) {
        return [[SBSettingItemMultiValue alloc]initWithDictionary:preferenceDictionary];
    } else if ([type isEqualToString:@"PSTitleValueSpecifier"]) {
        return [[SBSettingItemTitle alloc]initWithDictionary:preferenceDictionary];
    } else if ([type isEqualToString:@"PSRadioGroupSpecifier"]) {
        return [[SBSettingItemRadioGroup alloc]initWithDictionary:preferenceDictionary];
    } else if ([type isEqualToString:@"PSRadioGroupElementSpecifier"]) {
        return [[SBSettingItemRadioGroupElement alloc]initWithDictionary:preferenceDictionary];
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

- (BOOL) isMultiValueItem {
    return [self.type isEqualToString:@"PSMultiValueSpecifier"];
}

- (BOOL) isTitleItem {
    return [self.type isEqualToString:@"PSTitleValueSpecifier"];
}

- (BOOL) isRadioGroupItem {
    return [self.type isEqualToString:@"PSRadioGroupSpecifier"];
}

- (BOOL) isRadioGroupElementItem {
    return [self.type isEqualToString:@"PSRadioGroupElementSpecifier"];
}

@end
