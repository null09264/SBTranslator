//
//  SBTranslatorViewControllerTableViewController.m
//  SettingBundleTranslator
//
//  Created by Justus on 11/01/15.
//  Copyright (c) 2015年 NULL. All rights reserved.
//

#import "SBTranslatorViewController.h"

#import "SimplePickerInputTableViewCell.h"

#import "SBSettingItemGroup.h"
#import "SBSettingItemTextField.h"
#import "SBSettingItemToggleSwitch.h"
#import "SBSettingItemSlider.h"
#import "SBSettingItemMultiValue.h"

@interface SBTranslatorViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SimplePickerInputTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property SBTranslator *settingBundleTranslator;

@end

@implementation SBTranslatorViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.settingBundleTranslator = [[SBTranslator alloc]init];
        [SBTranslator registerDefaultsFromSettingsBundle];
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.settingBundleTranslator getNumberOfGroups];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settingBundleTranslator getNumberOfRowForGroupAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SBSettingItem *item = [self.settingBundleTranslator getItemAtIndexPath:indexPath];
    return [self getCellWithItem:item];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    SBSettingGroup *group = [self.settingBundleTranslator.settingGroups objectAtIndex:section];
    return group.groupItem.title;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableViewCell *) getCellWithItem: (SBSettingItem *)item {
    if ([item isTextFieldItem]) {
        return [self getCellWithTextFieldItem:(SBSettingItemTextField *)item];
    } else if ([item isToggleSwitchItem]) {
        return [self getCellWithToggleSwitchItem:(SBSettingItemToggleSwitch *)item];
    } else if ([item isSliderItem]) {
        return [self getCellWithSliderItem:(SBSettingItemSlider *)item];
    } else if ([item isMultiValueItem]) {
        return [self getCellWithMultiValueItem:(SBSettingItemMultiValue *)item];
    } else {
        return [self getDefaultCell];
    }
}

- (UITableViewCell *) getCellWithTextFieldItem: (SBSettingItemTextField *)item {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, cell.contentView.frame.size.width * 0.3, cell.contentView.frame.size.height)];
    titleLabel.text = item.title;
    [cell.contentView addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width * 0.3 + 10, 0, cell.contentView.frame.size.width * 0.7 - 15, cell.contentView.frame.size.height)];
    textField.autocapitalizationType = item.autocapitalizationType;
    textField.autocorrectionType = item.autocorrectionType;
    textField.text = [[NSUserDefaults standardUserDefaults] stringForKey:item.key];
    textField.keyboardType = item.keyboardType;
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    
    return cell;
}

- (UITableViewCell *) getCellWithToggleSwitchItem: (SBSettingItemToggleSwitch *)item {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item.title];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UISwitch *toggleSwitch = [[UISwitch alloc]init];
    [toggleSwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:item.key] animated:NO];
    [toggleSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = toggleSwitch;
    return cell;
}

- (UITableViewCell *) getCellWithSliderItem: (SBSettingItemSlider *)item {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UISlider *slider = [[UISlider alloc]init];
    slider.bounds = CGRectMake(0, 0, cell.contentView.bounds.size.width - 20, slider.bounds.size.height);
    slider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
    slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    slider.value = [[NSUserDefaults standardUserDefaults] doubleForKey:item.key];
    slider.minimumValue = item.minimumValue;
    slider.maximumValue = item.maximumValue;
    slider.minimumValueImage = [UIImage imageNamed:item.minimumValueImage];
    slider.maximumValueImage = [UIImage imageNamed:item.maximumValueImage];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:slider];
    return cell;
}

- (UITableViewCell *) getCellWithMultiValueItem: (SBSettingItemMultiValue *) item {
    SimplePickerInputTableViewCell *cell = [[SimplePickerInputTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = item.title;
    cell.values = item.titles;
    cell.delegate = self;
    cell.value = [item.titles objectAtIndex:[item.values indexOfObject:[[NSUserDefaults standardUserDefaults] stringForKey:item.key]]];
    return cell;
}

- (UITableViewCell *) getDefaultCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    return cell;
}

- (void) switchValueChanged: (UISwitch *) sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) sender.superview];
    SBSettingItemToggleSwitch *item = (SBSettingItemToggleSwitch *)[self.settingBundleTranslator getItemAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) sliderValueChanged: (UISlider *) sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) sender.superview.superview];
    SBSettingItemSlider *item = (SBSettingItemSlider *)[self.settingBundleTranslator getItemAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setFloat:sender.value forKey:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

#pragma UITextField Delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *) textField.superview.superview];
    SBSettingItemTextField *item = (SBSettingItemTextField *)[self.settingBundleTranslator getItemAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}


#pragma SimplePickerInputTableViewCell Delegate
- (void)tableViewCell:(SimplePickerInputTableViewCell *)cell didEndEditingWithValue:(NSString *)title {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SBSettingItemMultiValue *item = (SBSettingItemMultiValue *)[self.settingBundleTranslator getItemAtIndexPath:indexPath];
    NSString *value = [item.values objectAtIndex:[item.titles indexOfObject:title]];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:item.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
