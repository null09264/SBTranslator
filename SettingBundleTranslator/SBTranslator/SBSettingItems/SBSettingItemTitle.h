//
//  SBSettingItemTitle.h
//  SettingBundleTranslator
//
//  Created by Justus on 12/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBSettingItem.h"

@interface SBSettingItemTitle : SBSettingItem

@property NSString *title;
@property NSString *key;
@property NSString *defaultValue;
@property NSArray *values;
@property NSArray *titles;

@end
