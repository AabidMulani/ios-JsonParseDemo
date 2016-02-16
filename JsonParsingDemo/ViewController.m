//
//  ViewController.m
//  JsonParsingDemo
//
//  Created by Magneto on 7/5/14.
//  Copyright (c) 2014 Magneto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//http://166.62.16.25/~crimebus/dummy/master/WS/get_venue_list.php
//    [NSThread detachNewThreadSelector:@selector(getData) toTarget:self withObject:nil];

    [self performSelectorInBackground:@selector(getData:) withObject:@"get_venue_list.php"];
    
}
-(void)getData:(NSString *)apiName
{
    NSString *strUrl=[NSString stringWithFormat:@"http://166.62.16.25/~crimebus/dummy/master/WS/%@",apiName];
    strUrl=[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:strUrl];
//    NSURLRequest *request=[NSURLRequest requestWithURL:url];
//    NSURLResponse *response;
        NSError *err;
//    NSData *dat=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//    if (err) {
//        
//    }
    
    NSData *data=[NSData dataWithContentsOfURL:url];

    NSMutableArray *arrOFContents=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
    if (err) {
        NSLog(@"err:%@",err.localizedDescription);
    }
    else
    {
        arrOFContents=arrOFContents[0];
        //NSLog(@"Json Data:%@",[arrOFContents valueForKey:@"venuelist"]);
        arrOFContents=[arrOFContents valueForKey:@"venuelist"];
        for (NSDictionary *dict in arrOFContents)
        {
            NSLog(@"Dict:%@",[dict objectForKey:@"v_name"]);
        }
    }
}
@end
