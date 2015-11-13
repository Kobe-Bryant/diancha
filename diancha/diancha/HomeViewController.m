//
//  HomeViewController.m
//  diancha
//
//  Created by Fang on 14-6-24.
//  Copyright (c) 2014年 meetrend. All rights reserved.
//

#import "HomeViewController.h"
#import "RRToken.h"
#import "RRLoader.h"
#import "SVProgressHUD.h"
#import "Toast+UIView.h"
#import "RWHomeCache.h"
#import "CheckListCell.h"
#import "EScrollerView.h"
#import "ACPScrollMenu.h"
#import "TeaListViewController.h"
#import "OrderViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "AppDelegate.h"
#import "LogoutViewController.h"
#import "MMGridRoomViewCell.h"
#import "UrlImageButton.h"

@interface HomeViewController ()<ACPScrollDelegate,OrderViewControllerDelegate,LogoutViewControllerDelegate>

@property(nonatomic,strong)IBOutlet UIView *head_view;
@property(nonatomic,strong)IBOutlet UIView *foot_view;
@property(nonatomic,strong)IBOutlet UIButton *btn_recommend;
@property(nonatomic,strong)IBOutlet UIButton *btn_sheng;
@property(nonatomic,strong)IBOutlet UIButton *btn_shu;
@property(nonatomic,strong)IBOutlet UIButton *btn_daipao;
@property(nonatomic,strong)IBOutlet UIButton *btn_optional;

@property(nonatomic,strong)IBOutlet UISearchBar *search_bar;
@property(nonatomic,strong)IBOutlet UITableView *table_view;

@property(nonatomic,strong)IBOutlet UIPageControl *pageControl;

@property(nonatomic,strong)IBOutlet UIView *buttomView;
@property(nonatomic,strong)IBOutlet UILabel *lb_totalPrice;
@property(nonatomic,strong)IBOutlet UIButton *btn_take;
@property(nonatomic,strong)IBOutlet UIView *detail_view;
@property(nonatomic,strong)IBOutlet UILabel *detailNameLable;
@property(nonatomic,strong)IBOutlet UILabel *detailPriceLable;
@property(nonatomic,strong)IBOutlet UILabel *detailForePriceLable;

@property(nonatomic,strong)IBOutlet UILabel *shengshuLable;
@property(nonatomic,strong)IBOutlet UILabel *baozhuangLable;
@property(nonatomic,strong)IBOutlet UILabel *xingtaiLable;
@property(nonatomic,strong)IBOutlet UILabel *yearLable;
@property(nonatomic,strong)IBOutlet UILabel *guigeLable;
@property(nonatomic,strong)IBOutlet UILabel *piciLable;
@property(nonatomic,strong)IBOutlet UILabel *yuanliaoLable;
@property(nonatomic,strong)IBOutlet UILabel *gongyiLable;
@property(nonatomic,strong)IBOutlet UITextView *pinzhiText;
@property(nonatomic,strong)IBOutlet UITextView *pinzhiOptionalText;

@property(nonatomic,strong)IBOutlet UILabel *detailSumLable;
@property(nonatomic,strong)IBOutlet UILabel *unitNameLable;

@property(nonatomic,strong)IBOutlet EScrollerView *imageArrayView;
@property(strong, nonatomic)IBOutlet ACPScrollMenu *scrollMenuView;
@property(strong, nonatomic)IBOutlet UIView *touchView;

@property(strong ,nonatomic)IBOutlet UIView *roomView;
@property(strong ,nonatomic)IBOutlet UITextView *tv_roomDescribe;
@property(nonatomic,strong)IBOutlet UIButton *btn_room;
@property(nonatomic,strong)IBOutlet UILabel *lb_roomTile;

@property(nonatomic,strong)IBOutlet UIView *roomDetailView;
@property(nonatomic,strong)IBOutlet UILabel *lb_roomName;
@property(nonatomic,strong)IBOutlet UILabel *lb_roomPrice;
@property(nonatomic,strong)IBOutlet UrlImageView *im_room;
@property(nonatomic,strong)IBOutlet UIScrollView *room_scrollView;

@property(nonatomic,strong)IBOutlet UIView *optionalView;
@end

