//
//  SBSettingItemMultiValue.h
//  SettingBundleTranslator
//
//  Created by Justus on 12/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBSettingItem.h"

@interface SBSettingItemMultiValue : SBSettingItem

@property NSString *defaultValue;
@property NSString *key;
@property NSString *title;
@property NSArray *titles;
@property NSArray *values;

@end
