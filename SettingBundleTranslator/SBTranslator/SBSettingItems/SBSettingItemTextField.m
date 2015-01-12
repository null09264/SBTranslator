//
//  SBSettingTextFieldItem.m
//  SettingBundleTranslator
//
//  Created by Wang Jinghan on 11/01/15.
//  Copyright (c) 2015 NULL. All rights reserved.
//

#import "SBSettingItemTextField.h"

@implementation SBSettingItemTextField

- (instancetype) initWithDictionary: (NSDictionary *) preferenceDictionary {
    self = [super init];
    
    if (self) {
        assert([[preferenceDictionary objectForKey:@"Type"] isEqualToString:@"PSTextFieldSpecifier"]);
        self.autocapitalizationType = [self getAutocapitalizationTypeFromDictionary:preferenceDictionary];
        self.autocorrectionType = [self getAutocorrectionTypeFromDictionary:preferenceDictionary];
        self.defaultValue = [preferenceDictionary objectForKey:@"DefaultValue"];
        self.isSecure = [preferenceDictionary objectForKey:@"IsSecure"];
        self.key = [preferenceDictionary objectForKey:@"Key"];
        self.keyboardType = [self getKeyboardTypeFromDictionary:preferenceDictionary];
        self.title = [preferenceDictionary objectForKey:@"Title"];
        self.type = @"PSTextFieldSpecifier";
    }
    
    return self;
}

- (UITextAutocapitalizationType) getAutocapitalizationTypeFromDictionary: (NSDictionary *)dictionary {
    NSString* typeString = [dictionary objectForKey:@"AutocapitalizationType"];
    if ([typeString isEqualToString:@"None"]) {
        return UITextAutocapitalizationTypeNone;
    } if ([typeString isEqualToString:@"Words"]) {
        return UITextAutocapitalizationTypeWords;
    } if ([typeString isEqualToString:@"Sentences"]) {
        return UITextAutocapitalizationTypeSentences;
    } if ([typeString isEqualToString:@"AllCharacters"]) {
        return UITextAutocapitalizationTypeAllCharacters;
    } else {
        return UITextAutocapitalizationTypeNone;
    }
}

- (UITextAutocorrectionType) getAutocorrectionTypeFromDictionary:(NSDictionary *)dictionary {
    NSString* typeString = [dictionary objectForKey:@"AutocorrectionType"];
    if ([typeString isEqualToString:@"No"]) {
        return UITextAutocorrectionTypeNo;
    } else if ([typeString isEqualToString:@"Yes"]) {
        return UITextAutocorrectionTypeYes;
    } else {
        return UITextAutocorrectionTypeDefault;
    }
}

- (UIKeyboardType) getKeyboardTypeFromDictionary:(NSDictionary *)dictionary {
    NSString* typeString = [dictionary objectForKey:@"KeyboardType"];
    if ([typeString isEqualToString:@"Alphabet"]) {
        return UIKeyboardTypeAlphabet;
    } else if ([typeString isEqualToString:@"ASCIICapable"]) {
        return UIKeyboardTypeASCIICapable;
    } else if ([typeString isEqualToString:@"DecimalPad"]) {
        return UIKeyboardTypeDecimalPad;
    } else if ([typeString isEqualToString:@"Default"]) {
        return UIKeyboardTypeDefault;
    } else if ([typeString isEqualToString:@"EmailAddress"]) {
        return UIKeyboardTypeEmailAddress;
    } else if ([typeString isEqualToString:@"NamePhonePad"]) {
        return UIKeyboardTypeNamePhonePad;
    } else if ([typeString isEqualToString:@"NumberPad"]) {
        return UIKeyboardTypeNumberPad;
    } else if ([typeString isEqualToString:@"NumbersAndPunctuation"]) {
        return UIKeyboardTypeNumbersAndPunctuation;
    } else if ([typeString isEqualToString:@"PhonePad"]) {
        return UIKeyboardTypePhonePad;
    } else if ([typeString isEqualToString:@"Twitter"]) {
        return UIKeyboardTypeTwitter;
    } else if ([typeString isEqualToString:@"URL"]) {
        return UIKeyboardTypeURL;
    } else if ([typeString isEqualToString:@"WebSearch"]) {
        return UIKeyboardTypeWebSearch;
    } else {
        return UIKeyboardTypeDefault;
    }
}


@end