@implementation HomeViewController

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
    self.btn_recommend.selected = YES;
    buffer = [NSMutableArray array];
    dataSource = [NSMutableArray array];
    yearArray = [NSMutableArray array];
    roomListBuffer = [NSMutableArray array];
    
    gridView.cellMargin = 10;
    gridView.numberOfRows = 3;
    gridView.numberOfColumns = 2;
    gridView.layoutStyle = HorizontalLayout;
    
    dataSource = [NSMutableArray arrayWithCapacity:20];
    catalogName = @"0";
    [self loadRecommendData];
    
    // setup the page control
    [self setupPageControl];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_select_click:(id)sender
{
    if (roomViewDidShow){
        [self btn_room_click:nil];
    }
    if (is_detail) {
        [self dismissDetailView];
    }

    [self dismissScollMenuView];
    [self.search_bar resignFirstResponder];
    [dataSource removeAllObjects];
    [self reload];
    
    switch ([sender tag]) {
        case 1:
            self.btn_recommend.selected = YES;
            self.btn_sheng.selected = NO;
            self.btn_shu.selected = NO;
            self.btn_daipao.selected = NO;
            self.btn_optional.selected = NO;
            catalogName = @"0";
            [self loadRecommendData];
            break;
        case 2:
            self.btn_recommend.selected = NO;
            self.btn_sheng.selected = YES;
            self.btn_shu.selected = NO;
            self.btn_daipao.selected = NO;
            self.btn_optional.selected = NO;
            catalogName = @"1";
            yearId = @"710EC8B8-8017-4C28-8894-3407FD32526A";
            [self loadYearData];
            break;
        case 3:
            self.btn_recommend.selected = NO;
            self.btn_sheng.selected = NO;
            self.btn_shu.selected = YES;
            self.btn_daipao.selected = NO;
            self.btn_optional.selected = NO;
            catalogName = @"2";
            yearId = @"727DE736-F047-4F8C-BBDC-B5C36EF8E26C";
            [self loadYearData];
            break;
        case 4:
            self.btn_recommend.selected = NO;
            self.btn_sheng.selected = NO;
            self.btn_shu.selected = NO;
            self.btn_daipao.selected = YES;
            self.btn_optional.selected = NO;
            catalogName = @"3";
            yearId = @"9268D0EC-6D90-4090-83C2-EDA9A085C0CD";
            [self loadYearData];
            break;
        case 5:
            self.btn_recommend.selected = NO;
            self.btn_sheng.selected = NO;
            self.btn_shu.selected = NO;
            self.btn_daipao.selected = NO;
            self.btn_optional.selected = YES;
            yearId = @"510E7C0B-9608-428A-B3B7-EE86D7FC6202";
            catalogName = @"4";
            [self loadCatalogDate];
            break;
        default:
            break;
    }
    
}

#pragma mark - 
#pragma mark UISearchDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (roomViewDidShow)
        [self btn_room_click:nil];
    [self search];
    [self.search_bar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        // Return the number of rows in the section.
    if ([buffer count] == 0) {
        return 1;
    }
    return [buffer count];
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
//        cell.textLabel.text = @"无数据";
        cell.textLabel.font = font;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    NSString *CellIdentifier = @"CheckListCell";
    NSDictionary *dic = [buffer objectAtIndex:indexPath.row];
    
    CheckListCell*cell = (CheckListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell)
    {
        UIViewController *uc = [[UIViewController alloc] initWithNibName:CellIdentifier bundle:nil];
        
        cell = (CheckListCell *)uc.view;
        [cell setContent:dic];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
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
    NSDictionary *dic = [buffer objectAtIndex:indexPath.row];
    productId = [dic objectForKey:@"productId"];
    [self loadDetail];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    tableView_head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 176, 50)];
    
    UISegmentedControl *sg_ctrl = [[UISegmentedControl alloc] initWithItems:@[@"已点选",@"已下单"]];
    sg_ctrl.tintColor = dayiColor;
    sg_ctrl.frame = CGRectMake(20, 10, 123, 29);
    sg_ctrl.selectedSegmentIndex = 0;
    [sg_ctrl addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 176, 50)];
    lb.textColor = dayiColor;
    lb.text = @"购物车";
    lb.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 176, 1)];
    im.image = [UIImage imageNamed:@"img32"];
    [tableView_head addSubview:lb];
    [tableView_head addSubview:im];

    tableView_head.backgroundColor = [UIColor whiteColor];
    return tableView_head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self updateItemAtIndexPath:indexPath withString:nil];
    }
}

