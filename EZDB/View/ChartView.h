//
//  ChartModel.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-13.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//
#import "CorePlot-CocoaTouch.h"
#import "DetailViewController.h"

@class ChartModel;
@class CPTGraphHostingView;

@interface ChartView : UIView<CPTPlotDataSource,CPTPlotSpaceDelegate>

/** 开始日期 */
@property (nonatomic, weak) IBOutlet UILabel *startDayLabel;

/** 结束日期 */
@property (nonatomic, weak) IBOutlet UILabel *endDayLabel;

/** 标题 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

/** 标题金额 */
@property (nonatomic, weak) IBOutlet UILabel *titleMoneyLabel;

/** 标题日期 */
@property (nonatomic, weak) IBOutlet UILabel *titleDayLabel;

/** Y轴最大值 */
@property (nonatomic, weak) IBOutlet UILabel *maxtYLabel;

/** Y轴最小值 */
@property (nonatomic, weak) IBOutlet UILabel *mimYLabel;

/** Y轴中间值 */
@property (nonatomic, weak) IBOutlet UILabel *middleYLabel;

/** 走势图 */
@property (nonatomic, weak) IBOutlet UIView *chartView;

/** 是否第一次读取页面 */
@property (nonatomic,assign) BOOL isFirstLoad;

@property (nonatomic, strong)  ChartModel *model;
/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *chartData;

/** 数字格式 */
@property (nonatomic, strong) NSNumberFormatter *defaultNumberFormat;

/** 图表 */
@property (nonatomic,strong) CPTGraphHostingView *defaultLayerHostingView;

/** 折线点 */
@property (nonatomic,strong)CPTScatterPlot *plot;

@property (nonatomic,strong)CPTXYPlotSpace *plotSpace;
/** 画布 */
@property (nonatomic) CPTGraph *graph;

- (void)setWithType:(MyPensionType) type WithData:(NSMutableArray *) dataArr MaxMoney:(double ) maxMoney showMoney:(NSString *)titleMoney;

- (void)showValueWitChartModel;

/** 清除view文字 */
- (void)clearView;

@end
