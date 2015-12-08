//
//  TableViewCell.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "TableViewCell.h"
#import <CrutchKit/CDProxying.h>

@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) id<TableViewCellDelegate> actionProxy;

@end

@implementation TableViewCell

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.actionProxy = (id<TableViewCellDelegate>)[self cd_proxyForProtocol:@protocol(TableViewCellDelegate)];
}

- (IBAction)buttonAction:(id)sender {
    
    [self.actionProxy didPressButton:sender
                              onCell:self];
    
}

- (IBAction)switchAction:(id)sender {
    
    [self.actionProxy didSwitch:sender];
    
}


- (IBAction)changedSliderValue:(id)sender {
    
}
@end
