//
//  BOCOPPayConstants_h
//

#import "BOCOPPayUtils.h"


#ifndef BOCOPPayConstants_h
#define BOCOPPayConstants_h

#define BOCOPPaySDKVersion                @"0.1"
#define kBOCOPPayRequestTimeOutInterval   20.0

#define kBOCOPPaySDKErrorDomain           @"kBOCOPPaySDKErrorDomain"
#define kBOCOPPaySDKErrorCodeKey          @"kBOCOPPaySDKErrorCodeKey"

//个人中心
#define kAppId           @"2"
#define kAppkey          @"nfX17bkbY5Efd3Gc86R5tbH078Qe32i9T3Tda3kfw614H1x0E5T1b6A0L0Vei3h1"
#define AVATARURL        @"http://22.188.12.106/ucs/public/userinterface/getavatar"
#define LOGOUT_URL       @"http://22.189.6.121:8081/ezdb/oauth/delauth"
#define kFindVersion     @"http://22.189.6.121:8081/ezdb/unlogin/findVersion"
#define UPLOAD_URL       @"http://22.188.12.106/ucs/public/userinterface/uploadavatar"
//注册界面
//#define kAppBopKey             @"170"
//#define kAppBopSecret          @"10323c1820af0513b08973ca6031255293aac5851c5d6d01d7"
#define REGISTER_URL           @"http://22.189.6.121:8081/ezdb/unlogin/nocardreguser"
#define MayUsedCharacter       @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@_."

#define REG_CHECKTWOPASSWORD       @"http://22.189.6.121:8081/ezdb/unlogin/checktwopassword"


//验证用户名是否注册
#define QUERYUSERID            @"http://22.189.6.121:8081/ezdb/unlogin/queryuserid"

//修改密码
#define BOCOPPAY_URL_REVISE_PWD [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/asr/updateuserpwd"]
//验证两次密码
#define BOCOPPAY_URL_QUERY_TWO_PWDS [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/asr/checktwopassword"]
//赎回失败换卡提醒
#define BOCOPPAY_URL_WARNCARDREPLACE [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/fund/warn_card_replace"]
//卡列表
#define BOCOPPAY_URL_QUERYCARDLIST [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/query_card_list"]
//卡限额查询
#define BOCOPPAY_URL_QUERYCARDLIMIT [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/query_card_limit"]
//修改卡别名
#define BOCOPPAY_URL_MODIFYCARDNAME [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/modify_card_name"]

//查询客户信息
#define BOCOPPAY_URL_CHECKUSERINFO [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/asr/useridquery"]

//注册两次验证
#define BOCOPPAY_URL_CHECKTWOPASSWORD [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/unlogin/asr/checktwopassword"]
//获取头像
#define BOCOPPAY_URL_GETHEADIMG @"http://22.188.12.106/ucs/public/userinterface/getavatar"
//获取服务器随机数
#define BOCOPPAY_URL_GET_SERVER_RANDOM [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/vcp_server/get_random_num"]
//修改支付密码
#define BOCOPPAY_URL_REVISEPAYPWD [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/modify_vcp_passwd"]
//设置支付密码
#define BOCOPPAY_URL_SETPAYPWD [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/set_vcp_passwd"]
//重置支付密码
#define BOCOPPAY_URL_RESETPAYPWD [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/reset_vcp_passwd"]
//基金列表
#define BOCOPPAY_URL_FUNDLISTCHECK [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/unlogin/fund/query_fund_list"]
//基金详情
#define BOCOPPAY_URL_FUNDDETAIL [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/unlogin/fund/query_fund_detailinfo"]
//赎回失败换卡更换
#warning 换卡接口
#define BOCOPPAY_URL_CHANGECARD [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/fund/apply_card_replace"]
//赎回申请
#define BOCOPPAY_URL_REDEEM [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/fund/apply_redeem_fund"]
//赎回结果查询
#define BOCOPPAY_URL_QUERY_REDEEM_RESULT [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/fund/query_redeem_result"]
//持仓信息查询
#define BOCOPPAY_URL_QUERYFUNDPROPERTY [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/fund/query_fund_property"]
//收益明细(客户收益流水查询)
#define BOCOPPAY_URL_QUERYINCOMEDETAIL [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/fund/query_income_detail"]
//交易明细列表（查看历史交易记录列表）
#define BOCOPPAY_URL_QUERYHISTORYLIST [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/fund/query_history_list"]
//交易明细（查看历史交易记录详情）
#define BOCOPPAY_URL_QUERYHISTORYDETAIL [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/fund/query_history_detail"]

#define BOCOPPAY_URL_REDEEMFAIL_WARN_CARD_REPLACE [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/fund/warn_card_replace"]

