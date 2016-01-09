//
//  DetailViewController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-28.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "DetailViewController.h"
#import "FundDetailDataRequest.h"
#import "FundDetailModel.h"
#import "BorderSetBtn.h"
#import "FundInfoCell.h"
#import "FundHeadCell.h"
#import "ChartView.h"
#import "PurchaseViewController.h"
#import "LoginViewController.h"
#import "QueryIncomeDetailRequest.h"



@interface DetailViewController () <UITableViewDataSource,UITableViewDelegate,PopViewContrlDelegate>
{
    NSMutableArray      *fArray;
    NSMutableArray      *tArray;
    NSMutableArray      *thArray;
    NSMutableArray      *foArray;
    NSMutableArray      *dataArray;
    NSMutableArray      *sectionArray;
    NSMutableArray      *stateArray;
    NSMutableArray      *dataSource;
    
    UIView              *_bottomView;
    UIImageView         *_imgView;
    ChartView           *_chartView;

    
}
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
            fArray = [NSMutableArray array];
            tArray = [NSMutableArray array];
           thArray = [NSMutableArray array];
           foArray = [NSMutableArray array];
        stateArray = [NSMutableArray array];
        dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUI];
    [self setArray];
//    [self sendRequest];
//    [self getFundIncome];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
}

- (void)setArray
{
    sectionArray  = [NSMutableArray arrayWithObjects:@"基金名称：",
                                                     @"基金介绍",
                                                     @"基金公司介绍",
                                                     @"取出规则",nil];
    dataArray = [NSMutableArray arrayWithObjects:fArray,
                                                 tArray,
                                                 thArray,
                                                 foArray,nil];
    
    for (int i=0; i<dataArray.count; i++){
        if (i==0) {
            [stateArray addObject:@"1"];
        }else
            //所有的分区都是闭合
            [stateArray addObject:@"0"];
    }
}
- (void)setUI
{
    BorderSetBtn *buyBtn = [BorderSetBtn buttonWithType:UIButtonTypeCustom];
    
    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
    [self setNavBarWithtitle:@"基金详情" superView:self.view backImg:kNavBackImgName homeImg:nil];

    if (kDeviceVersion>=7.0) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-60) style:UITableViewStyleGrouped];
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
        [buyBtn setFrame:CGRectMake(15, 10, _bottomView.frame.size.width-15*2, _bottomView.frame.size.height-10*2)];
    }else{
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64-20, kScreenWidth, kScreenHeight-70-60) style:UITableViewStyleGrouped];
        [_tableView setBackgroundColor:kViewBackGroudColor];
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-60-20, kScreenWidth, 60)];
        [buyBtn setFrame:CGRectMake(15, 8, _bottomView.frame.size.width-15*2, _bottomView.frame.size.height-10*2)];
    }
    [buyBtn setBackgroundColor:kBtnBackGroudColor];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setBackgroundView:nil];
    [_tableView registerNib:[UINib nibWithNibName:@"FundInfoCell" bundle:nil] forCellReuseIdentifier:@"fundInfoCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"FundHeadCell" bundle:nil] forCellReuseIdentifier:@"fundHeadCell"];
    
    [_bottomView addSubview:buyBtn];
    [self.view addSubview:_bottomView];
    [self.view addSubview:self.navView];
    [self.view addSubview:_tableView];
    [self.view setBackgroundColor:[UIColor clearColor]];

}
#pragma mark - 点击立即购买
- (void)buyBtnAction:(UIButton *)button
{

    
        PurchaseViewController *purVC = [[PurchaseViewController alloc]initWithNibName:@"PurchaseViewController" bundle:nil];//
        purVC.fundCode = self.fundCode;
        [self.navigationController pushViewController:purVC animated:YES];

}
#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index
{
    switch (index) {
        case 1:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        return 1;
    }else{
        //如果是闭合，返回0,section 0为始终展开
        if (section==0) {
            return 1;
        }else
            return 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 30)];

    [button setBackgroundColor:kViewBackGroudColor];
    [button setFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    [button setTag:section+1];
    [button.layer setBorderWidth:0.3];
    [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];

    if (section==0) {
        [label setFrame:CGRectMake(20, 10, 100, 30)];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x+label.frame.size.width-20, 10, 200, 30)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:16]];
        [nameLabel setText:self.fundName];
        [button addSubview:nameLabel];

    }else{
//        [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 22, 10, 6)];
        if ([stateArray[section] isEqualToString:@"0"]) {
            [_imgView setImage:[UIImage imageNamed:@"ico_listdown"]];
        }else if ([stateArray[section] isEqualToString:@"1"]) {
            [_imgView setImage:[UIImage imageNamed:@"ico_listup"]];
        }
        [button addSubview:_imgView];
    }
    
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setText:sectionArray[section]];
    [button addSubview:label];

    return button;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef Sentence
    
