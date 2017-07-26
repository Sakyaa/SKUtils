//
//  BaseWebViewController.m
//  ThePartyBuild
//
//  Created by Sakya on 17/4/24.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "BaseWebViewController.h"
#import "SKPlaceholderView.h"

@interface BaseWebViewController ()<WKNavigationDelegate,SKPlaceholderViewDelegate,NSXMLParserDelegate>

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, strong) SKPlaceholderView *placeholderView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCustomWebView];
}

- (void)setUrlID:(NSString *)urlID {
    
    if ([urlID containsString:@"http:"]) {
        _urlString = urlID;
    } else {
        _urlString = [NSString stringWithFormat:@"%@%@/%@",APPBASEURLIP,URL_NOTICEINFO,urlID];
    }

}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (void)initCustomWebView {
   
    self.navigationItem.title = @"详情";
    //    updateVisibleContentRects
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    webView.scrollView.bounces = NO;
    webView.allowsBackForwardNavigationGestures = YES;
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    _webView = webView;

    
    if ([UserOperation shareInstance].netState == NetworkConditionNotReachable) {
        [_webView addSubview:self.placeholderView];
    }

    [self loadWebView];
}
- (void)loadWebView {

    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    NSString *token = [UserOperation shareInstance].userToken;
    [request addValue:token forHTTPHeaderField:@"token"];
    [_webView loadRequest:request];

    
}
- (void)loadHtml5WebViewurlString:(NSString *)urlString {
    
    NSString * strUrl = [NSString stringTransformCoding:urlString];
    DDLogDebug(@"%@",strUrl);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    
    DDLogInfo(@"URL -- %@",webView.URL);
    if (_placeholderView) {
        [self.placeholderView setHidden:YES];
    }
    NSString *doc = @"document.body.outerHTML";
    [webView evaluateJavaScript:doc completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
        if (error) {
            DDLogDebug(@"JSError:%@",error);
        }
        DDLogInfo(@"html:%@",htmlStr);

        NSData *data =[htmlStr dataUsingEncoding:NSUTF8StringEncoding];
        //1.创建NSXMLParser
        NSXMLParser *XMLParser = [[NSXMLParser alloc] initWithData:data];
        //2.设置代理
        [XMLParser setDelegate:self];
        //3.开始解析
        [XMLParser parse];
    }] ;
}





#pragma mark -- kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"title"]) {
        
        NSString *forwardTitle = change[@"new"];
        if (forwardTitle.length > 7) {
            self.navigationItem.title = [NSString stringWithFormat:@"%@...",[forwardTitle substringToIndex:7]];
        } else {
            self.navigationItem.title = forwardTitle;
        }
        
        DDLogInfo(@"%@",forwardTitle);
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"])  {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1)
        {
            [self.progressView setProgress:1 animated:YES];
            self.progressView.hidden = YES;
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
- (SKPlaceholderView *)placeholderView {
    if(!_placeholderView) {
        
        _placeholderView = [[SKPlaceholderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.webView.frame)) placeholderType:SKPlaceholderViewSimpleType];
        [_placeholderView setDelegate:self];
        _placeholderView.imageName = @"defaultPlaceholder_noNetwork_icon";
        _placeholderView.titleLabel.text = @"网络异常，点击屏幕重新加载";
        _placeholderView.titleLabel.textColor = COLOR_HEX9;
        [self.webView addSubview:_placeholderView];
    }
    return _placeholderView;
}
- (UIProgressView *)progressView {
    if (!_progressView) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 62, self.view.frame.size.width, 0)];
        
        progressView.tintColor = [UIColor whiteColor];
        progressView.trackTintColor = [UIColor clearColor];
        [self.navigationController.view addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
}
#pragma mark -SKPlaceholderViewdelegate
- (void)placeholderViewButtonActionDetected:(UIButton *)sender {
    
    [self loadWebView];
}
#pragma mark - NSXMLParserDelegate
//1.开始解析XML文件
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    DDLogDebug(@"开始解析XML文件");
}
//2.解析XML文件中所有的元素
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    DDLogDebug(@"解析XML文件中所有的元素:elementName:%@,attributeDict:%@",elementName,attributeDict);
    [self.dataArray addObject:attributeDict];
}
//3.XML文件中每一个元素解析完成
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    DDLogDebug(@"XML文件中每一个元素解析完成:elementName:%@,qName:%@",elementName,qName);
}
//4.XML所有元素解析完毕
-(void)parserDidEndDocument:(NSXMLParser *)parser{

    //除了body没有其他元素说明网页出错
    if (self.dataArray.count < 2) {
        [self.placeholderView setHidden:NO];
    }
}
#pragma mark - dealloc
- (void)dealloc {
    
    //移除 kvo
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    if (self.progressView) [self.progressView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
