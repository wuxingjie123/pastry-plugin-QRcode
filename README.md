# 支持平台

|平台 | 是否支持 |
|-----|------|
|JS    |  支持    |
|FO-NodeJS    |  不支持    |
|iOS    | 支持    |
|android    | 支持(待开发)    |

# 组件依赖关系

|组件 | 版本号 | 地址|
|-----|------|----|
|二维码扫码    | 1.0.0    | [GitHub地址](https://github.com/pastryTeam/pastry-plugin-QRCode.git)|

# 功能介绍
>
* 可选功能
  * 二维码扫描
  
# 安装方法
>
* pastry本地包安装 
   +  命令行$: pastry bake plugin add pastry-plugin-QRCode
   +  导入二维码组件LBXScan

>
* github在线安装

    # 安装指定 tag 版本
    pastry bake plugin add https://github.com/pastryTeam/pastry-plugin-QRCode.git#1.0.0 
    
    # 安装最新代码
    pastry bake plugin add https://github.com/pastryTeam/pastry-plugin-QRCode.git
    
# 使用方法

>
* 二维码扫描
   + 方法  
    ```PTQRCodeManager.scanCode(options, completeCallback)```
  + 代码示例
  
        PTQRCodeManager.scanCode(["1001"], function (tx) {
        //返回二维码，条形码扫描结果字符串
                  console.log(tx);
                  });

        
# 作者
* pastryTeam团队

