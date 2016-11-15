# 支持平台
>
|平台 | 是否支持 |
|-----|------|
|JS    | 支持    |
|iOS    | 支持   |
|android    | 不支持    |

# 依赖服务器数据
>
|平台 | 是否依赖 |
|-----|------|
|FO-Java    | 不依赖    |
|FO-NodeJS    |  不依赖    |

# 组件依赖关系
>
|组件 | 版本号 | 地址|
|-----|------|----|
|二维码扫码   | 版本号    | [GitHub地址](https://github.com/pastryTeam/pastry-plugin-QRCode.git)|

# 功能介绍
>
* 必选功能
    * 无
* 可选功能
    * 二维码扫码
    
# 安装方法
>
* pastry本地包安装

   +  命令行$: pastry bake plugin add pastry-plugin-QRCode
   +  导入二维码组件LBXScan

>
* github在线安装

    # 安装指定 tag 版本,例如 版本号 = 1.0.0
    pastry bake plugin add https://github.com/pastryTeam/pastry-plugin-QRCode.git#1.0.0 
    
    # 安装最新代码
    pastry bake plugin add https://github.com/pastryTeam/pastry-plugin-QRCode.git

# 插件安装到项目里的目录结构
>
涉及两种目录

* 代码目录
        
    项目名称/platforms/ios/项目名称/Plugins/pastry-plugin-QRCode
    
* 资源目录
    
    项目名称/platforms/ios/项目名称/Resources/QRCode.bundle
    
# 使用方法
>
* 如需修改功能
        
     # JS端 二维码（条形码）扫码
    －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
       PTQRCodeManager.scanCode(["参数（可为空）"], function (tx) {
           //返回二维码，条形码扫描结果字符串
           console.log(tx);
       });

> 
* 如需修改页面显示效果
        
    自行修改 代码目录

>
* 如需修改插件资源
        
    自定修改 资源目录

# 作者
>
* pastryTeam团队



