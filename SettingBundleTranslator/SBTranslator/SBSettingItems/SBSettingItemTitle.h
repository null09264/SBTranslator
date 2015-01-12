//
//  SBSettingItemTitle.h
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 12/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItem.h"

@interface SBSettingItemTitle : SBSettingItem

@property NSString *title;
@property NSString *key;
@property NSString *defaultValue;
@property NSArray *values;
@property NSArray *titles;

@end
