//
//  BaseRefreshTableViewController.h
//  DangJian
//
//  Created by Sakya on 17/5/22.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "BaseViewController.h"
/** @brief 带加载、刷新的Controller(包含UITableView) */

@interface BaseRefreshTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
/** @brief 默认的tableFooterView */
@property (strong, nonatomic) UIView *defaultFooterView;

@property (strong, nonatomic) UITableView *tableView;
/** @brief tableView的数据源，用户UI显示 */
//@property (strong, nonatomic) NSMutableArray *dataArray;


/** @brief 当前加载的页数 */
@property (nonatomic) NSInteger page;

/** @brief 是否启用下拉加载更多，默认为NO */
@property (nonatomic) BOOL showRefreshHeader;
/** @brief 是否启用上拉加载更多，默认为NO */
@property (nonatomic) BOOL showRefreshFooter;
/** @brief 是否显示无数据时的空白提示，默认为NO(未实现提示页面) */
@property (nonatomic) BOOL showTableBlankView;

@property (nonatomic, copy) NSString *placeholderName;

/*!
 @method
 @brief 初始化ViewController
 @param style   tableView样式
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

/*!
 @method
 @brief 下拉加载更多(下拉刷新)
 */
- (void)tableViewDidTriggerHeaderRefresh;

/*!
 @method
 @brief 上拉加载更多
 */
- (void)tableViewDidTriggerFooterRefresh;

/*!
 @method
 @brief 加载结束
 @discussion 加载结束后，通过参数reload来判断是否需要调用tableView的reloadData，判断isHeader来停止加载
 @param isHeader   是否结束下拉加载(或者上拉加载)
 @param reload     是否需要重载TabeleView
 */
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;

/**
 开始下拉刷新有动画的刷新
 */
- (void)beginHeaderRefreshAnimation;

/**
 根据数据判断是否显示空白占位图

 @param count 数据数量
 */
- (void)showTableBlankViewDependDataCount:(NSInteger)count;
@end

