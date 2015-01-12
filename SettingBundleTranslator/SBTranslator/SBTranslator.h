//
//  SBTranslator.h
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSettingItem.h"
#import "SBSettingItemRadioGroup.h"
#import "SBSettingGroup.h"

@interface SBTranslator : NSObject

@property NSArray *settingGroups;

- (instancetype) init;
- (instancetype) initWithFile: (NSString *) fileName;

- (NSInteger) getNumberOfGroups;
- (NSInteger) getNumberOfRowForGroupAtIndex: (NSInteger) index;
- (SBSettingItem*) getItemAtIndexPath: (NSIndexPath *)indexPath;

+ (void)registerDefaultsFromSettingsBundle;

@end
