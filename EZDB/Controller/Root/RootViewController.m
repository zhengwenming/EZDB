//
//  RootViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-14.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "PerCenterVController.h"
#import "HelpCenterViewController.h"
#import "ChangePwdViewController.h"
#import "SetPayPwdViewController.h"
#import "FinacialViewController.h"
#import "UpdPwdViewController.h"
#import "LoginViewController.h"
#import "AssetViewController.h"
#import "RegViewController.h"
#import "WMBannerView.h"
#import "NSTimer+Addition.h"
#import "DbNoticeListRequest.h"
#import "NoticeViewController.h"
#import "HomeImgDataRequest.h"

#define kPages  3
#define kURL_PREFIX @"http://22.11.140.45"
typedef enum : NSUInteger {
    kButtonFinantial=11,
    kButtonAssert,
    kButtonBankManage,
    kButtonPersonal,
} kButtonType;

@interface RootViewController ()<UIScrollViewDelegate>
{
    WMBannerView *scollView;
    UIView          *noticeView;
    UIButton        *noticeBtn;
    NSString        *btnName;
    NSMutableArray  *imgArr;
    BOCHud *hud;
    NSUInteger totalSize;
    UIImage *image1;
    UIImage *image2;
    UIImage *image3;
    NSMutableArray *urlArray;
    NSMutableArray *linkUrlArray;
    NSMutableArray *idArray;

}

@end


@implementation RootViewController


#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imgArr = [NSMutableArray array];
        urlArray = [NSMutableArray array];
        idArray =[NSMutableArray array];
        linkUrlArray =[NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [self loadNavAndNotice];
    [self getNoticeTitle];

    [self getAdImage];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setHidden:YES];
    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];
//    [scollView.animationTimer resumeTimerAfterTimeInterval:5];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [scollView.animationTimer pauseTimer];
}



#pragma mark - 广告列表
- (void)getAdImage
{    
    NSDictionary *params = @{@"pageno":@"1",
                             @"pagesize":@"3",};
    BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
    HomeImgDataRequest *request = [HomeImgDataRequest requestWithHeaders:nil];
    NSMutableDictionary *headParameters = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
    
    request.headers = headParameters;
    request.postJSON = [params JSONString];
    hud = [[BOCHud alloc]initWithFrame:self.view.frame];
    hud.labelText = @"加载中...";
    [hud startAnimating];
    [self.view addSubview:hud];
    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        [hud removeForever];
        NSArray *arr = result[@"list"];
        NSLog(@"suc  >>>>  _ adImage result count is %d",arr.count);
            for (int i=0; i<arr.count; i++)
            {
                NSLog(@"suc  >>>>  _ adImage result count is %d",arr.count);
                [urlArray addObject:[NSString stringWithFormat:@"%@%@",kURL_PREFIX,arr[i][@"imageUrl1"]]];
                totalSize = [[result objectForKey:@"totalSize"] integerValue];
                [linkUrlArray addObject:arr[i][@"linkedUrl"]];
                [idArray addObject:arr[i][@"id"]];
            }
        [self setScollView];
        
    }];
    
    [request onRequestFailWithError:^(NSError *error) {
        [hud removeForever];
        [self setScollView];
    }];
    [request connect];
}

