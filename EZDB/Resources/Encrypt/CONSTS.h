//
//  CONSTS.h
//  Hupan
//
//  Copyright 2010 iTotem Studio. All rights reserved.
//

#define GENERATE_DUMMPY_DATA 1
#define REQUEST_DOMAIN @"http://22.189.6.121:11080/appserver/" // default env

//text
#define TEXT_LOAD_MORE_NORMAL_STATE @"向上拉动加载更多..."
#define TEXT_LOAD_MORE_LOADING_STATE @"更多数据加载中..."

#define IIBNEWS_ANONYMOUS_COMMENT @"IIBNEWS_ANONYMOUS_COMMENT"

#define MACRO_RANK_ARRAY @"MACRO_RANK_ARRAY"
#define SECRET_KEY                  @"mjk"
//other consts
typedef enum{
	kTagWindowIndicatorView = 501,
	kTagWindowIndicator,
} WindowSubViewTag;

typedef enum{
    kTagHintView = 101
} HintViewTag;

typedef enum
{
    SettingTypeLabel = 201,
    SettingTypeSwitch,
    SettingTypeSlider,
    SettingTypeImage,
    SettingTypeArrow,
}SettingType;

typedef enum
{
    BackGroundTypeSwitch = 301,
    BackGroundTypeImage,
    
}BackGroundType;

typedef enum
{
    LockScreenTypeImageView = 501,
    LockScreenTypeSwitch,
    LockScreenTypeLabel,
    
}LockScreenType;

// create by hp @2013-8-12

#pragma mark - notification name

#define IBNEWS_CHANNEL_SELECTED_NOTIF @"IBNEWS_CHANNEL_SELECTED_NOTIF"
#define IBNEWS_NEWS_SELECTED_NOTIF @"IBNEWS_NEWS_SELECTED_NOTIF"
#define IBNEWS_SHOWALLREPLYS_NOTIF @"IBNEWS_SHOWALLREPLYS_NOTIF"
#define IBNEWS_SUBSCRIBE_NEWS_NOTIF @"IBNEWS_SUBSCRIBE_NEWS_NOTIF"
#define IBNEWS_OPEN_LOGIN_PAGE_NOTIF @"IBNEWS_OPEN_LOGIN_PAGE_NOTIF"
#pragma mark - key chain parameters

#define LOGIN_KEYCHAIN_USER_NAME @"Username"
#define LOGIN_KEYCHAIN_PASSWORD @"Password"
#define LOGIN_KEYCHAIN_LOGINTIME @"LoginTime"
#define LOGIN_KEYCHAIN_SERVICE_NAME @"LOGIN_DEMO_SERVICE_NAME"

#pragma mark - key chain name

#define RSA_PUBLIC_FILE_NAME @"RSA_PUBLIC_FILE.PEM"
#define LOGIN_DEMO_USER_NAME @"Username"
#define LOGIN_DEMO_PASSWORD @"Password"
#define LOGIN_DEMO_LOGINTIME @"LoginTime"

#define LOGIN_DEMO_ORGID_NAME @"OrgId"
#define LOGIN_DEMO_REALNAME_NAME @"RealName"
#define LOGIN_DEMO_USERID_NAME @"Userid"

#define LOGIN_DEMO_RSAFILE_CONTENT @"RSA_PUBLIC_FILE"
#define LOGIN_DEMO_SERVICE_NAME @"LOGIN_DEMO_SERVICE_NAME"

#define LOGIN_ADDRESS_FLOGIN @"LOGIN_ADDRESS_FLOGIN"
#define LOGIN_ADDRESS_GET_RANDOM_NUMBER @"LOGIN_ADDRESS_GET_RANDOM_NUMBER"
#define LOGIN_ADDRESS_VERIFY @"LOGIN_ADDRESS_VERIFY"
#define LOGIN_ADDRESS_RELOGIN @"LOGIN_ADDRESS_RELOGIN"
#define LOGIN_ADDRESS_LAN @"LOGIN_ADDRESS_LAN"
#define PUSHVIEWTONEXTVIEW @"pushViewToNextView"

#pragma mark - system instance

#define IB_REQUEST_PARAM_KEY @"parameter"
#define IB_NEWSLIST_PAGESIZE 20
#define IBNEWS_SUBSCRIBE_CHANNEL_PAGE_SIZE 8
#define STATUS_BAR_HEIGHT 20

#pragma mark - sepcial mark for html page

#define IBNEWS_DEFAULT_JS_MARK @"${JSDEFAULTPATH}"
#define IBNEWS_DEFAULT_CSS_MARK @"${CSSDEFAULTPATH}"
#define IBNEWS_DEFAUTL_PIC_MARK @"${PICDEFAULTPATH}"

#pragma mark - system server address and instances

#define IBNEWS_REQUEST_CLASSNAME @"mci.News"
#define IBNEWS_REQUEST_NEWSLIST_METHODNAME @"getNewsList"
#define IBNEWS_REQUEST_NEWSDETAIL_METHODNAME @"getNewsDetails"

