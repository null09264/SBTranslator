//
//  SBSettingItem.h
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SBSettingItemProtocal <NSObject>

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary;

@end

@interface SBSettingItem : NSObject <SBSettingItemProtocal>

@property NSString *type;

- (BOOL) isGroupItem;
- (BOOL) isTextFieldItem;
- (BOOL) isToggleSwitchItem;
- (BOOL) isSliderItem;
- (BOOL) isMultiValueItem;
- (BOOL) isTitleItem;

@end
