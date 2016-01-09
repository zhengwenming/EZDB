//
//  ChartModel.h
//  EZDB
//
//  Created by wenming.zheng on 14-11-13.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "ChartView.h"
#import "ChartModel.h"
#import "TaldividendInfo.h"
#import "QueryGainsInfo.h"


@interface ChartView()
{
    UIImageView *imageView;
    UIImageView *messageImageView;
    UILabel *label;
}

@end

@implementation ChartView
@synthesize model = model,plotSpace=plotSpace;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    model = [[ChartModel alloc] init];
    _isFirstLoad = YES;
}

- (void)setWithType:(MyPensionType) type WithData:(NSMutableArray *) dataArr MaxMoney:(double ) maxMoney showMoney:(NSString *)titleMoney
{
    
    [self setShowData:dataArr withShowType:type];
    
    if ([dataArr count] < 1) {
        return;
    }
    switch (type) {
        case MyPensionTotal:{
            self.model.title = @"近一周累计收益走势";
            self.model.maxYValue = [NSString stringWithFormat:@"%.2f",maxMoney];
            self.model.midYValue = [NSString stringWithFormat:@"%.2f",maxMoney/2.0];
            self.model.titleMoney = @"";
        
            [self showValueWitChartModel];
        }
            break;
        case MyPensionGains:{
            self.model.title = @"万份收益走势";
            self.model.maxYValue = [NSString stringWithFormat:@"%.4f",maxMoney];
            self.model.midYValue = [NSString stringWithFormat:@"%.4f",maxMoney/2.0];
            self.model.titleMoney = [titleMoney stringByAppendingString:@"元"];
            [self showValueWitChartModel];
        }
            break;
        case MypensionYield:{
            self.model.title = @"七日年化走势";
            self.model.maxYValue = [NSString stringWithFormat:@"%.4f",maxMoney];
            self.model.midYValue = [NSString stringWithFormat:@"%.4f",maxMoney/2.0];
            self.model.titleMoney = [titleMoney stringByAppendingString:@"%"];
            [self showValueWitChartModel];
        }
            break;
    }
}

