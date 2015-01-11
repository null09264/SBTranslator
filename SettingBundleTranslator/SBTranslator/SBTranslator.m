//
//  SBTranslator.m
//  SettingBundleTranslator
//
//  Created by Justus on 11/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBTranslator.h"

@interface SBTranslator()

@end

@implementation SBTranslator

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self updateSettingItems];
        NSLog(@"%ld groups", [self getNumberOfGroups]);
    }
    
    return self;
}

- (void) updateSettingItems {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Settings.bundle/Root" ofType:@"plist"];
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    self.settingGroups = [self getItemsFromDictionaryArray:[settings objectForKey:@"PreferenceSpecifiers"]];
}

- (NSArray *) getItemsFromDictionaryArray:(NSArray *) array {
    NSMutableArray *groups = [[NSMutableArray alloc]init];
    SBSettingItem *firstItem = [[SBSettingItem alloc] initWithDictionary:[array objectAtIndex:0]];
    SBSettingGroup *currentGroup;
    if (![firstItem isGroupItem]) {
        currentGroup = [[SBSettingGroup alloc] init];
        [groups addObject:currentGroup];
    }
    
    for (NSDictionary *dict in array) {
        SBSettingItem *currentItem = [[SBSettingItem alloc] initWithDictionary:dict];
        if ([currentItem isGroupItem]) {
            currentGroup = [[SBSettingGroup alloc]init];
            currentGroup.groupItem = (SBSettingItemGroup *)currentItem;
            [groups addObject:currentGroup];
        } else {
            [currentGroup.otherItems addObject:currentItem];
        }
    }

    return groups;
}

- (NSInteger) getNumberOfGroups {
    return self.settingGroups.count;
}

- (NSInteger) getNumberOfRowForGroupAtIndex: (NSInteger) index {
    SBSettingGroup *group = [self.settingGroups objectAtIndex:index];
    return group.otherItems.count;
}

- (SBSettingItem*) getItemAtIndexPath: (NSIndexPath *)indexPath {
    SBSettingGroup *group = [self.settingGroups objectAtIndex:indexPath.section];
    return [group.otherItems objectAtIndex:indexPath.row];
}

@end