- (void) updateItemAtIndexPath:(NSIndexPath *)indexPath withString: (NSString *)string
{
    [buffer removeObjectAtIndex:indexPath.row];
    [self.table_view reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    NSUInteger sum = 0;
    for (NSDictionary *dic in buffer) {
        sum += [[dic objectForKey:@"number"] integerValue] * [[dic objectForKey:@"storePrice"] integerValue];
    }
    
    self.lb_totalPrice.text = [NSString stringWithFormat:@"￥%d",sum];
    [self reload];
}


#pragma mark - EventHandle

- (void)segmentedControlDidChange:(id)sender
{
    NSLog(@"%@",sender);
    
}

- (IBAction)btn_teaList_click:(id)sender
{
    TeaListViewController *ctrl = [[TeaListViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:IOS7?@"img29":@"navigationbar"]forBarMetrics:UIBarMetricsDefault];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (IBAction)btn_logOut_click:(id)sender
{
    logoutViewController = [[LogoutViewController alloc] initWithNibName:@"LogoutViewController" bundle:nil];
    logoutViewController.delegate = self;
    [self presentPopupViewController:logoutViewController animationType:MJPopupViewAnimationFade];
}

- (void)reload
{
    [gridView reloadData];
    [self setupPageControl];
    [self showButtomView];
}


- (void)setupPageControl
{
    self.pageControl.numberOfPages = gridView.numberOfPages;
    self.pageControl.currentPage = gridView.currentPageIndex;
}

- (IBAction)btn_room_click:(id)sender
{
    if (is_detail) {
        [self dismissDetailView];
    }
    self.roomView.hidden = roomViewDidShow;
    roomViewDidShow = !roomViewDidShow;
    [self.btn_room setTitle:roomViewDidShow?@"查看菜单":@"查看包间" forState:UIControlStateNormal];
    if (!roomViewDidShow)
        [self dismissRoomDetailView];
    [gridView reloadData];
    [self setupPageControl];
    if (roomViewDidShow && [roomListBuffer count] == 0){
        [self loadRoomList];
    }
}

#pragma mark - MMGridViewDataSource

- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    if (roomViewDidShow) {
        return [roomListBuffer count];
    }
    return [dataSource count];
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    if (roomViewDidShow) {
        NSDictionary *dic = [roomListBuffer objectAtIndex:index];
        MMGridRoomViewCell *cell = [[MMGridRoomViewCell alloc] initWithFrame:CGRectNull];
        [cell setUpCellData:dic];
        cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img9"]];
        return cell;
    }
    NSDictionary *dic = [dataSource objectAtIndex:index];
    MMGridViewDefaultCell *cell = [[MMGridViewDefaultCell alloc] initWithFrame:CGRectNull];
    for (NSDictionary *d in buffer) {
        if ([[d objectForKey:@"productId"] isEqualToString:[dic objectForKey:@"productId"]]) {
            
            cell.sum = [[d objectForKey:@"number"] integerValue];
            break;
        }
    }
    cell.catalogName = catalogName;
    [cell setUpCellData:dic];
    cell.delegate = self;
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", index];
    cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"img9"]];
    return cell;
}

-(void)loadMoreForGrid
{
    if ([catalogName isEqualToString:@"0"]) {
        [self loadMoreRecommendData];
    }
    
    else if ([catalogName isEqualToString:@"4"]) {
        [self loadMoreRecommendData];
    }

    else {
        [self loadMoreYearData];
    }
}

-(void)LoadDataFinished
{
    [gridView reloadData];
    [gridView loadMoreFinished];
}

#pragma mark - MMGridViewDelegate

- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    if (roomViewDidShow) {
        
        NSDictionary *dic = [roomListBuffer objectAtIndex:index];
        roomId = [dic objectForKey:@"roomId"];
        [self loadRoomDetail];

        return;
    }
    NSDictionary *dic = [dataSource objectAtIndex:index];
    productId = [dic objectForKey:@"productId"];
    [self loadDetail];
}