- (void)setShowData:(NSArray *)dataArr withShowType:(MyPensionType) type
{
    [self.model.dataArray removeAllObjects];
    NSInteger dataCount = [dataArr count];
    if (dataCount < 1) {
        [self clearView];
        return;
    }
    switch (type) {
        case MypensionYield:
        {
            QueryGainsInfo *queryGainsInfo = ((QueryGainsInfo *)[dataArr objectAtIndex:0]);
            self.model.endDay   = queryGainsInfo.currentdate;
            self.model.popMoney = queryGainsInfo.yield ;
            self.model.titleDay = queryGainsInfo.currentdate;
            self.model.minYValue = @"0.0000";

            if (dataCount >6) {
                for (int i = 6; i >=0 ; i--) {
                    QueryGainsInfo *queryGainsInfo = ((QueryGainsInfo *)[dataArr objectAtIndex:i]);
                    NSNumber *numberValue = [NSDecimalNumber numberWithDouble:[queryGainsInfo.yield doubleValue]];
                    [self.model.dataArray addObject:numberValue];
                }
                self.model.startDay =((QueryGainsInfo *)[dataArr objectAtIndex:6]).currentdate;
            }else{
                for (int i = 0; i< 7- dataCount; i++) {
                    NSNumber *numberValue = [NSDecimalNumber numberWithDouble:0.0];
                    [self.model.dataArray addObject:numberValue];
                }
                for (int i = dataCount-1; i >=0; i--) {
                    QueryGainsInfo *queryGainsInfo = (QueryGainsInfo *)[dataArr objectAtIndex:i];
                    NSNumber *numberValue = [NSDecimalNumber numberWithDouble:[queryGainsInfo.yield doubleValue]];
                    [self.model.dataArray addObject:numberValue];
                }
                NSDate *date = [self dateWithString:self.model.endDay format:@"yyyy-MM-dd"];
                date = [date dateByAddingTimeInterval: -6 * 24 *3600];
                self.model.startDay = [self stringWithFormat:@"yyyyMMdd" withDate:date];
            }

        }
            break;
        case MyPensionGains:
        {
            QueryGainsInfo *queryGainsInfo = ((QueryGainsInfo *)[dataArr objectAtIndex:0]);
            self.model.endDay   = queryGainsInfo.currentdate;
            self.model.popMoney = queryGainsInfo.fundincome;
            self.model.titleDay = queryGainsInfo.currentdate;
            self.model.minYValue = @"0.0000";
            if (dataCount >6) {
                for (int i = 6; i >=0 ; i--) {
                    QueryGainsInfo *queryGainsInfo = (QueryGainsInfo *)[dataArr objectAtIndex:i];
                    NSNumber *numberValue = [NSDecimalNumber numberWithDouble:[queryGainsInfo.fundincome doubleValue]];
                    [self.model.dataArray addObject:numberValue];
                }
                self.model.startDay =((QueryGainsInfo *)[dataArr objectAtIndex:6]).currentdate;
            }else{
                for (int i = 0; i< 7- dataCount; i++) {
                    NSNumber *numberValue = [NSDecimalNumber numberWithDouble:0.0];
                    [self.model.dataArray addObject:numberValue];
                }
                for (int i = dataCount-1; i >=0; i--) {
                    QueryGainsInfo *queryGainsInfo = (QueryGainsInfo *)[dataArr objectAtIndex:i];
                    NSNumber *numberValue = [NSDecimalNumber numberWithDouble:[queryGainsInfo.fundincome doubleValue]];
                    [self.model.dataArray addObject:numberValue];
                }
                NSDate *date = [self dateWithString:self.model.endDay format:@"yyyy-MM-dd"];
                date = [date dateByAddingTimeInterval: -6 * 24 *3600];
                self.model.startDay = [self stringWithFormat:@"yyyyMMdd" withDate:date];
            }
        }
            break;
        case MyPensionTotal:
        {
            TaldividendInfo *taldividedInfo = ((TaldividendInfo *)[dataArr objectAtIndex:0]);
            self.model.endDay   = taldividedInfo.divdate;
            self.model.popMoney = taldividedInfo.dividend;
            self.model.titleDay = taldividedInfo.divdate;
            self.model.minYValue = @"0.00";
            if (dataCount >6) {
                for (int i = 6; i >=0 ; i--) {
                    TaldividendInfo *taldividendInfo = (TaldividendInfo *)[dataArr objectAtIndex:i];
                    [self.model.dataArray addObject:taldividendInfo.dividend];
                }
                self.model.startDay =((TaldividendInfo *)[dataArr objectAtIndex:6]).divdate;
            }else{
                for (int i = 0; i< 7- dataCount; i++) {
                    NSNumber *numberValue = [NSDecimalNumber numberWithDouble:0.0];
                    [self.model.dataArray addObject:numberValue];
                }
                for (int i = dataCount-1; i >=0; i--) {
                    TaldividendInfo *taldividendInfo = (TaldividendInfo *)[dataArr objectAtIndex:i];
                    NSNumber *numberValue = [NSDecimalNumber numberWithDouble:[taldividendInfo.dividend doubleValue]];
                    [self.model.dataArray addObject:numberValue];
                }
                NSDate *date = [self dateWithString:self.model.endDay format:@"yyyy-MM-dd"];
                date = [date dateByAddingTimeInterval: -6 * 24 *3600];
                self.model.startDay = [self stringWithFormat:@"yyyyMMdd" withDate:date];
            }
        }
            break;
        default:
            break;
    }
    
    
}

- (void)clearView
{
    [self.titleLabel setText:nil];
    [self.startDayLabel setText:nil];
    [self.endDayLabel setText:nil];
    [self.titleDayLabel setText:nil];
    [self.titleMoneyLabel setText:nil];
    [self.titleLabel setText:nil];
    [self.maxtYLabel setText:nil];
    [self.middleYLabel setText:nil];
    [self.mimYLabel setText:nil];
    [self refreshView];
    [messageImageView setHidden:YES];
    [imageView setHidden:YES];
}


- (void)showValueWitChartModel
{
    [self.titleLabel setText:model.title];
    [self.startDayLabel setText:model.startDay];
    [self.endDayLabel setText:model.endDay];
    [self.titleDayLabel setText:model.titleDay];
    [self.titleMoneyLabel setText:model.titleMoney];
    [self.maxtYLabel setText:model.maxYValue];
    [self.mimYLabel setText:model.minYValue];
    [self.middleYLabel setText:model.midYValue];
    self.chartData = model.dataArray;
    
    if (_isFirstLoad) {
        [self showChart];
        [messageImageView setHidden:NO];
        [imageView setHidden:NO];
        _isFirstLoad = NO;
    }else{
        [self refreshView];
        [self showPopMoney];
        [messageImageView setHidden:NO];
        [imageView setHidden:NO];
    }
}

- (void)refreshView
{
    double maxValue  = [self.maxtYLabel.text doubleValue];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(maxValue)];
    [_plot reloadData];
}

