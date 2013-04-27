//
//  NetWorkDemoController.m
//  CookBookDemo
//
//  Created by linzhu on 13-4-17.
//  Copyright (c) 2013年 linzhu. All rights reserved.
//

#import "NetWorkDemoController.h"

@interface NetWorkDemoController (){
    NSMutableData *_imgData;
    UIImageView *_imgView;
}

@end

@implementation NetWorkDemoController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imgData = [[NSMutableData alloc] initWithCapacity:256];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _imgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_imgView];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self downLoadImageWithURL:@"http://imgm.ph.126.net/NqvoGG5rT9I16Boo2uG3dw==/2506253192649582356.png"];
    
   // [self downLoadTestPage];
	// Do any additional setup after loading the view.
}

-(void)downLoadImageWithURL:(NSString*)imgUrl{
    NSURL *url = [NSURL URLWithString:imgUrl];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSLog(@"start down load");
    
    //NSURLConnection *connection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                         returningResponse:&response error:&error];
    
    //[connection start];
    
    NSLog(@"end of the fun");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSDictionary *responseHeader = [(NSHTTPURLResponse*)response allHeaderFields];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_imgData appendData:data];
    UIImage *image = [UIImage imageWithData:_imgData];
    _imgView.image = image;
    //[_imgView setNeedsDisplay];
}

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"download finished");
}

-(void)downLoadTestPage{
    NSString *urlAsString = @"http://www.apple.com";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                   NSDictionary *test = [(NSHTTPURLResponse*)response allHeaderFields];
                               }
                               if ([data length] > 0 && error == nil) {
                                   NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HTML = %@", html);
                               }else if ([data length] == 0 && error == nil){
                                   NSLog(@"Nothing was downloaded.");
                               }else if (error != nil){
                                   NSLog(@"Error happened = %@", error);
                               }
                           }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