#define IBNEWS_COMMENT_REQUEST_CLASSNAME @"mci.Content"
#define IBNEWS_REQUEST_COMMENT_METHODNAME @"getContentList"
#define IBNEWS_POST_COMMENT_METHODNAME @"addContent"


#define IBNEWS_CONTACTS_REQUEST_CLASSNAME @"mci.Contacts"
#define IBNEWS_CONTACTS_REQUEST_METHODNAME @"getContacts"

#pragma mark - request cancel key

#define IBNEWS_REQUEST_CANCEL_KEY @"IBNEWS_REQUEST_CANCEL_KEY"
#define IBNEWS_NEWSLIST_APPENDIX_REQUEST_CANCEL_KEY @"IBNEWS_NEWSLIST_APPENDIX_REQUEST_CANCEL_KEY"
#define IBNEWS_NEWSDETAIL_REQUEST_CANCEL_KEY @"IBNEWS_NEWSDETAIL_REQUEST_CANCEL_KEY"

#define HELPVIEW @"helpView"
#define SETTING @"setting"
#define SETTIMG1 @"setting1"

#define BACK_GROUND_SWITCHVALUE @"back_ground_switchValue"
#define SUBSCRIPT_NOTIFICATION @"SUBSCRIPT_NOTIFICATION"
#define PERSON_CENTER @"PERSON_CENTER"
#define BACKGROUNDCELL @"BackGroundCell"
#define SUREBACKGROUNDIMAGE @"SureBackGroundImage"
#define IMAGE @"image"

#define BEGINANIMATING @"beginAnimating"
#define STOPANIMATING @"stopAnimating"

#define GESTURE_LOCK_CHAIN @"GESTURE_LOCK_CHAIN"
#define DEVICE_TOKEN @"DEVICE_TOKEN"
#define SCREEN_LIGHT @"SCREEN_LIGHT"

#define GESTUREPASSWORD @"gesturePassword"
#define CHANGEMAINVIEWBACKIMAGE @"changeMainViewBackImage"
#define CANCLE_SUBJECT_GETSUBNEWS_REQUEST @"CANCLE_SUBJECT_GETSUBNEWS_REQUEST"
#define SUB_NEWS_ARRAY  @"SUB_NEWS_ARRAY"
#define SUB_QUOTA_ARRAY  @"SUB_QUOTA_ARRAY"


#pragma mark - 
#define SUB_ORDERED_NEWS @"SUB_ORDERED_NEWS"
#define DATA_CACHE_MANAGE [DataCacheManager sharedManager]
#define OPEN_LOGINVIEWCONTROLLER @"openLoginViewController"
#define OPEN_QUOTASEARCH @"OPEN_QUOTASEARCH"
#define OPEN_QUOTARANK_NOTIF @"OPEN_QUOTARANK_NOTIF"
#define OPEN_NEWSRANK_NOTIF @"OPEN_NEWSRANK_NOTIF"
#define OPEN_MY_QUOTA_NOTIF @"OPEN_MY_QUOTA_NOTIF"

#ifndef ChartLib_Consts_h
#define ChartLib_Consts_h

#define DEFAULT_PADDING_AXIS_X      60.0
#define DEFAULT_PADDING_AXIS_Y      100.0
#define DEFAULT_PADDING_AXIS        30.0
#define DEFAULT_LINE_WIDTH          2.0
#define DEFAULT_LINE_JOIN_WIDTH     2.0
#define DEFAULT_SECTION_SPACING     4.0
#define DEFAULT_PIE_INNER_RADIUS    70.0
#define DEFAULT_PIE_RADIUS          100.0
#define DEFAULT_AXIS_LINE_WIDTH     1.0
#define DEFAULT_RADIUS              10.0
#define DEFAULT_STROKE_WIDTH_BAR    1.0
#define DEFAULT_MINIMUM_BAR_SPACING 4.0
#define DEFAULT_MINIMUM_BAR_WIDTH   8.0
#define DEFAULT_BAR_GROUP_SPACING   1.0
#define DEFAULT_LEGEND_UNIT_WIDTH   100
#define DEFAULT_LEGEND_UNIT_HEIGHT  40

#define KEY_PIE_SECTION             @"KEY_PIE_SECTION"
#define KEY_ORIGIN_VALUE            @"KEY_ORIGIN_VALUE"
#define KEY_NEW_VALUE               @"KEY_NEW_VALUE"
#define KEY_VIEW                    @"KEY_VIEW"
#define KEY_CURRENT_VALUE           @"KEY_CURRENT_VALUE"
#define KEY_ITERTATION              @"KEY_ITERTATION"
#define KEY_DURATION                @"KEY_DURATION"
#define KEY_DATA                    @"KEY_DATA"
#define KEY_COMPLETION_BLOCK        @"KEY_COMPLETION_BLOCK"
#define KEY_BAR                     @"KEY_BAR"


#define kISSChartAnimationDuration                 0.2
#define kISSChartFirstAnimationDuration            1.0
#define kISSChartAnimationFPS                      60.0

#define NUMBER_OF_COLOR_IN_CHARTLIB 14