- (void)gridView:(MMGridView *)gridView didDoubleTapCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    
}


- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    currentIndex = index;
    [self setupPageControl];
}

-(BOOL)canLoadMoreForGrid
{
    if (roomViewDidShow) {
        return NO;
    }
    if (pageCount > pageIndex-1) {
        return YES;
    }
    return NO;
}

#pragma mark loadData

- (void)loadRecommendData
{
    pageCount = 0;
    pageIndex = 0;
    if ([dataSource count] == 0)
        [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, RECOMMEND_TEA_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
	[req setParam:@"1" forKey:@"pageIndex"];
	[req setParam:@"12" forKey:@"pageSize"];
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}

- (void)loadMoreRecommendData
{
    if ([dataSource count] == 0)
        [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, RECOMMEND_TEA_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
	[req setParam:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"pageIndex"];
	[req setParam:@"12" forKey:@"pageSize"];
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadedMore:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}

- (void)loadCatalogDate
{
    pageCount = 0;
    pageIndex = 0;
    if ([dataSource count] == 0)
        [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, OPTIONAL_PLAY_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
	[req setParam:@"1" forKey:@"pageIndex"];
	[req setParam:@"12" forKey:@"pageSize"];
    [req setParam:yearId forKey:@"productCatalogId"];
    
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}

- (void)loadMoreCatalogDate
{
    if ([dataSource count] == 0)
        [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, OPTIONAL_PLAY_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
	[req setParam:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"pageIndex"];
	[req setParam:@"12" forKey:@"pageSize"];
    [req setParam:yearId forKey:@"productCatalogId"];
    NSLog(@"%@",yearId);
    
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadedMore:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}

- (void)search 
{
    [SVProgressHUD showWithStatus:@"搜索数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, SEARCH_PRODUCT_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
	[req setParam:@"1" forKey:@"pageIndex"];
	[req setParam:@"50" forKey:@"pageSize"];
    [req setParam:self.search_bar.text forKey:@"productName"];
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
    
    NSLog(@"%@",json);

    NSLog(@"%@",[[json objectForKey:@"data"] objectForKey:@"msg"]);
    
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:@"获取数据失败!"];
        [self reload];
		return;
	}
    
    NSDictionary *data = [json objectForKey:@"data"];
    NSArray *arr = [data objectForKey:@"records"];
    if ([arr count] == 0) {
        [SVProgressHUD dismissWithError:@"暂无数据!"];
        [self reload];
        return;
    }
    [SVProgressHUD dismiss];
    [dataSource removeAllObjects];
    [dataSource addObjectsFromArray:arr];
    pageCount = [[data objectForKey:@"pageCount"]integerValue];
    pageIndex = [[data objectForKey:@"pageIndex"] integerValue]+1;
    [self reload];
}

- (void) onLoadedMore: (NSNotification *)notify
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
		return;
	}
    
    NSDictionary *data = [json objectForKey:@"data"];
    NSArray *arr = [data objectForKey:@"records"];
    if ([arr count] == 0) {
        return;
    }
    [SVProgressHUD dismiss];
    [dataSource addObjectsFromArray:arr];
    pageCount = [[data objectForKey:@"pageCount"]integerValue];
    pageIndex = [[data objectForKey:@"pageIndex"] integerValue]+1;
    [self LoadDataFinished];
}

- (void) onLogOut: (NSNotification *)notify
{
	RRLoader *loader = (RRLoader *)[notify object];
	
	NSDictionary *json = [loader getJSONData];
    
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:[[json objectForKey:@"data"] objectForKey:@"msg"]];
		return;
	}
    
    AppDelegate *delegate = [AppDelegate getInstance];
    [delegate showLoginView];
}

