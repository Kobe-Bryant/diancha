//
//  OrderViewController.m
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "OrderViewController.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "DropDownListView.h"
#import "NSObject+SBJson.h"

@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    roomList = [NSMutableArray array];
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 8;
    contentListView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self loadOldOrderId];
    [self updataTotalPrice];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setUpBuffer:(NSMutableArray *)arrary
{
    buffer = [NSMutableArray arrayWithArray:arrary];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [buffer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"empty_cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_id];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    NSDictionary *dic = [buffer objectAtIndex:indexPath.row];
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.text = [dic objectForKey:@"productName"];
    cell.textLabel.font = font;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([cell.contentView viewWithTag:100+indexPath.row]) {
        [[cell.contentView viewWithTag:100+indexPath.row] removeFromSuperview];
    }
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"img12"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(btn_add_click:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setFrame:CGRectMake(415, 10, 33, 33)];
    addButton.tag =  100 + indexPath.row;
    [cell.contentView addSubview:addButton];
    
    if ([cell.contentView viewWithTag:200+indexPath.row]) {
        [[cell.contentView viewWithTag:200+indexPath.row] removeFromSuperview];
    }
    UIButton *reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceButton setImage:[UIImage imageNamed:@"img11"] forState:UIControlStateNormal];
    [reduceButton addTarget:self action:@selector(btn_reduce_click:) forControlEvents:UIControlEventTouchUpInside];
    [reduceButton setFrame:CGRectMake(315,10, 33, 33)];
    reduceButton.tag =  200 + indexPath.row;
    [cell.contentView addSubview:reduceButton];
    
    if ([cell.contentView viewWithTag:300+indexPath.row]) {
        [[cell.contentView viewWithTag:300+indexPath.row] removeFromSuperview];
    }
    UIImageView *im_blank = [[UIImageView alloc]initWithFrame:CGRectMake(358, 13, 50, 28)];
    im_blank.image = [UIImage imageNamed:@"img13"];
    im_blank.tag = 300 + indexPath.row;
    [cell.contentView addSubview:im_blank];
    
    if ([cell.contentView viewWithTag:700+indexPath.row]) {
        [[cell.contentView viewWithTag:700+indexPath.row] removeFromSuperview];
    }
    UIImageView *im_line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 54,750,1)];
    im_line.image = [UIImage imageNamed:@"img32"];
    im_line.tag = 700 + indexPath.row;
    [cell.contentView addSubview:im_line];

    if ([cell.contentView viewWithTag:400+indexPath.row]) {
        [[cell.contentView viewWithTag:400+indexPath.row] removeFromSuperview];
    }
    UILabel *sumLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 28)];
    sumLable.textAlignment = NSTextAlignmentCenter;
    sumLable.backgroundColor = [UIColor clearColor];
    sumLable.textColor = [UIColor darkGrayColor];
    sumLable.font = [UIFont systemFontOfSize:12];
    sumLable.text = [dic objectForKey:@"number"];
    sumLable.tag = 400 + indexPath.row;
    [im_blank addSubview:sumLable];

    if ([cell.contentView viewWithTag:500+indexPath.row]) {
        [[cell.contentView viewWithTag:500+indexPath.row] removeFromSuperview];
    }
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(548, 13, 80, 28)];
    priceLable.textAlignment = NSTextAlignmentCenter;
    priceLable.backgroundColor = [UIColor clearColor];
    priceLable.textColor = [UIColor blackColor];
    priceLable.tag = 500 + indexPath.row;
    priceLable.font = [UIFont systemFontOfSize:17];
    priceLable.text = [@"￥"stringByAppendingString:[dic objectForKey:@"storePrice"]];
    [cell.contentView addSubview:priceLable];

    if ([cell.contentView viewWithTag:600+indexPath.row]) {
        [[cell.contentView viewWithTag:600+indexPath.row] removeFromSuperview];
    }
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [delButton setImage:[UIImage imageNamed:@"img22"] forState:UIControlStateNormal];
    [delButton addTarget:self action:@selector(btn_del_click:) forControlEvents:UIControlEventTouchUpInside];
    [delButton setFrame:CGRectMake(700, 12, 30, 30)];
    delButton.tag = 600 + indexPath.row;
    [cell.contentView addSubview:delButton];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([buffer count] == 0) {
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)btn_cancel_click:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:buffer];
    }
}

- (IBAction)btn_take_click:(id)sender
{
    if (!roomId) {
        [self.view makeToast:@"请选择包间!"];
        return;
    }
    if ([buffer count] == 0) {
        [self.view makeToast:@"还没有选择产品!"];
        return;
    }

    NSMutableArray *buf = [NSMutableArray array];
    for (NSDictionary *dic in buffer) {
        NSDictionary *d = @{@"productId":[dic objectForKey:@"productId"],@"productNumber":[dic objectForKey:@"number"]};
        [buf addObject:d];
    }
    
    NSString *orderInfo = [buf JSONRepresentation];
    
    [SVProgressHUD showWithStatus:@"订单提交中!"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, TAKE_ORDER_URL];
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
    [req setParam:[token getProperty:@"id"] forKey:@"id"];
    [req setParam:roomId forKey:@"roomId"];
    [req setParam:orderInfo forKey:@"orderInfo"];
    if (oldOrderId) {
        [req setParam:oldOrderId forKey:@"orderId"];
    }
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onSendOrder:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];

}

