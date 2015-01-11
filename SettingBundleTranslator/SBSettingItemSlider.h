//
//  SBSettingItemSlider.h
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
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