- (void)loadDetail
{
    [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, PRODUCT_DETAIL_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
	[req setParam:productId forKey:@"productId"];
    if([catalogName integerValue] == 4)
        [req setParam:@"own" forKey:@"type"];
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadDetail:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}

- (void) onLoadDetail: (NSNotification *)notify
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
        [SVProgressHUD dismissWithError:@"获取数据失败!"];
		return;
	}
    if ([[[json objectForKey:@"data"] objectForKey:@"msg"] length]) {
        [SVProgressHUD dismissWithSuccess:[[json objectForKey:@"data"] objectForKey:@"msg"]];
        return;
    }
    
    [SVProgressHUD dismiss];
    detailDict = [json objectForKey:@"data"];
    [self showDetailView];
}

- (void)loadYearData
{
    [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL,INVENTORY_LIST_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
	[req setParam:yearId forKey:@"catalogId"];
    [req setParam:@"1" forKey:@"pageIndex"];
	[req setParam:@"12" forKey:@"pageSize"];

	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoaded:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}

- (void)loadMoreYearData
{
    if ([dataSource count] == 0)
        [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, INVENTORY_LIST_URL];
    
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
    [req setParam:yearId forKey:@"catalogId"];
	[req setParam:[NSString stringWithFormat:@"%d",pageIndex] forKey:@"pageIndex"];
	[req setParam:@"12" forKey:@"pageSize"];
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadedMore:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}

- (void)loadRoomList
{
    [SVProgressHUD showWithStatus:@"获取数据中"];
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
    NSLog(@"%@",[json objectForKey:@"data"]);
    
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:@"获取失败!"];
        
		return;
	}
    [SVProgressHUD dismiss];
    
    roomDescriber = [[[json objectForKey:@"data"]objectForKey:@"data"] objectForKey:@"RoomDescription"];
    self.tv_roomDescribe.text = roomDescriber;
    
    NSArray *array = [[[json objectForKey:@"data"]objectForKey:@"data"] objectForKey:@"records"];
    if ([array count] == 0) {
        return;
    }
    [roomListBuffer removeAllObjects];
    [roomListBuffer addObjectsFromArray:array];
    [gridView reloadData];
    [self setupPageControl];
}

- (void)loadRoomDetail
{
    [SVProgressHUD showWithStatus:@"获取数据中"];
    RRToken *token = [RRToken getInstance];
    NSString *full_url = [NSString stringWithFormat:@"%@%@", BASE_URL, ROOM_DETAIL_URL];
	RRURLRequest *req = [[RRURLRequest alloc] initWithURLString:full_url];
    [req setParam:[token getProperty:@"tokensn"] forKey:@"token"];
    [req setParam:[token getProperty:@"storeId"] forKey:@"storeId"];
    [req setParam:roomId forKey:@"roomId"];
	[req setHTTPMethod:@"POST"];
	
	RRLoader *loader = [[RRLoader alloc] initWithRequest:req];
	[loader addNotificationListener:RRLOADER_COMPLETE target:self action:@selector(onLoadRoomDetail:)];
	[loader addNotificationListener:RRLOADER_FAIL target:self action:@selector(onLoadFail:)];
	[loader loadwithTimer];
}

- (void) onLoadRoomDetail: (NSNotification *)notify
{
	RRLoader *loader = (RRLoader *)[notify object];
	NSDictionary *json = [loader getJSONData];
    NSLog(@"%@",json );
    NSLog(@"%@",[[json objectForKey:@"data"] objectForKey:@"msg"]);

	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
	
	//login fail
	if (![[json objectForKey:@"success"] boolValue])
	{
        [SVProgressHUD dismissWithError:@"获取失败!"];
		return;
	}
    
    [SVProgressHUD dismiss];
    roomDetailDict = [json objectForKey:@"data"];
    [self showRoomDetailView];
}


- (void) onLoadFail: (NSNotification *)notify
{
    [SVProgressHUD dismissWithError:@"网络错误!" afterDelay:1.5f];
	RRLoader *loader = (RRLoader *)[notify object];
	[loader removeNotificationListener:RRLOADER_COMPLETE target:self];
	[loader removeNotificationListener:RRLOADER_FAIL target:self];
}

