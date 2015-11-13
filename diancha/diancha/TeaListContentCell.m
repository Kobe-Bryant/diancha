//
//  TeaListContentCell.m
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "TeaListContentCell.h"

@implementation TeaListContentCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setContent:(NSDictionary *)data
{
    [im_avatar setImageFromUrl:YES withUrl:[BASE_URL stringByAppendingString:[data objectForKey:@"productStorePicture"]]];
    
    lb_name.text = [[data objectForKey:@"productName"] stringByAppendingString:[NSString stringWithFormat:@" %@",[data objectForKey:@"productPici"]]];
    lb_unitPrice.text = [NSString stringWithFormat:@"单价: %@/%@",[data objectForKey:@"incomeAmount"],[data objectForKey:@"unitName"]];
    

    lb_amount.text = [NSString stringWithFormat:@"数量: %@%@",[data objectForKey:@"productNumber"],[data objectForKey:@"unitName"]];
    
    lb_price.text = [NSString stringWithFormat:@"总价: ￥%d",[[data objectForKey:@"incomeAmount"] integerValue]*[[data objectForKey:@"productNumber"] integerValue]];
    
    if(!IOS7){
        lb_amount.textAlignment = NSTextAlignmentLeft;
        lb_price.textAlignment = NSTextAlignmentLeft;
    }
}

@end