#define ISSChart_Hint_Tag_Base 1000
#define DEFAULT_HINT_LABEL_TOP_MARGIN 3
#define DEFAULT_HINT_LABEL_LEFT_MARGIN 10
#define DEFAULT_HINT_LABEL_BOTTOM_MARGIN 6
#define DEFAULT_HINT_LABEL_HEIGHT 30

typedef enum {
    ISSChartCyanColor = 0,
    ISSChartMagentaColor,
    ISSChartGreenColor,
    ISSChartRedColor,
    ISSChartBlueColor,
    ISSChartYellowColor,
    ISSChartOrangeColor,
    ISSChartPurpleColor,
    ISSChartDrakGrayColor,
    ISSChartLightGrayColor,
    ISSChartGrayColor,
    ISSChartBrownColor,
    ISSChartBlackColor,
    ISSChartWhiteColor,
}ISSChartColor;

typedef enum {
    ISSChartLegendDirectionNone,
    ISSChartLegendDirectionHorizontal,
    ISSChartLegendDirectionVertical,
}ISSChartLegendDirection;

typedef enum {
    ISSChartLegendPositionNone,
    ISSChartLegendPositionRight,
    ISSChartLegendPositionBottom,
    ISSChartLegendPositionTop,
    ISSChartLegendPositionLeft,
}ISSChartLegendPosition;

typedef enum {
    ISSChartLinePointJoinNone,
    ISSChartLinePointJoinRectangle,
    ISSChartLinePointJoinSolidRectangle,
    ISSChartLinePointJoinTriangle,
    ISSChartLinePointJoinSolidTriangle,
    ISSChartLinePointJoinCircle,
    ISSChartLinePointJoinSolidCircle
}ISSChartLinePointJoinStype;

typedef enum ISSChartAxisType {
    ISSChartAxisTypeValue,
    ISSChartAxisTypePercentage
}ISSChartAxisType;

typedef enum {
    ISSChartTypeNone,
    ISSChartTypePie,
    ISSChartTypeLine,
    ISSChartTypeHistogram,
    ISSChartTypeHistogramLine,
    ISSChartTypeWaterfall,
    ISSChartTypeHistogramOverlap,
    ISSChartTypeHistogramOverlapLine,
}ISSChartType;

typedef enum {
    ISSChartFillNone,
    ISSChartFillPlain,
    ISSChartFillGradient
}ISSChartFillStyle;

typedef enum {
    ISSHistogramStyleNone,
    ISSHistogramPlain,
    ISSHistogramGradient
}ISSHistogramStyle;


typedef enum {
    ISSChartArrowDirectionLeft = 0,
    ISSChartArrowDirectionRight,
    ISSChartArrowDirectionUp,
    ISSChartArrowDirectionDown,
}ISSChartArrowDirection;

typedef enum {
    ISSChartSymbolRectang = 0,
    ISSChartSymbolArrow,
}ISSChartSymbolType;

#endif

#pragma mark - local data cache key

#define CIB_HOMEPAGE_BACKGROUND_ANIMATION @"CIB_HOMEPAGE_BACKGROUND_ANIMATION"
#define CIB_DETAIL_NEWS_FONT_SIZE @"CIB_DETAIL_NEWS_FONT_SIZE"


#define DEFAULT_FONT_SIZE 16

#define DEFAULT_AREADATA_COMPAREVIEW_TOP_MARGIN 456
#define DEFAULT_AREADATA_COMPAREVIEW_BOTTOM_MARGIN 60

#define DEFAULT_AREADATA_COMPAREVIEW_LEFT_MARGIN 10
#define DEFAULT_AREADATA_COMPAREVIEW_WIDHT 100
#define DEFAULT_AREADATA_COMPAREVIEW_HEIGHT 30


//#define DEFAULT_CHNLIDS @[@"-1",@"-2",@"-3",@"-5",@"-4",@"0"]
#define DEFAULT_CHNLIDS @[@"-2",@"-3",@"-5",@"-4",@"0"]

typedef enum {
    subscribeId = 0,
    //newsId = -1,
    //newsId = 46,
    rankId = -2,
    newsRankId = -3,
    indexId = -4,
    indexSearchId = -5
    
} DefaultChnlIds;

typedef enum {
    
    LoginSuccessed = 0,
    
    Error1 = 1,
    Error2 = 2,
    Error3 = 3,
    Error4 = 4,
    Error5 = 5,
    Error6 = 6,
    Error7 = 7,
    Error8 = 8,
    Error9 = 9,
    Error10 = 10,
    Error11 = 11,
    Error12 = 12
    
} LoginRequestCode;


#define URLLOGINBOP            @"http://22.189.6.120:8080/"

#define URLLOGINBOP            @"http://22.189.6.120:8080/"

#define BOCOPREGURL            @"http://22.189.6.120:8080/"

#define BOCOPASRURL            @"http://22.189.6.121:8081/"


//广告图片前缀
#define AD_NOTICE_URL          @"http://22.11.140.45/"

#define BOCOPASRURL_TEST         @"http://192.168.1.104:8080/EzdbPro/"

