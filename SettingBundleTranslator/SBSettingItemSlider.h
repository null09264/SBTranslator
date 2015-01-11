//
//  SBSettingItemSlider.h
//  SettingBundleTranslator
//
//  Created by Justus on 11/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBSettingItem.h"

@interface SBSettingItemSlider : SBSettingItem

@property double defaultValue;
@property NSString *key;
@property double maximumValue;
@property NSString *maximumValueImage;
@property double minimumValue;
@property NSString *minimumValueImage;

@end