#endif
    if (indexPath.section==0) {
        FundHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fundHeadCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        /*
         **曲线图设置
         */
//        if (dataSource.count>0) {
//            cell.model = dataSource[indexPath.row];
//        }
        [cell.daysBtn setTag:indexPath.row+4];
        [cell.daysBtn addTarget:self action:@selector(profitType:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.oneMonth setTag:indexPath.row+5];
        [cell.oneMonth addTarget:self action:@selector(profitType:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.twoMonth setTag:indexPath.row+6];
        [cell.twoMonth addTarget:self action:@selector(profitType:) forControlEvents:UIControlEventTouchUpInside];
        
        //7日年化
        [cell.proRateBtn setTag:indexPath.row+2];
        [cell.proRateBtn addTarget:self action:@selector(profitType:) forControlEvents:UIControlEventTouchUpInside];
        //万份收益
        [cell.profitBtn setTag:indexPath.row+3];
        [cell.profitBtn addTarget:self action:@selector(profitType:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableString *zero = [NSMutableString string];
        if (fArray.count>0) {
            FundDetailModel *model = fArray[indexPath.row];
            if (model.yield.length>6) {
                model.yield = [model.yield substringWithRange:NSMakeRange(0, 6)];
            }else if(model.yield.length<6){
                for (int i=0; i<6-model.yield.length; i++) {
                    zero = (NSMutableString *)[zero stringByAppendingString:@"0"];
                    model.yield = [model.yield stringByAppendingString:zero];
                }
            }
            if (model.fundIncome.length>6) {
                model.fundIncome = [model.fundIncome substringWithRange:NSMakeRange(0, 6)];
            }else if(model.fundIncome.length<6){
                for (int i=0; i<6-model.fundIncome.length; i++) {
                    zero = (NSMutableString *)[zero stringByAppendingString:@"0"];
                    model.fundIncome = [model.fundIncome stringByAppendingString:zero];
                }
            }
            [cell.sProRate setText:model.yield];
            [cell.tProfit setText:model.fundIncome];
        }
        return cell;
        
    }else if (indexPath.section==1){
        FundInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fundInfoCell"];
        if (fArray.count>0){

            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.simName setText:@"hh"];
            [cell.manName setText:@"hh"];
            [cell.manCode setText:@"hh"];
            [cell.fullName setText:@"hh"];
            [cell.proState setText:@"hh"];
            [cell.fundCode setText:@"hh"];
            [cell.chargeSty setText:@"hh"];
            [cell.regFirmName setText:@"hh"];
            [cell.regFirmCode setText:@"hh"];
        }
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.contentView setBackgroundColor:kViewBackGroudColor];
            [cell setBackgroundView:[[UIView alloc] initWithFrame:CGRectZero]];
        }
        return cell;
    }
}

#pragma mark - Cell_Height_Setting
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0){
        return 300.0f;
    }else if(indexPath.section==1){
        return 380.0f;
    }else{
        return 300.0f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kCloseZero;
}




#pragma mark - profitType
- (void)profitType:(UIButton *)sender
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"btnSelectNotice" object:sender];
    switch (sender.tag) {
        case 2:{//7日年化
        }
            break;
        case 3:{//万份收益
        }
            break;
        case 4:{//7天
            NSLog(@"7天");
        }
            break;
        case 5:{//1个月
            NSLog(@"1个月");
            }
            break;
        case 6:{//2个月
            NSLog(@"2个月");
        }
            break;
        default:
            break;
    }
    [_tableView reloadData];
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
