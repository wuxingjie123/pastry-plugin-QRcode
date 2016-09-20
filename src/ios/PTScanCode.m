//
//  CDVScanCode.m
//  HelloWorld
//
//  Created by 董阳阳 on 16/9/18.
//
//

#import "PTScanCode.h"
#import "PTScanCodeViewController.h"

@implementation PTScanCode

- (void)handleScanCode:(CDVInvokedUrlCommand *)command;
{
        
    PTScanCodeViewController *scan = [[PTScanCodeViewController alloc] init];
    scan.infoBlock = ^(NSDictionary *dic) {
        
        NSString *str = dic[@"string"];
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:str];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    };
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:scan] animated:YES completion:nil];
    
    
}

@end
