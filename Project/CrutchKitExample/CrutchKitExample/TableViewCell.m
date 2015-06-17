//
//  TableViewCell.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "TableViewCell.h"
#import "UIApplication+CDProxy.h"

@interface TableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation TableViewCell

- (id<TableViewCellDelegate>)proxyForSelector:(SEL)selector {
    
    Protocol *protocol = @protocol(TableViewCellDelegate);
    
    UIApplication *application = [UIApplication sharedApplication];
    
    id<TableViewCellDelegate> proxy = (id<TableViewCellDelegate>)[application observersProxyForProtocol:protocol
                                                                                               selector:selector
                                                                                              forSender:self];
    return proxy;
}


- (IBAction)buttonAction:(id)sender {

    SEL selector = @selector(didPressButton:onCell:);
    
    id<TableViewCellDelegate> proxy = [self proxyForSelector:selector];
    
    [proxy didPressButton:sender
                   onCell:self];
    
}

- (IBAction)switchAction:(id)sender {
    
    SEL selector = @selector(didSwitch:);
    
    id<TableViewCellDelegate> proxy = [self proxyForSelector:selector];
    
    [proxy didSwitch:sender];
    
}


- (IBAction)changedSliderValue:(id)sender {
}
@end