//基金签约
#define BOCOPPAY_URL_SIGN_FUND [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/fund/apply_sign_fund"]

//基金签约状态
#define BOCOPPAY_URL_FUND_IF_SIGNED [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/fund/query_sign_state"]

//基金申购
#define BOCOPPAY_URL_SUBSCRIBE_FUND [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/fund/apply_subscribe_fund"]
//基金申购结果
#define BOCOPPAY_URL_SUBSCRIBE_REUSULT [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/fund/query_subscribe_result"]

//基金详情收益
#define BOCOPPAY_URL_PRODUCT_INCOME [NSString stringWithFormat:@"%@%@",BOCOPASRURL_TEST,@"ezdb/unlogin/fund/query_product_income"]


//广告和通知公告获取图片的iP是22.11.140.45
//广告列表
#define BOCOPPAY_URL_DBADLIST [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/unlogin/db_ad_list"]

//广告详情
#define BOCOPPAY_URL_DBADDETAIL [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/unlogin/db_ad_detail"]
//公告列表
#define BOCOPPAY_URL_DBNOTICE_LIST [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/unlogin/db_notice_list"]
//公告详情
#define BOCOPPAY_URL_DBNOTICE_DETAIL [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/unlogin/db_notice_detail"]

//回显客户卡信息
#define BOCOPPAY_URL_CUSTINFO [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/if_boc_card"]
//短信验证码
#define BOCOPPAY_URL_GETCODE [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/verify/get_msgcode"]
//短信验证码校验
#define BOCOPPAY_URL_VERIFYCODE [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/verify/verify_msgcode"]
//新增卡确定
#define BOCOPPAY_URL_BINDSUBMIT [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/band_card"]
//客户附加信息
#define BOCOPPAY_URL_GETCUSTINFO [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/asr/useridquery"]
//查询用户是否已有VCP支付密码
#define BOCOPPAY_URL_QUERYVCPPWD [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/query_vcp_passwd"]
//验证VCP支付密码
#define BOCOPPAY_URL_VERIFYVCPPWD [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/verify_vcp_passwd"]
//生成客户实体（拿到客户实体）
#define BOCOPPAY_URL_GENVCPENTITY [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/card/gen_vcp_entity"]
//登出
#define BOCOPPAY_URL_LOGOUT [NSString stringWithFormat:@"%@%@",BOCOPASRURL,@"ezdb/oauth/delauth"]



#define BOCOPPAY_URL_AUTHORIZE [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/oauth/token"]

#define BOCOPPAY_URL_CFTPRODUCT_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"cftproduct/search"]

#define BOCOPPAY_URL_CFTPRODUCT_RISK_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"cftproduct/cusrisksearch"]

#define BOCOPPAY_URL_ICARDINFO_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"icard/balinfo"]

#define BOCOPPAY_URL_ICARDTRANSFERINFO_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"icard/transferdetail"]

#define BOCOPPAY_URL_CFTPRODUCT_PRE_BUY [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"cftproduct/prebuy"]

#define  BOCOPPAY_URL_CFTPRODUCT_DUCT_BUY [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"cftproduct/buy"]

#define BOCOPPAY_URL_LISTPRICE_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"rate/search"]

#define BOCOPPAY_URL_CFTPRODUCT_BUYINFOSEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"cftproduct/buyedinfo"]

#define BOCOPPAY_URL_USERINFO_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"appfindusrinfo"]

#define BOCOPPAY_URL_CFTPRODUCT_REPEALENTRY [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"cftproduct/cancel"]

#define BOCOPPAY_URL_ACCUMULATION_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"accfund/balinfo"]

#define BOCOPPAY_URL_ACCUMULATIONDEPOSITE_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"accfund/depositinfo"]

#define BOCOPPAY_URL_GUANGDONG_SOCIALSECURITYCARD_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/keepbankinfoquery"]

#define BOCOPPAY_URL_GUANGDONG_MEDICARE_SEARCH  [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/keepbankdealquery"]

#define BOCOPPAY_URL_GUANGDONG_ACCUMULATIONBALANCEQUERY_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/reservedbalancequery"]

#define BOCOPPAY_RUL_GUANGDONG_ACCUMULATIONDEALQUERY_SEARCH  [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/reserveddealquery"]

#define BOCOPPAY_URL_FUNDTOPRIVATEACCOUNTS   [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/fundprivateopen"]

#define BOCOPPAY_URL_FUNDPRIVATEDEAL  [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/fundprivatedeal"]

#define BOCOPPAY_URL_FUNDPRIVATEREDEEM  [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/fundprivateredeem"]

