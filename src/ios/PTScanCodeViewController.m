//
//  PTScanCodeViewController.m
//  HelloWorld
//
//  Created by 董阳阳 on 16/9/14.
//
//

#import "PTScanCodeViewController.h"
#import "LBXScanView.h"
#import "LBXScanWrapper.h"

@interface PTScanCodeViewController ()<UIAlertViewDelegate>

/**
 @brief  扫码功能封装对象
 */
@property (nonatomic,strong) LBXScanWrapper* scanObj;



#pragma mark - 扫码界面效果及提示等
/**
 @brief  扫码区域视图,二维码一般都是框
 */
@property (nonatomic,strong) LBXScanView* qRScanView;


/**
 @brief  扫码当前图片
 */
@property(nonatomic,strong)UIImage* scanImage;


/**
 *  界面效果参数
 */
@property (nonatomic, strong) LBXScanViewStyle *style;

/**
 @brief  启动区域识别功能
 */
@property(nonatomic,assign)BOOL isOpenInterestRect;

/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

///**
// @brief  闪关灯开启状态
// */
//@property(nonatomic,assign)BOOL isOpenFlash;
//


@end

@implementation PTScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"扫一扫";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self createLeftItem];
    
    [self drawScanView];
    
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.2];
}


//返回按钮

- (void)createLeftItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBackAction)];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)goBackAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//绘制扫描区域
- (void)drawScanView
{
    if (!_qRScanView)
    {
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        
        //设置扫码区域参数
        LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
        style.photoframeLineW = 2;
        style.photoframeAngleW = 18;
        style.photoframeAngleH = 18;
        style.isNeedShowRetangle = YES;
        style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
        style.colorAngle = [UIColor colorWithRed:0./255 green:200./255. blue:20./255. alpha:1.0];
        //qq里面的线条图片
        UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_Scan_weixin_Line"];
        style.animationImage = imgLine;
        
        //设置界面效果参数
        self.style = style;
        
        self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:style];
        [self.view addSubview:_qRScanView];
        
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, 145, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 50);
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准条形码即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
    
    [_qRScanView startDeviceReadyingWithText:@"相机启动中"];
    
}


//启动设备
- (void)startScan
{
    if ( ![LBXScanWrapper isGetCameraPermission] )
    {
        [_qRScanView stopDeviceReadying];
        
        [self showError:@"   请到设置隐私中开启本程序相机权限   "];
        return;
    }
    
    
    
    if (!_scanObj )
    {
        __weak __typeof(self) weakSelf = self;
 
        CGRect cropRect = CGRectZero;
        
#warning mark - 区域识别
        _isOpenInterestRect = YES;
        if (_isOpenInterestRect) {
            
            cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
        }
        
        self.scanObj = [[LBXScanWrapper alloc]initWithPreView:self.view
                                              ArrayObjectType:nil
                                                     cropRect:cropRect
                                                      success:^(NSArray<LBXScanResult *> *array){
                                                          [weakSelf scanResultWithArray:array];
                                                      }];
        
    }
    [_scanObj startScan];
    
    
    [_qRScanView stopDeviceReadying];
    
    [_qRScanView startScanAnimation];
    
    self.view.backgroundColor = [UIColor clearColor];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [_scanObj stopScan];
    [_qRScanView stopScanAnimation];
}


- (void)showError:(NSString*)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
}


- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //震动提醒
    [LBXScanWrapper systemVibrate];
    //声音提醒
    [LBXScanWrapper systemSound];
    
    [self showNextVCWithScanResult:scanResult];
    
}

//弹出错误提示框
- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:strResult delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.scanObj startScan];
}


//返回上一个页面
- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    NSDictionary *dic = @{@"string": strResult.strScanned};
    if (self.infoBlock) {
        
        self.infoBlock(dic);
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
