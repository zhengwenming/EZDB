//
//  PerCenterVController.m
//  EZDB
//
//  Created by wenming.zheng on 14-10-17.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import "PerCenterVController.h"
#import "HelpCenterViewController.h"
#import "SetPayPwdViewController.h"
#import "WmPickerViewController.h"
#import "LoginViewController.h"
#import "CardViewController.h"
#import "UpdPwdViewController.h"
#import "NoticeViewController.h"
#import "PwdManageVController.h"
#import "SystemViewController.h"
#import "RedemptionFailureViewController.h"
#import "NoticeListViewController.h"
#import "GetHeadImgDataRequest.H"
#import "GetCustInfoRequest.h"
#import "VerifyVCPPwdRequest.h"
#import "QueryVCPPwdRequest.h"
#import "GenVCPEntityRequest.h"
#import "BindCardModel.h"
#import "GetServerRandomRequest.h"
#import "UploadAvatarRequest.h"

#define ORIGINAL_MAX_WIDTH 640.0f


typedef enum : NSInteger{
    kCheckVersion = 1,
    kLogOut ,
    kUpLoad ,
    kDownLoad ,
} kRequeststyle;

typedef enum : NSUInteger {
    kLogOutAlert = 33,
    kUpdateAlert,
    kForcedOut,
    kReqstFailAlert
} kAlertViewType;

typedef enum : NSUInteger {
    kCamaraTakePhoto = 0,
    kGetFromPhoneAblum,
    kCancelChoices,
} kChangeHeadImageStyle;

@interface PerCenterVController ()
{
    NSMutableArray *custInfoArr;
    NSDictionary *entity;
    MBProgressHUD *hub;
}
@end

@implementation PerCenterVController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        custInfoArr = [NSMutableArray array];
        entity = [NSDictionary dictionary];
        // Custom initialization
    }
    return self;
}
#pragma mark - PopViewContrlDelegate
- (void)popViewContrl:(NSInteger )index{
    if (index==1) {
     
    }else if(index==2){
        NoticeListViewController *notice = [[NoticeListViewController alloc]init];
        [self.navigationController pushViewController :notice animated:YES];
    }
}

- (void)tapHeadImage:(UITapGestureRecognizer *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}

//#pragma mark - wmImagePicker delegate
//#pragma mark
//#pragma mark 网络请求上传头像
//-(void)imagePicker:(WmPickerViewController *)pickerViewController didFinished:(UIImage *)editedImage{
//    self.headImageView.image = editedImage;
//    
//    [pickerViewController dismissViewControllerAnimated:YES completion:^{
//        // 上传服务器
//        UIImage *newImg=[self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(120, 120)];
//        //网络请求上传头像
//        
//        NSData *imageData = UIImageJPEGRepresentation(newImg, 1.0);
//        //base64处理
//        NSString *image_string=nil;
//        if (kDeviceVersion>=7.0) {
//            image_string = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        }else{
//            image_string = [imageData base64Encoding];
//        }
//        //
//        NSLog(@"image_string==%@",image_string);
//        BOCOPPayAuthorizeInfo *authorizeInfo = [BOCOPLogin sharedInstance].authInfo;
//        UploadAvatarRequest *request = [UploadAvatarRequest requestWithHeaders:nil];
//        NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[request getBusinessRequestHeaderDictionary:authorizeInfo]];
//        //报文头
//        request.headers = headers;
//        //参数
//        NSDictionary *bodyParameters = [[NSDictionary alloc] initWithObjectsAndKeys:[BOCOPLogin sharedInstance].userName, @"usrid",image_string,@"filedata",[UserInfoSample shareInstance].userItems[@"uid"], @"uid",kAppId,@"appid",kAppkey,@"appkey",nil];;
//        
//        request.postJSON = [bodyParameters JSONString];
//        
//        [request onRequestDidFinishLoadingWithResult:^(NSDictionary *result) {
//            NSLog(@"%@",result);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [hub hide:YES];
//                [MSUtil showTipsWithHUD:@"头像上传成功" showTime:1.5];
//            });
//        }];
//        [request onRequestFailWithError:^(NSError *error) {
//            NSLog(@"notice _detail _error:%@",error);
//            [hub hide:YES];
//            [MSUtil showTipsWithHUD:@"头像上传失败" showTime:1.5];
//            
//        }];
//        [request connect];
//        }];
//}
//
//
-(void)imagePickerDidCancel:(WmPickerViewController *)pickerViewController{
    [pickerViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case kCamaraTakePhoto:{

            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable]) {
                    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                picker.mediaTypes = mediaTypes;
                picker.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;

                picker.delegate = self;
                [self presentViewController:picker
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                }];
            }else{
                [MSUtil showHudMessage:@"该设备不支持拍照" hideAfterDelay:1.5 uiview:self.view];
            }
            break;
        }
        case kGetFromPhoneAblum:{
            //从手机相册中选择
            
            if ([self isPhotoLibraryAvailable]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                picker.mediaTypes = mediaTypes;
                picker.delegate = self;
                [self presentViewController:picker
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                     [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
                }];
            }
            break;
        }
        case kCancelChoices:{
            //取消
            break;
        }
        default:
            break;
    }
}
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}



