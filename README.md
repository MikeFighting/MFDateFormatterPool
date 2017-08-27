# MFDateFormatterPool

MFDateFormatterPool is a Cache Pool for NSDateFormatter instance.

## Why do We Need Cache NSDateFormatter

Creating the NSDateFormatter and changing the date style or time style is very expensive, [as the experiments done by someone](http://www.chibicode.org/?p=41) . It takes long time to initialize the instance. What we should do is creating each style of date formatter once and use it the whole project.

## What does MFDateFormatterPool do ?

MFDateFormatterPool created the cache by NSCache. The first time you created the `NSDateFormatter`, it will cache the instance for you. If you need to use the same date formatter style, it will return the old one for you instead of creating a new one, which is too expensive. 

## How To Use It ?

Using the MFDateFormatterPool is very easy：

```objc
    MFDateFormatterPool *myDateFormatterPool = [MFDateFormatterPool sharedInstance];
    NSString *myFormat = @"yyyy:MM:dd HH:mm:ss";
    NSDateFormatter *myFirstFormatter = [myDateFormatterPool dateFormatterWithFormat:myFormat];
    NSDateFormatter *mySecondFormatter = [myDateFormatterPool dateFormatterWithFormat:myFormat];
```   

## Contat

Please issue me or send emails(wallaceicdi@gmail.com), if you have any problems using this tool. 



