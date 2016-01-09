//
//  ProfitListController.m
//  EZDB
//
//  Created by wenming.zheng on 14-11-12.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ProfitListController.h"
#import "ProfitCell.h"
#import "PickerView.h"
#import "QueryIncomeDetailRequest.h"
#import "ProfitModel.h"


#define kLeftBtnTag 1
#define kRightBtnTag 2

@interface ProfitListController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *productArray;
    NSMutableArray *monthArray;
    UITableView *profitTableView;
    BOOL leftOpen;
    BOOL rightOpen;
    PickerView *pickerView1;
    PickerView *pickerView2;
    NSMutableArray *dataSource;
}

@end

@implementation ProfitListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (index==2){
        
    }
}
-(void)IamSure:(UIButton *)sender{
//    [self removePicker:pickerView1];
//    [self removePicker:pickerView2];
    
    
//    [UIView animateWithDuration:1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
//        pickerView.frame = CGRectMake(0, kScreenHeight, kScreenHeight, 400);
//        
//    } completion:^(BOOL finished) {
//        [pickerView removeFromSuperview];
//    }];
    
    profitTableView.userInteractionEnabled = YES;

    if (sender.tag==1) {
        [pickerView1 removeFromSuperview];

        
//        [UIView animateWithDuration:1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
//            pickerView1.frame = CGRectMake(0, kScreenHeight, kScreenHeight, 400);
//            
//        } completion:^(BOOL finished) {
//            [pickerView1 removeFromSuperview];
//        }];

        
        //product
        NSString *title = [productArray objectAtIndex:[pickerView1.picker selectedRowInComponent:0]];
        [MSUtil showHudMessage:title hideAfterDelay:1.5 uiview:self.view];
    }
    if (sender.tag==2) {
        [pickerView2 removeFromSuperview];

//        [UIView animateWithDuration:1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
//            pickerView2.frame = CGRectMake(0, kScreenHeight, kScreenHeight, 400);
//            
//        } completion:^(BOOL finished) {
//            [pickerView2 removeFromSuperview];
//        }];

        
        //month
        NSString *title = [monthArray objectAtIndex:[pickerView2.picker selectedRowInComponent:0]];
        [MSUtil showHudMessage:title hideAfterDelay:1.5 uiview:self.view];
    }
    

    if (rightOpen) {
        rightOpen = !rightOpen;
        
    }
   
    if (leftOpen) {
        leftOpen = !leftOpen;
        
    }
   

    
}
-(void)BtnAction:(UIButton *)sender{
    //left
    if (sender.tag==100) {
        //enable==no
        
    }
    if (sender.tag==101) {
        [pickerView1 removeFromSuperview];
        [self.view addSubview:pickerView2];
        profitTableView.userInteractionEnabled = NO;

    }
    
    if (sender.tag==200) {
        [pickerView2 removeFromSuperview];
        [self.view addSubview:pickerView1];
        profitTableView.userInteractionEnabled = NO;

    }
    
    //right
    
    if (sender.tag==201) {
        //enable==no
    }
    
}
-(void)changePicker:(UIButton *)sender{
    if (sender.tag==1)
    {
        [pickerView2 removeFromSuperview];
        [self.view addSubview:pickerView1];
        [self.view bringSubviewToFront:pickerView1];
        profitTableView.userInteractionEnabled = NO;


        
        if (leftOpen)
        {
            [pickerView1 removeFromSuperview];
            profitTableView.userInteractionEnabled = YES;

            
        }
        else
        {
            if (rightOpen)
            {
                [pickerView2 removeFromSuperview];
                [self.view addSubview:pickerView1];
                [self.view bringSubviewToFront:pickerView1];
                profitTableView.userInteractionEnabled = NO;


//                [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
                rightOpen = !rightOpen;
            }
            else
            {
                //both close
                [self.view addSubview:pickerView1];
                [self.view bringSubviewToFront:pickerView1];
                profitTableView.userInteractionEnabled = NO;

//                [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
            }
        }
        leftOpen = !leftOpen;
        
        
    }
    else if (sender.tag==2)
    {
        [pickerView1 removeFromSuperview];
        [self.view addSubview:pickerView2];
        [self.view bringSubviewToFront:pickerView2];
        profitTableView.userInteractionEnabled = NO;

//        [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
        if (rightOpen)
        {
            [pickerView2 removeFromSuperview];
            profitTableView.userInteractionEnabled = YES;

            
        }
        else
        {
            if (leftOpen)
            {
                [pickerView1 removeFromSuperview];
                [self.view addSubview:pickerView2];
                [self.view bringSubviewToFront:pickerView2];
                profitTableView.userInteractionEnabled = NO;

//                [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
                leftOpen = !leftOpen;
                
            }
            else
            {
                [self.view addSubview:pickerView2];
                [self.view bringSubviewToFront:pickerView2];
                profitTableView.userInteractionEnabled = NO;


//[[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
            }
        }
        rightOpen = !rightOpen;
        
    }
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//    [[EZDBAppDelegate appDelegate].tabBarCtl hideMyTabBar];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];
//
//}
#pragma mark 
#pragma  mark animations

-(void)removePicker:(UIView *)pickerView{
    [UIView animateWithDuration:1 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        pickerView.frame = CGRectMake(0, kScreenHeight, kScreenHeight, 400);

    } completion:^(BOOL finished) {
        [pickerView removeFromSuperview];
    }];
}
-(void)addPicker:(UIView *)pickerView{
    
}

