//
//  SBSettingGroup.h
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItemGroup.h"

@interface SBSettingGroup : NSObject

@property SBSettingItemGroup *groupItem;
@property NSMutableArray *otherItems;

@end