- (void)showChart
{
    self.defaultNumberFormat = [[NSNumberFormatter alloc] init];
    [self.defaultNumberFormat setMaximumFractionDigits:0];
    
    self.defaultLayerHostingView=[(CPTGraphHostingView *)[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 235, 90)];
    self.defaultLayerHostingView.collapsesLayers = NO;
    [_chartView addSubview:self.defaultLayerHostingView];
    
    self.defaultLayerHostingView.hostedGraph = [(CPTXYGraph *)[CPTXYGraph alloc] init];
    self.graph = self.defaultLayerHostingView.hostedGraph;
    self.defaultLayerHostingView.hostedGraph.frame = CGRectMake(0, 0, 235, 90);
    
    self.graph.paddingLeft = 0.0f ;
    self.graph.paddingRight = 0.0f ;
    self.graph.paddingTop = 0.0f ;
    self.graph.paddingBottom = 0.0f ;
    
    self.graph.plotAreaFrame.paddingLeft = 0.0 ;
    self.graph.plotAreaFrame.paddingTop = 0.0 ;
    self.graph.plotAreaFrame.paddingRight = 0.0 ;
    self.graph.plotAreaFrame.paddingBottom = 0.0 ;
    
    plotSpace = (CPTXYPlotSpace *) self.graph.defaultPlotSpace;
    
    CPTMutableLineStyle *lineStyle = [[CPTMutableLineStyle alloc] init];
    lineStyle.lineWidth              = 2.0;
    lineStyle.lineColor              = [CPTColor colorWithComponentRed:126.0/255.0 green:206.0/255.0 blue:244.0/255.0 alpha:1];
    _plot = [[CPTScatterPlot alloc] init];
    _plot.identifier = @"coreplot simple";
    _plot.dataLineStyle = lineStyle;
    _plot.dataSource = self;
    [self.graph addPlot:_plot];
    
    CPTColor *areaColor       = [CPTColor colorWithComponentRed:111.0/255.0 green:101.0/255.0 blue:171.0/255.0 alpha:1];
    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor colorWithComponentRed:191.0/255.0 green:132.0/255.0 blue:159.0/255.0 alpha:0.5]];
    areaGradient.angle = -90.0f;
    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
    _plot.areaFill      = areaGradientFill;
    _plot.areaBaseValue = CPTDecimalFromDouble(0.0);
    NSLog(@"------------>%@",self.maxtYLabel.text);
    double maxValue  = [self.maxtYLabel.text doubleValue]>10000?10000:[self.maxtYLabel.text doubleValue];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromDouble(maxValue)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromDouble(6.0f)];
   
    [self performSelector:@selector(showPopMoney) withObject:nil afterDelay:0.1];
    
}

-(void)showPopMoney
{
    
    CGPoint point = [_plot plotAreaPointOfVisiblePointAtIndex:6];
    UIImage *image = [UIImage imageNamed:@"QueryPoint"];
    if (!imageView) {
        imageView  =[[UIImageView alloc] initWithImage:image];
        [_chartView addSubview:imageView];
    }
    imageView.frame = CGRectMake(point.x -4 ,_chartView.frame.size.height - point.y -4, 8, 8);
    
    CGPoint imageViewPoint = imageView.frame.origin;

    BOOL isDown = point.y + 34 >=_chartView.frame.size.height;
    NSString *imageName = (isDown)?@"MessageDown":@"MessageUp";
    UIImage *messageImage = [UIImage imageNamed:imageName];
    if (!messageImageView) {
        messageImageView  = [[UIImageView alloc] initWithImage:messageImage];
        [_chartView addSubview:messageImageView];
    }else{
        messageImageView.image = [UIImage imageNamed:imageName];
    }
    
    CGRect labelFrame = CGRectZero;
    
    if (!isDown)
    {
        messageImageView.frame = CGRectMake(imageViewPoint.x - 40.0f, imageViewPoint.y - 26.0f, 51.0f, 29.0f);
        labelFrame = CGRectMake(0.0f , 0.0f, messageImageView.frame.size.width, 20.0f);
    }else{
        messageImageView.frame = CGRectMake(imageViewPoint.x - 40.0f, imageViewPoint.y + 6.0f, 51.0f, 29.0f);
        labelFrame = CGRectMake(0.0f, 8.0f, messageImageView.frame.size.width, 20.0f);
    }
    
    if (!label) {
        label = [[UILabel alloc] initWithFrame:labelFrame];
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor whiteColor]];
        [messageImageView addSubview:label];
    }else{
        label.frame = labelFrame;
    }
    [label setText:self.model.popMoney];
    
   
}

#pragma mark - Plot Data Source Methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return self.chartData.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    
    if ([self.chartData count]>0) {
        NSNumber *num = nil;
        switch (fieldEnum) { //x轴
            case CPTScatterPlotFieldX: {
                num = [NSDecimalNumber numberWithInt:index];
                break;
            }
            case CPTScatterPlotFieldY:{ //y轴
                if ([plot.identifier isEqual:@"coreplot simple"]) {
                    num= [self.chartData objectAtIndex:index];
                }
                break;
            }
        }
        return num;
    }
    return 0;
}

- (id)dateWithString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=format;
    return [dateFormatter dateFromString:string];
}

- (NSString *)stringWithFormat:(NSString *)format withDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=format;
    return [dateFormatter stringFromDate:date];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