- (void)changeProdectNumber:(NSDictionary *)dic
{
    BOOL is_contain = false;
    
    for (int i = 0; i<[buffer count]; i++) {
        NSDictionary *d = [buffer objectAtIndex:i];
        if ([[d objectForKey:@"productId"] isEqualToString:[dic objectForKey:@"productId"]]) {
            is_contain = YES;
            [buffer removeObjectAtIndex:i];
            if ([[dic objectForKey:@"number"] integerValue]) {
                [buffer addObject:dic];
            }
        }
    }
    if (!is_contain && [[dic objectForKey:@"number"] integerValue])
        [buffer addObject:dic];
    
    [self.table_view reloadData];
    [self showButtomView ];
}

- (void)showButtomView
{
    if ([buffer count]) {
        self.buttomView.hidden = NO;
        float sum = 0;
        for (NSDictionary *dic in buffer) {
            sum += [[dic objectForKey:@"number"] floatValue] * [[dic objectForKey:@"storePrice"] floatValue];
        }
        
        self.lb_totalPrice.text = [NSString stringWithFormat:@"￥%.2f",sum];
    }
    else {
        self.buttomView.hidden = YES;
    }
}

- (IBAction)btn_take_click:(id)sender
{
    if ([buffer count] == 0) {
        [self.view makeToast:@"还没有选择数量!"];
        return;
    }
    secondDetailViewController = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    [secondDetailViewController setUpBuffer:buffer];
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];

}

- (IBAction)btn_detail_back_click:(id)sender
{
    [self dismissDetailView];
}

- (IBAction)btn_roomDetail_back_click:(id)sender
{
    [self dismissRoomDetailView];
}

- (IBAction)btn_add_click:(id)sender
{
    sumPrice++;
    self.detailSumLable.text = [NSString stringWithFormat:@"%d",sumPrice];
    [self changeProdectNumber];
}

- (IBAction)btn_reduce_click:(id)sender
{
    if (sumPrice != 0) {
        sumPrice--;
        self.detailSumLable.text = [NSString stringWithFormat:@"%d",sumPrice];
    }
    [self changeProdectNumber];
}

- (void)btn_image_click:(id)sender
{
    NSString *url = [BASE_URL stringByAppendingString:[[imageArray objectAtIndex:[sender tag]%10] objectForKey:@"avatarId"]];
    NSLog(@"%@",url);
    [self setUpRoomScrollView];
    UrlImageButton *btn = (UrlImageButton *)[self.room_scrollView viewWithTag:[sender tag]];
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = dayiColor.CGColor;
    btn.layer.borderWidth = 2.0f;
    [self.im_room setImageFromUrl:YES withUrl:url];
}

- (void)changeProdectNumber
{
    NSDictionary *dic = @{@"productName": [detailDict objectForKey:@"productName"],@"productId":[detailDict objectForKey:@"productId"],@"number":[NSString stringWithFormat:@"%d",sumPrice],@"storePrice":[detailDict objectForKey:@"storePrice"]};
    [self changeProdectNumber:dic];
}

- (void)showDetailView
{
    is_detail = YES;
    sumPrice = 0;
    [self setUpDetailView];
    self.pageControl.hidden = YES;
    self.detail_view.frame = CGRectMake(1050, 122, 808, 559);
    [self.view addSubview:self.detail_view];
    
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDuration:0.5];
    self.detail_view.frame = CGRectMake(196, 122, 808, 559);
    [UIView commitAnimations];
}

- (void)dismissDetailView
{
    is_detail = NO;
    sumPrice = 0;
    self.pageControl.hidden = NO;
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeDetailView)];
    self.detail_view.frame = CGRectMake(1050, 122, 808, 559);
    [UIView commitAnimations];
}

- (void)removeDetailView
{
    [self.detail_view removeFromSuperview];
    [self.imageArrayView removeFromSuperview];
    self.imageArrayView = nil;
}