- (void)btn_add_click:(id)sender
{
    NSUInteger index = [sender tag]%100;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[buffer objectAtIndex:index] ];
    
    NSUInteger sum = [[dic objectForKey:@"number"] integerValue];
    sum+=1;
    [dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)sum] forKey:@"number"];
    [buffer removeObjectAtIndex:index];
    [buffer insertObject:dic atIndex:index];
    [contentListView reloadData];
    [self updataTotalPrice];
}

- (void)btn_reduce_click:(id)sender
{
    NSUInteger index = [sender tag]%200;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[buffer objectAtIndex:index] ];
    
    NSUInteger sum = [[dic objectForKey:@"number"] integerValue];
    sum-=1;
    if (sum!=0) {
        [dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)sum] forKey:@"number"];
        [buffer removeObjectAtIndex:index];
        [buffer insertObject:dic atIndex:index];
    }
    else
    {
        [buffer removeObjectAtIndex:index];
    }
    [contentListView reloadData];
    [self updataTotalPrice];
}

- (void)btn_del_click:(id)sender
{
    NSUInteger index = [sender tag]%600;
    [buffer removeObjectAtIndex:index];
    [contentListView reloadData];
    [self updataTotalPrice];
}

- (void)loadOldOrderId
{
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, NOT_SETTLED_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
    [req setParam:[token getProperty:@"id"] forKey:@"id"];
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadOldOrderId:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];

}

- (void) onLoadOldOrderId: (NSNotification *)notify
{
    [self loadRoomList];

	RRLoader *loader = (RRLoader *)[notify object];
	
	NSDictionary *json = [loader getJSONData];
    NSLog(@"%@",json);
    NSLog(@"%@",[[json objectForKey:@"data"] objectForKey:@"msg"]);

	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:@"获取数据失败!"];
		return;
	}
    [SVProgressHUD dismiss];
    oldOrderId = [[json objectForKey:@"data"] objectForKey:@"orderId"];
}

- (void) onSendOrder: (NSNotification *)notify
{
	RRLoader *loader = (RRLoader *)[notify object];
	
	NSDictionary *json = [loader getJSONData];
    NSLog(@"%@",json);
    NSLog(@"%@",[[json objectForKey:@"data"] objectForKey:@"msg"]);
    
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:[[json objectForKey:@"data"] objectForKey:@"msg"]];
		return;
	}
    [SVProgressHUD dismissWithSuccess:@"订单提交成功,请稍后!"];
    [buffer removeAllObjects];
    [self performSelector:@selector(btn_cancel_click:) withObject:nil afterDelay:1.0f];
}

- (void)loadRoomList
{
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ROOM_LIST_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadRoomList:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
    
}

- (void) onLoadRoomList: (NSNotification *)notify
{
	RRLoader *loader = (RRLoader *)[notify object];
	
	NSDictionary *json = [loader getJSONData];
    
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:@"获取数据失败!"];
		return;
	}
    [SVProgressHUD dismiss];
    NSArray *arrary = [[[json objectForKey:@"data"] objectForKey:@"data"] objectForKey:@"records"];
    [roomList addObjectsFromArray:arrary];
    [self setUpDropDownList];
}

- (void) onLoadFail: (NSNotification *)notify
{
    [SVProgressHUD dismissWithError:@"网络错误!" afterDelay:1.5f];
	RRLoader *loader = (RRLoader *)[notify object];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
}

- (void)updataTotalPrice
{
    NSUInteger sum = 0;
    for (NSDictionary *dic in buffer) {
        sum += [[dic objectForKey:@"number"] integerValue] * [[dic objectForKey:@"storePrice"] integerValue];
    }
    
    lb_totalPrice.text = [NSString stringWithFormat:@"￥%lu",(unsigned long)sum];
}

- (void)setUpDropDownList
{
    NSDictionary *dic = @{@"roomName": @"请选择包间"};
    [roomList insertObject:dic atIndex:0];
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(20,5,140, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    dropDownView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:0.4f];
    [head_view addSubview:dropDownView];
}

#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    if (0 == index) {
        roomId = nil;
    }
    else{
        roomId = [[roomList objectAtIndex:index] objectForKey:@"roomId"];
        lb_roomPrice.text = [NSString stringWithFormat:@"(包间服务费:%@/小时)",[[roomList objectAtIndex:index] objectForKey:@"perHourPrice"]];
    }
}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return 1;
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [roomList count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    NSString *name = [[roomList objectAtIndex:index] objectForKey:@"roomName"];
    return name;
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

@end
