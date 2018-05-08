//
//  DemoAppUITests.m
//  DemoAppUITests
//
//  Created by Shimi Sheetrit on 2/1/16.
//  Copyright © 2016 Matomy Media Group Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DemoAppUITests : XCTestCase

@end

@implementation DemoAppUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // 1.
    UIWebView* webView = [[UIWebView alloc] init];
    [webView loadHTMLString:@"https://www.google.co.il" baseURL:[NSURL URLWithString:@"https://www.google.co.il"]];
    webView.allowsInlineMediaPlayback = true;
    webView.mediaPlaybackRequiresUserAction = false;
    
    
    // 2.
    UIWebView* webView_2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.makemegeek.com"]];
    
    [webView_2 loadRequest:request];
    webView_2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    //NSLog(@"webView.request.URL: %@", webView.request.URL);
    //NSLog(@"webView_2.request.URL: %@", webView_2.request.URL);
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"window.location"];
    
}

@end