#define BOCOPPAY_URL_FUNDORDER         [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/fund900"]

#define BOCOPPAY_URL_FUNDSINFO        [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/queryfundsinfo"]

#define BOCOPPAY_URL_FUNDSBALANCE   [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/queryfundsbalance"]

#define BOCOPPAY_FUND_PRIVATE_BANCS_CUSINFO_SEARCH [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"bocop/banking/fundpriquerybancs"]

#define BOCOPPAY_URL_QUERYMETALUSER   [NSString stringWithFormat:@"%@%@",[BOCOPPayUtils getURL],@"banking/querymetaluser"]

#define BOCOPPAY_URL_GET_RANDOM_NUM [NSString stringWithFormat:@"%@%@",URLLOGINBOP,@"oauth/getrdnum"]

#define BOCOPPAY_URL_AUTHORIZEASR [NSString stringWithFormat:@"%@%@",URLLOGINBOP,@"oauth/authorize"]

#define BOCOPPAY_URL_USERREREPEAT [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/unlogin/queryuserid"]

#define BOCOPPAY_URL_CHECKACRDNUM [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/unlogin/checkcardno"]



#define BOCOPPAY_URL_SENDCHIT [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/unlogin/sendchit"]

#define BOCOPPAY_URL_REGUSE [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/unlogin/reguser"]

#define BOCOPPAY_CHECK_DEBIT [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/unlogin/checkdebitmobilebank"]

#define BOCOPPAY_URL_CHECKDEBITMOBILEBANK [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/unlogin/checkdebitmobilebank"]
//SF0002信用卡购汇还款查询
#define BOCOPPAY_URL_TRADEFUNDCHA [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/creditbuyrepayquery"]

//SF0003信用卡购汇还款交易
#define BOCOPPAY_URL_TRADEFUNDJIAO [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/creditbuyrepay"]

//SF0005结售汇额度查询
#define BOCOPPAY_URL_SALELIMIT [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/salelimitquery"]
//SF0006结汇额度登记及汇兑账务处理
#define BOCOPPAY_URL_SETTLE [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/settlelimitbill"]
//SF0007汇售额度登记及汇兑账务处理
#define BOCOPPAY_URL_POSTSELL [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/postselllimitbill"]
//SF0008查询用户卡资料
#define BOCOPPAY_URL_APPFIND [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/asr/appfindusrinfo"]

//SF0009借记卡余额多币种查询
#define BOCOPPAY_URL_BLANCE [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/debitmultiblance"]
//信用卡挂失并补卡
#define BOCOPPAY_URL_RED [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/creditbalregain"]
//借记卡挂失
#define BOCOPPAY_URL_DEB [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/debitbalregain"]
//信用卡挂失
#define BOCOPPAY_URL_LOSSCREDITCARD [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/creditballock"]
//挂失－－验证短信验证码
#define BOCOPPAY_URL_CHECKSHORTMESSAGE [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/checkshortmessage"]

//挂失－－借记卡电话银行验密
#define BOCOPPAY_URL_MOBILEBANKCHECKPWD [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/mobilebankcheckpwd"]


#define BOCOPPAY_URL_FOREX [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/rate/search"]

#define BOCOPPAY_URL_CHECKMOBILEINFO [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/asr/checkmobleinfo"]


#define BOCOPPAY_URL_ADDNEWCARD [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/asr/adduserinfo"]

#define BOCOPPAY_URL_INTERREMIT [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/internationalnetpostmoney"]

#define BOCOPPAY_URL_CREDITCARDBALANCE [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/asr/creditbalsearch"]

//SA0068附近地点查询
#define BOCOPPAY_URL_GEOINFO [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/base/unlogin/querygeoinfo"]

//SF0027现钞预约
#define BOCOPPAY_URL_OOFORDER [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/ooforder"]

//SF0030用户附加信息查询
#define USERINFO_URL [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/useradditionalinfo"]

//SF0031 查找邮寄地址
#define BOCOPPAY_URL_FindCreditPostAddress [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/findcreditpostaddress"]

//SI1019 开立携带外汇出境许可证
#define BOCOPPAY_URL_TestifySchlepRequest [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/setpermitgoout"]

#define BOCOPPAY_URL_AbroadRemit [NSString stringWithFormat:@"%@%@",BOCOPREGURL,@"afappserver/abroadremitapply"]

typedef enum
{
	BOCOPPaySDKErrorCodeAuthFailed = 1,
	BOCOPPaySDKErrorCodeAuthRefreshFailed,
	BOCOPPaySDKErrorCodeServerError,
	BOCOPPaySDKErrorCodeOtherError,
} BOCOPPaySDKErrorCode;

#endif