#pragma mark - loadNotice
- (void)loadNavAndNotice
{
    if (kDeviceVersion>=7.0){
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64) navTitle:@"中国银行直销银行" lBtnImg:nil rBtnImg:nil];
        noticeView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavbarHeight, kScreenWidth, 30)];
    }else{
        self.navView = [[NavView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) navTitle:@"中国银行直销银行" lBtnImg:nil rBtnImg:nil];
        noticeView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, 30)];
    }
    [noticeView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homemessage_bg.png"]]];
    [noticeView setAlpha:0.6];
    
    UIImageView *loudspeakerIV  = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 18, 18)];
    [loudspeakerIV setImage:[UIImage imageNamed:@"ico_news"]];
    
    //关闭公告imgView
    UIImageView *XimageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-25, 7, 15, 15)];
    [XimageView setImage:[UIImage imageNamed:@"ico_close"]];
    [XimageView setUserInteractionEnabled:YES];
    
    //关闭公告
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(kScreenWidth-50, 0, 50, 30)];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(closeNotice:) forControlEvents:UIControlEventTouchUpInside];
    
    noticeBtn = [[UIButton alloc]initWithFrame:CGRectMake(loudspeakerIV.frame.origin.x+loudspeakerIV.frame.size.width+5, loudspeakerIV.frame.origin.y-2, 255, 20)];
    [noticeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [noticeBtn setBackgroundColor:[UIColor clearColor]];
    [noticeBtn setTitle:@"中国银行中银易商直销银行手机客户端上线了！" forState:UIControlStateNormal];
    [noticeBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
    [noticeBtn addTarget:self action:@selector(nonticeDetail:) forControlEvents:UIControlEventTouchUpInside];
    [noticeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [noticeView addSubview:loudspeakerIV];
    [noticeView addSubview:XimageView];
    [noticeView addSubview:btn];
    [noticeView addSubview:noticeBtn];
    [self.view addSubview:noticeView];
    [self.view addSubview:self.navView];
    [self.view bringSubviewToFront:noticeView];
    [self.view bringSubviewToFront:self.navView];
    [self.view bringSubviewToFront:XimageView];

}

#pragma mark - 公告列表请求
- (void)getNoticeTitle
{
    BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
    DbNoticeListRequest *request = [DbNoticeListRequest requestWithHeaders:nil];
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
    //报文头
    
    //参数
    NSDictionary *bodyParameters = @{@"pageno":@"1",@"pagesize":@"5"};
    [request setHeaders:headers];
    [request setPostJSON:[bodyParameters JSONString]];
    
    [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"*** __ result %@",result);
            [UserInfoSample shareInstance].listItems = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                [noticeBtn setTitle:result[@"list"][0][@"name"] forState:UIControlStateNormal];
            });
        });
    }];
    [request onRequestFailWithError:^(NSError *error) {
        NSLog(@"*** __ err %@",error);
        
    }];
    [request connect];
}


//点击公告详情
- (void)nonticeDetail:(UIButton *)sender
{

    NoticeViewController *nvc;
    if (IS_IPHONE4) {
        nvc = [[NoticeViewController alloc]initWithNibName:@"NoticeViewController35" bundle:nil];
    }else if (IS_IPHONE5){
        nvc = [[NoticeViewController alloc]initWithNibName:@"NoticeViewController" bundle:nil];
    }
    NSLog(@"__ id %@",[UserInfoSample shareInstance].listItems[@"list"][0][@"id"]);
    nvc.noticeId = [UserInfoSample shareInstance].listItems[@"list"][0][@"id"];
    [self.navigationController pushViewController:nvc animated:YES];
}
//关闭公告
- (void)closeNotice:(UIButton *)sender
{
    NSLog(@"tapp__");
    [noticeView removeFromSuperview];
}

#pragma mark -
- (void)setScollView
{
    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];
    imgArr = @[[UIImage imageNamed:@"home_faq"],
               [UIImage imageNamed:@"home2_1_bg"],
               [UIImage imageNamed:@"home2_3_bg"]
                             ];

    if (IS_IPHONE4) {
        scollView = [[WMBannerView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kTabBarHeight-64) withURLArrayOrImagesArray:imgArr];
        if (kDeviceVersion<7.0) {
            scollView = [[WMBannerView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-kTabBarHeight-64) withURLArrayOrImagesArray:imgArr];
        }
    }else {
       scollView = [[WMBannerView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-kTabBarHeight-64) withURLArrayOrImagesArray:imgArr];
    }
    scollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scollView];
    __weak typeof(self)__weakSelf = self;
    [scollView startWithTapActionBlock:^(NSInteger pageIndex) {
        
        HelpCenterViewController *VC;
        if (pageIndex==0) {
            if (IS_IPHONE4) {
                VC = [[HelpCenterViewController alloc]initWithNibName:@"HelpCenterViewController35" bundle:nil];
            }else if (IS_IPHONE5){
                VC = [[HelpCenterViewController alloc]initWithNibName:@"HelpCenterViewController" bundle:nil];
            }
            [__weakSelf.navigationController pushViewController:VC animated:YES];
        }else if (pageIndex==1){
            
        }else if (pageIndex==2){
            NoticeViewController *nvc;
            if (IS_IPHONE4) {
                nvc = [[NoticeViewController alloc]initWithNibName:@"NoticeViewController35" bundle:nil];
            }else{
                nvc = [[NoticeViewController alloc]initWithNibName:@"NoticeViewController" bundle:nil];
            }
            [__weakSelf.navigationController pushViewController:nvc animated:YES];
            
        }
    }];
   

    
    [self.view bringSubviewToFront:noticeView];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    noticeView = nil;
    scollView = nil;
    noticeBtn = nil;
    imgArr = nil;
}
@end
