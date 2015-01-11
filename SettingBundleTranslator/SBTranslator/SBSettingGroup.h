//
//  SBSettingGroup.h
//  SettingBundleTranslator
//
//  Created by Justus on 11/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBSettingItemGroup.h"

@interface SBSettingGroup : NSObject

@property SBSettingItemGroup *groupItem;
@property NSMutableArray *otherItems;

@end
