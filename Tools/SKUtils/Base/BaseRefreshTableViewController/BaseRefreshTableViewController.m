//
//  BaseRefreshTableViewController.m
//  DangJian
//
//  Created by Sakya on 17/5/22.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "BaseRefreshTableViewController.h"


@interface BaseRefreshTableViewController ()

@property (nonatomic, readonly) UITableViewStyle style;

@end

@implementation BaseRefreshTableViewController
/**

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        _style = style;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:self.style];
    _tableView.accessibilityIdentifier = @"table_view";
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = self.defaultFooterView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    _page = 0;
    _showRefreshHeader = NO;
    _showRefreshFooter = NO;
    _showTableBlankView = NO;
}
#pragma mark - setter

- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        if (_showRefreshHeader) {
            __weak BaseRefreshTableViewController *weakSelf = self;
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weakSelf tableViewDidTriggerHeaderRefresh];
            }];
            self.tableView.mj_header.accessibilityIdentifier = @"refresh_header";
            //            header.updatedTimeHidden = YES;
        }
        else{
            [self.tableView setMj_header:nil];
        }
    }
}

- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        if (_showRefreshFooter) {
            __weak BaseRefreshTableViewController *weakSelf = self;
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [weakSelf tableViewDidTriggerFooterRefresh];
            }];
            self.tableView.mj_footer.accessibilityIdentifier = @"refresh_footer";
        }
        else{
            [self.tableView setMj_footer:nil];
        }
    }
}

- (void)setShowTableBlankView:(BOOL)showTableBlankView {
    
    if (_showTableBlankView != showTableBlankView) {
        _showTableBlankView = showTableBlankView;
        if (showTableBlankView) {
            self.placeholderView.hidden = NO;
        } else {
            self.placeholderView.hidden = YES;
        }
    }
}
- (void)setPlaceholderName:(NSString *)placeholderName {
    _placeholderName = placeholderName;
    
    if (_placeholderView) {
        _placeholderView.imageName = placeholderName;
    }
}
#pragma mark - getter

//- (NSMutableArray *)dataArray
//{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    
//    return _dataArray;
//}

- (SKPlaceholderView *)placeholderView {
   
    if(!_placeholderView) {
        
        _placeholderView = [[SKPlaceholderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.tableView.frame)) placeholderType:SKPlaceholderViewSimpleType];
        if (!_placeholderName) _placeholderName = @"defaultPlaceholder_noContent_icon";
        _placeholderView.imageName = _placeholderName;
        _placeholderView.titleText = @"暂无内容";
        _placeholderView.titleLabel.textColor = COLOR_HEX9;
        [self.tableView addSubview:_placeholderView];
    }
    return _placeholderView;
}
- (UIView *)defaultFooterView {
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - public refresh

- (void)autoTriggerHeaderRefresh {
    if (self.showRefreshHeader) {
        [self tableViewDidTriggerHeaderRefresh];
    }
}
- (void)beginHeaderRefreshAnimation {
    
    [self.tableView.mj_header beginRefreshing];
}
- (void)tableViewDidTriggerHeaderRefresh {
    
}

- (void)tableViewDidTriggerFooterRefresh {
    
}

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload {
    __weak BaseRefreshTableViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (reload) {
            [weakSelf.tableView reloadData];
        }
        
        if (isHeader) {
            [weakSelf.tableView.mj_header endRefreshing];
        } else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    });
}
- (void)showTableBlankViewDependDataCount:(NSInteger)count {
    
    if (count > 0) {
        
        self.showTableBlankView = NO;
    } else {
        
        self.showTableBlankView = YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