- (UIImage *)imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize
{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    //检验是否有VCP支付密码
//    [self queryVCPPwd];
    [self initUI];
    //获取头像
//    [self getAvatar];
    //获取VCP实体
 //   [self getVCPEntity];
    //客户附加信息
//    [self getCustInfo];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EZDBAppDelegate appDelegate].tabBarCtl showMyTabBar];
}

#pragma mark - getCustInfo
#pragma mark -
- (void)initUI
{
    [self setNavBarWithtitle:kPerCenterTitle superView:self.view backImg:nil homeImg:kNavNoticeImgName];
    if (kDeviceVersion>=7.0) {
        
        
    }else{
        for (UIView *v in self.view.subviews) {
            CGRect rect = v.frame;
            rect.origin.y -= 0;
            v.frame = rect;
        }
    }

    self.headImageView.layer.cornerRadius = self.headImageView.bounds.size.height/2;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.borderWidth = 2;
    self.headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userNameLabel.text = [BOCOPLogin sharedInstance].userName;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadImage:)];
    [self.headImageView addGestureRecognizer:tap];
    [self.headImageView setUserInteractionEnabled:YES];

    [self.pwdManBtn addTarget:self action:@selector(pwdManageBtn:) forControlEvents:UIControlEventTouchUpInside];

//    [self.myBankCard addTarget:self action:@selector(toggleCardInfo:) forControlEvents:UIControlEventTouchUpInside];
    [self.systemBtn addTarget:self action:@selector(systemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"self.payPwdName %@",self.payPwdName);
    
}

#pragma mark - 密码管理
- (void)pwdManageBtn:(UIButton *)sender
{
    PwdManageVController *pwdManVc = [[PwdManageVController alloc]initWithNibName:@"PwdManageVController" bundle:nil];
    [self.navigationController pushViewController:pwdManVc animated:YES];
    
}
//#pragma mark - 我的银行卡
//-(void)toggleCardInfo:(UIButton *)sender
//{
//    GOTO_NEXTVIEWCONTROLLER(CardViewController,
//                            @"CardViewController35",
//                            @"CardViewController");
//}

#pragma mark - 系统中心
- (void)systemBtnClick:(UIButton *)sender
{
    SystemViewController *systemVc = [[SystemViewController alloc]initWithNibName:@"SystemViewController" bundle:nil];
    [self.navigationController pushViewController:systemVc animated:YES];
}

- (IBAction)RedeBtn:(id)sender {
    
    RedemptionFailureViewController *rfc = [[RedemptionFailureViewController alloc] init];
    [self.navigationController pushViewController:rfc animated:YES];
}

- (IBAction)traBtn:(id)sender {
    CardViewController *cvt = [[CardViewController alloc] init];
    [self.navigationController pushViewController:cvt animated:YES];
}
@end