- (void)viewDidLoad
{
   
    dataSource = [NSMutableArray array];
    productArray= [NSMutableArray arrayWithObjects:@"广发基金",@"华夏基金", nil];
    monthArray =[NSMutableArray arrayWithObjects:@"2014年1月",@"2014年2月",@"2014年3月",@"2014年4月",@"2014年5月",@"2014年6月",@"2014年7月",@"2014年8月",@"2014年9月",@"2014年10月",@"2014年11月",@"2014年12月", nil];

    [super viewDidLoad];
    [self.productBtn addTarget:self action:@selector(changePicker:) forControlEvents:UIControlEventTouchUpInside];
    self.productBtn.tag = 1;
    [self.monthBtn addTarget:self action:@selector(changePicker:) forControlEvents:UIControlEventTouchUpInside];
    self.monthBtn.tag = 2;
    [self initPicker];
    
    //profitTableView
    
    profitTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 34+10, kScreenWidth, kScreenHeight-34-64-46) style:UITableViewStylePlain];
    profitTableView.dataSource = self;
    profitTableView.delegate =self;
    profitTableView.rowHeight = 100;
    profitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [profitTableView registerNib:[UINib nibWithNibName:@"ProfitCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:profitTableView];

//    [self loadIncomeDetail];
}

-(void)initPicker{
    if (IS_IPHONE4) {

        pickerView1 = [[PickerView alloc]initWithFrame:CGRectMake(0, 210-30, self.view.frame.size.width, 400)];

    }else if (IS_IPHONE5){

        pickerView1 = [[PickerView alloc]initWithFrame:CGRectMake(0, 295-30, self.view.frame.size.width, 400)];

    }
    pickerView1.sureBtn.tag = 1;
    [pickerView1.sureBtn addTarget:self action:@selector(IamSure:) forControlEvents:UIControlEventTouchUpInside];
    [pickerView1.leftBtn setImage:[UIImage imageNamed:@"ico_back_white.png"] forState:UIControlStateNormal];
    [pickerView1.leftBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    pickerView1.leftBtn.tag = 100;
    pickerView1.identifer = @"pickerView1";
    pickerView1.titleLabel.text = self.productBtn.titleLabel.text;
    [pickerView1.rightBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    pickerView1.rightBtn.tag = 101;
    pickerView1.picker.backgroundColor = [UIColor lightGrayColor];
    pickerView1.picker.dataSource = self;
    pickerView1.picker.delegate = self;
    
    if (IS_IPHONE4) {
        pickerView2 = [[PickerView alloc]initWithFrame:CGRectMake(0, 210-30, self.view.frame.size.width, 400)];
   
    }
    else if (IS_IPHONE5){
        pickerView2 = [[PickerView alloc]initWithFrame:CGRectMake(0, 295-30, self.view.frame.size.width, 400)];

    }
    pickerView2.sureBtn.tag = 2;
    [pickerView2.sureBtn addTarget:self action:@selector(IamSure:) forControlEvents:UIControlEventTouchUpInside];
    [pickerView2.leftBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    pickerView2.leftBtn.tag = 200;
    pickerView2.identifer = @"pickerView2";
    pickerView2.titleLabel.text = self.monthBtn.titleLabel.text;
    [pickerView2.rightBtn addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickerView2.rightBtn setImage:[UIImage imageNamed:@"ico_next_white.png"] forState:UIControlStateNormal];

    pickerView2.rightBtn.tag = 201;
    pickerView2.picker.backgroundColor = [UIColor lightGrayColor];
    pickerView2.picker.dataSource = self;
    pickerView2.picker.delegate = self;
    
    
}


#pragma mark pickerview delegate

/* return cor of pickerview*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==pickerView1.picker) {
        return [productArray count];
        
    }
    else{
        return [monthArray count];
        
    }
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView==pickerView1.picker) {
        return [productArray objectAtIndex:row];
        
    }else{
        return [monthArray objectAtIndex:row];
        
    }
}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // NSLog(@"font %@ is selected.",row);
    if (pickerView==pickerView1.picker) {
        NSString *name=[productArray objectAtIndex:row];
        NSLog(@"%@",name);
    }else{
        NSString *name=[monthArray objectAtIndex:row];
        NSLog(@"%@",name);
    }
    
}

#pragma mark tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return dataSource.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProfitCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (cell==nil) {
        cell = [[ProfitCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }

    if (indexPath.row%2==1) {
        cell.backgroundColor = kViewBackGroudColor;
    }
    else if (indexPath.row%2==0){
        cell.backgroundColor = [UIColor clearColor];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark 
#pragma mark touch event
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end