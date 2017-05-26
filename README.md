# WQBasicComponents
根据自己平常使用频率比较高的一些控件以及工具的封装,收集起来方便自己以后的方便使用
### 支持CocoaPods
    pod 'WQBasicComponents','~> '0.0.9'
---
##### 提示:
> 由于库里面包含音频转换的资源包所以更新的时候需要的时间比较长。

#### 1. 录音
```objective-c
self.manger = [WQVoiceRecordManager manager];
[self.manger recordWithPathExtension:@"wav"];
```
#### 2.播放
```objective-c
//下载的是amr格式的语音需要转换为wav格式
[[WQVoicePlayManager manager].downloader setConvertVoiceStyle:WQConvertBase64AmrToWav];
[[WQVoicePlayManager manager] play:@"http://123.56.148.205/upload/audio/865555555555553/2/aud_58aeba23f30b9.txt" playFinsh:^(NSError *error, NSString *urlStr, BOOL finshed) {
    }];
```
#### 3.五星评分
><small>支持任意大小的五角星形状，也支持使用图片</small>

```objective-c
 WQStarLevel *starLevel = [[WQStarLevel alloc] init];
[starLevel addTarget:self action:@selector(satrValueChanged:) forControlEvents:UIControlEventValueChanged];
starLevel.half = YES;
[self.StarContentView addSubview:starLevel];
starLevel.backgroundColor = [UIColor whiteColor];
starLevel.starHeight = 40;
```

#### 4.标题与图片位置任意方向排列的按钮
><small>支持本身的自带布局属性</small>

```objective-c
WQEdgeTitleButton *edgeTitle = [self commonContentTitle];
edgeTitle.titleAliment = ButtonTitleAlimentTop;
edgeTitle.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
edgeTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
edgeTitle.frame = CGRectMake(20, 300, 280 , 120);