- (void)setUpDetailView
{
    if ([catalogName isEqualToString: @"4" ]) {
        self.optionalView.hidden = NO;
    }
    else{
        self.optionalView.hidden = YES;
    }
    self.detailNameLable.text = [detailDict objectForKey:@"productName"];
    self.detailPriceLable.text = [NSString stringWithFormat:@"￥%@/%@",[detailDict objectForKey:@"storePrice"],[detailDict objectForKey:@"unitName"]];
    if ([[detailDict objectForKey:@"storeCostPrice"] integerValue] > 0) {
        self.detailForePriceLable.text = [detailDict objectForKey:@"storeCostPrice"];
        if ([[detailDict objectForKey:@"storeCostPrice"] integerValue]) {
            UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(5, 11, 62, 1)];
            im.image = [UIImage imageNamed:@"img31"];
            [self.detailForePriceLable addSubview:im];
        }
    }
    
    self.unitNameLable.text = [detailDict objectForKey:@"unitName"];
    self.shengshuLable.text = [detailDict objectForKey:@"parentCatalogName"];
    self.baozhuangLable.text = [detailDict objectForKey:@"productPackage"];
    self.xingtaiLable.text = [detailDict objectForKey:@"xingzhuang"];
    self.yearLable.text = [detailDict objectForKey:@"catalogName"];
    self.guigeLable.text = [detailDict objectForKey:@"standard"];
    self.piciLable.text = [detailDict objectForKey:@"productPici"];
    self.yuanliaoLable.text = [detailDict objectForKey:@"rawMaterial"];
    self.gongyiLable.text = [detailDict objectForKey:@"craftwork"];
    self.pinzhiText.text = [detailDict objectForKey:@"quality"];
    self.pinzhiText.font = [UIFont systemFontOfSize:14.0f];
    self.pinzhiOptionalText.text = [detailDict objectForKey:@"quality"];
    self.pinzhiOptionalText.font = [UIFont systemFontOfSize:14.0f];

    NSArray *array = [detailDict objectForKey:@"ppmRecords"];
    if ([array count]) {
        NSMutableArray *a = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            NSString *str = [dic objectForKey:@"img"];
            [a addObject:[BASE_URL stringByAppendingString:str]];
        }
        self.imageArrayView = [[EScrollerView alloc] initWithFrameRect:CGRectMake(10, 74, 490, 385)
                                                            ImageArray:a
                                                            TitleArray:nil];
        [self.detail_view addSubview:self.imageArrayView];
    }
    else{
        [self.imageArrayView removeFromSuperview];
        self.imageArrayView = nil;
    }
    
    for (NSDictionary *d in buffer) {
        if ([[d objectForKey:@"productId"] isEqualToString:[detailDict objectForKey:@"productId"]]) {
            sumPrice = [[d objectForKey:@"number"] integerValue];
            self.detailSumLable.text = [NSString stringWithFormat:@"%lu",(unsigned long)sumPrice];
            break;
        }
    }
    
}

- (void)showRoomDetailView
{
    is_roomDetail = YES;
    [self setUpRoomDetailView];
    self.pageControl.hidden = YES;
    self.roomDetailView.frame = CGRectMake(1050, 122, 808, 559);
    [self.view addSubview:self.roomDetailView];
    
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDuration:0.5];
    self.roomDetailView.frame = CGRectMake(196, 122, 808, 559);
    [UIView commitAnimations];
}

- (void)dismissRoomDetailView
{
    is_roomDetail = NO;
    self.pageControl.hidden = NO;
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeRoomDetailView)];
    self.roomDetailView.frame = CGRectMake(1050, 122, 808, 559);
    [UIView commitAnimations];
}

- (void)removeRoomDetailView
{
    for (int i = 0 ; i < [imageArray count]; i++) {
            [[self.room_scrollView viewWithTag:i + 10] removeFromSuperview];
     }
    self.tv_roomDescribe.text = roomDescriber;
    self.lb_roomTile.text = @"包间展示";
    [self.roomDetailView removeFromSuperview];
    imageArray = nil;
    self.im_room.image = nil;
}

- (void)setUpRoomDetailView
{
    self.tv_roomDescribe.text = [roomDetailDict objectForKey:@"detailDescription"];
    self.lb_roomTile.text = @"包间详情";
    
    self.lb_roomName.text = [roomDetailDict objectForKey:@"roomName"];
    self.lb_roomPrice.text = [NSString stringWithFormat:@"￥%@/小时",[roomDetailDict objectForKey:@"perHourPrice"]];
    if ([[roomDetailDict objectForKey:@"imgRecord"] isKindOfClass:[NSArray class]] && [[roomDetailDict objectForKey:@"imgRecord"]count]) {
        imageArray = [roomDetailDict objectForKey:@"imgRecord"];
        [self.im_room setImageFromUrl:YES withUrl:[BASE_URL stringByAppendingString:[[imageArray objectAtIndex:0] objectForKey:@"avatarId"] ]];
        [self setUpRoomScrollView];
        
        UrlImageButton *btn = (UrlImageButton *)[self.room_scrollView viewWithTag:10];
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = dayiColor.CGColor;
        btn.layer.borderWidth = 2.0f;
    }
}

