//
//  TeaListViewController.m
//  diancha
//
//  Created by Fang on 14-7-2.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "TeaListViewController.h"
#import "ACPScrollMenu.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "UrlImageView.h"
#import "TeaListTitleCell.h"
#import "TeaListContentCell.h"

@interface TeaListViewController ()<ACPScrollDelegate>

@end

@implementation TeaListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *btn_cancel;
    
    if (IOS7) {
        btn_cancel = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navitem_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(btn_cancel_click:)];
    }
    else
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navitem_back"] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0.0f, 0.0f, 35, 28)];
        [btn addTarget:self action:@selector(btn_cancel_click:) forControlEvents:UIControlEventTouchUpInside];
        btn_cancel = [[UIBarButtonItem alloc] initWithCustomView:btn];
     }

    self.navigationItem.leftBarButtonItem = btn_cancel;
    self.title = @"我的茶单";
    
    NSDictionary *textAttributes = nil;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:20],
                           UITextAttributeTextColor: [UIColor whiteColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
        
    }
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];

    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img32"]];
    buffer = [NSMutableArray array];
    payStatus = @"UnPay";
    [self loadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([buffer count] == 0) {
        return 1;
    }
    return [buffer count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([buffer count] == 0) {
        return 1;
    }

    NSDictionary *dic = [buffer objectAtIndex:section];
    NSArray *array = [dic objectForKey:@"orderDetailArray"];
    return [array count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([buffer count] == 0) {
        static NSString *cell_id = @"empty_cell";
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_id];
        if (nil == cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        }
        
        UIFont *font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.text = @"无数据";
        cell.textLabel.font = font;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    static NSString *cell_id = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cell_id];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    
    if (0 == indexPath.row) {
        NSString *CellIdentifier = @"TeaListTitleCell";
        NSDictionary *dic = [buffer objectAtIndex:indexPath.section];
        
        TeaListTitleCell *cell = (TeaListTitleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (nil == cell)
        {
            UIViewController *uc = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
            
            cell = (TeaListTitleCell *)uc.view;
            [cell setContent:dic];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        NSString *CellIdentifier = @"TeaListContentCell";
        NSDictionary *dic = [[[buffer objectAtIndex:indexPath.section] objectForKey:@"orderDetailArray"] objectAtIndex:indexPath.row-1];
        
        TeaListContentCell *cell = (TeaListContentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (nil == cell)
        {
            UIViewController *uc = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
            
            cell = (TeaListContentCell *)uc.view;
            [cell setContent:dic];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section)
        return 64;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
        
        ACPScrollMenu *scrollMenuView = [[ACPScrollMenu alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
        UIImage *originalImage = [UIImage imageNamed:@"img19"];
        UIEdgeInsets insets = UIEdgeInsetsMake(1, 1, 1, 1);
        UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
        scrollMenuView.backgroundColor = [UIColor colorWithPatternImage:stretchableImage];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        
        //Set the items
        ACPItem *item2 = [[ACPItem alloc] initACPItem:[UIImage imageNamed:@"img19"] iconImage:nil andLabel:@"已结账"];
        
        //Set highlighted behaviour
        [item2 setHighlightedBackground:[UIImage imageNamed:@"img20"] iconHighlighted:nil textColorHighlighted:[UIColor darkGrayColor]];
        
        ACPItem *item1 = [[ACPItem alloc] initACPItem:[UIImage imageNamed:@"img19"] iconImage:nil andLabel:@"未结账"];
        
        //Set highlighted behaviour
        [item1 setHighlightedBackground:[UIImage imageNamed:@"img20"] iconHighlighted:nil textColorHighlighted:[UIColor darkGrayColor]];

        [array addObject:item1];
        [array addObject:item2];

        [scrollMenuView setUpACPScrollMenu:array];
        
        //We choose an animation when the user touch the item (you can create your own animation)
        [scrollMenuView setAnimationType:ACPZoomOut];
        
        scrollMenuView.delegate = self;
        
        if ([payStatus isEqualToString:@"Payed"]) {
            [scrollMenuView setThisItemHighlighted:1];
        }
        else {
            [scrollMenuView setThisItemHighlighted:0];
        }

        [v addSubview:scrollMenuView];
        return v;

    }
    return nil;
}

- (void)btn_cancel_click:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollMenu:(ACPItem *)menu didSelectIndex:(NSInteger)selectedIndex
{
    if (1 == selectedIndex) {
        payStatus = @"Payed";
    }
    else {
        payStatus = @"UnPay";
    }
    [buffer removeAllObjects];
    [self.tableView reloadData];
    [self loadData];
}

- (void)loadData
{
    if ([buffer count] == 0)
        [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, TEA_MENU_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
    [req setParam:[token getProperty:@"id"] forKey:@"id"];
    [req setParam:payStatus forKey:@"payStatus"];
    
    
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];

}

- (void) onLoaded: (NSNotification *)notify
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
    
    NSArray *arr = [[json objectForKey:@"data"] objectForKey:@"orderArray"];
    if ([arr count] == 0) {
        [SVProgressHUD dismissWithSuccess:@"无数据!"];
        return;
    }
    [SVProgressHUD dismiss];
    [buffer removeAllObjects];
    [buffer addObjectsFromArray:arr];
    [self filtBuffer];
    [self.tableView reloadData];
}

- (void) onLoadFail: (NSNotification *)notify
{
    [SVProgressHUD dismissWithError:@"网络错误!" afterDelay:1.5f];
	RRLoader *loader = (RRLoader *)[notify object];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
}

- (void)filtBuffer
{
    NSSortDescriptor  *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"orderDate" ascending:NO];
    NSArray *tempArray = [buffer sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [buffer removeAllObjects];
    [buffer addObjectsFromArray:tempArray];
}

@end
