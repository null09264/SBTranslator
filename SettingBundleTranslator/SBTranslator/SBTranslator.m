//
//  SBTranslator.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBTranslator.h"

@interface SBTranslator()

@end

@implementation SBTranslator

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [SBTranslator registerDefaultsFromSettingsBundle];
        [self updateSettingItemsWithFile:@"Root"];
    }
    
    return self;
}

- (instancetype) initWithFile: (NSString *) fileName {
    self = [super init];
    
    if (self) {
        [SBTranslator registerDefaultsFromSettingsBundle];
        [self updateSettingItemsWithFile:fileName];
    }
    
    return self;
}

- (void) updateSettingItemsWithFile: (NSString *) fileName {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Settings.bundle/%@", fileName] ofType:@"plist"];
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
        } else if ([currentItem isRadioGroupItem]) {
            currentGroup = [[SBSettingGroup alloc]init];
            [currentGroup setRadioGroupItem:(SBSettingItemRadioGroup *)currentItem];
            NSString *currentValue = [[NSUserDefaults standardUserDefaults] objectForKey:currentGroup.radioGroup.key];
            [currentGroup selectElementWithValue:currentValue];
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
    return [group getNumberOfRows];
}

- (SBSettingItem*) getItemAtIndexPath: (NSIndexPath *)indexPath {
    SBSettingGroup *group = [self.settingGroups objectAtIndex:indexPath.section];
    return [group getItemAtIndex:indexPath.row];
}

+ (void)registerDefaultsFromSettingsBundle {
    NSString *settingsBundle=[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if (!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings=[NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences=[settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister=[[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key=[prefSpecification objectForKey:@"Key"];
        if(key) {
            id object = [prefSpecification objectForKey:@"DefaultValue"];
            if (object) {
                [defaultsToRegister setObject: object forKey:key];
            }
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}

@end