- (void)setUpRoomScrollView
{
    for (int i = 0 ; i < [imageArray count]; i++) {
        if ([self.room_scrollView viewWithTag:i + 10]) {
            [[self.room_scrollView viewWithTag:i + 10] removeFromSuperview];
        }
        UrlImageButton *btn = [[UrlImageButton alloc] initWithFrame:CGRectMake(80*i, 2, 56, 56)];
        [btn setImageFromUrl:YES withUrl:[BASE_URL stringByAppendingString:[[imageArray objectAtIndex:i] objectForKey:@"avatarId"]]];
        btn.tag = i + 10;
        
        [btn addTarget:self action:@selector(btn_image_click:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.0f;

        [self.room_scrollView addSubview:btn];
    }
}


- (void)showScollMenuView
{
    [self dismissScollMenuView];
    self.touchView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 124.0f, 1024.0f, 644.0f)];
    self.touchView.alpha = 0.5;
    self.touchView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.touchView];
    
    self.scrollMenuView = [[ACPScrollMenu alloc] initWithFrame:CGRectMake(0, 80,1024, 44)];
    NSMutableArray *array = [[NSMutableArray alloc] init];

    NSUInteger highlightIndex = 0;
    for (int i = 0; i < [yearArray count]; i++) {
        //Set the items
		ACPItem *item = [[ACPItem alloc] initACPItem:[UIImage imageNamed:@"img19"] iconImage:nil andLabel:[[yearArray objectAtIndex:i] objectForKey:@"yearName"]];
        
		//Set highlighted behaviour
		[item setHighlightedBackground:[UIImage imageNamed:@"img20"] iconHighlighted:nil textColorHighlighted:[UIColor darkGrayColor]];
        
		[array addObject:item];
        
        if ([[[yearArray objectAtIndex:i] objectForKey:@"yearId"] isEqualToString:yearId]) {
            highlightIndex = i;
        }
	}
    
	[self.scrollMenuView setUpACPScrollMenu:array];
    [self.scrollMenuView setThisItemHighlighted:highlightIndex];

	//We choose an animation when the user touch the item (you can create your own animation)
	[self.scrollMenuView setAnimationType:ACPZoomOut];
    
	self.scrollMenuView.delegate = self;
    
    UIImage *originalImage = [UIImage imageNamed:@"img19"];
    UIEdgeInsets insets = UIEdgeInsetsMake(1, 1, 1, 1);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    self.scrollMenuView.frame = CGRectMake(0, 80,1024, 44);
    self.scrollMenuView.backgroundColor = [UIColor colorWithPatternImage:stretchableImage];
    [self.view addSubview:self.scrollMenuView];

}

- (void)scrollMenu:(ACPItem *)menu didSelectIndex:(NSInteger)selectedIndex
{
    yearId = [[yearArray objectAtIndex:selectedIndex] objectForKey:@"yearId"];
    [self loadCatalogDate];
    [self dismissScollMenuView];
}

- (void)dismissScollMenuView
{
    [self.scrollMenuView removeFromSuperview];
    self.scrollMenuView = nil;
    [self.touchView removeFromSuperview];
}

- (void)cancelButtonClicked:(NSMutableArray *)arrary
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    secondDetailViewController = nil;
    
    [buffer removeAllObjects];
    [buffer addObjectsFromArray:arrary];
    sumPrice = 0;
    self.detailSumLable.text = @"0";
    [self.table_view reloadData];
    [self reload];
    
    if ([buffer count] == 0) {
        [self showButtomView];
    }
}

- (void)cancelButtonClicked
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    logoutViewController = nil;
}

- (void)didSelectedPici:(NSString *)productID
{
    productId = productID;
    [self loadDetail];

}

@end
