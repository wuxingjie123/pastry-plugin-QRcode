//
//  PTScanCodeViewController.h
//  HelloWorld
//
//  Created by 董阳阳 on 16/9/14.
//
//

#import <UIKit/UIKit.h>
typedef void(^InfoBlock)(NSDictionary *dic);

@interface PTScanCodeViewController : UIViewController


@property (copy, nonatomic)InfoBlock infoBlock;

@end
