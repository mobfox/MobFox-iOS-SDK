//
//  SOMARenderedAdViewDelegate.h
//  iSoma
//
//  Created by Aman Shaikh on 30/06/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOMAAdRenderer;

@protocol SOMARenderedAdViewDelegate <NSObject>
- (BOOL)isInterstitialAdView;
- (void)applicationWillResignActive;
-(void)rendererUserInteractionWillStart:(SOMAAdRenderer*)renderer ;
-(void)rendererUserInteractionEnded:(SOMAAdRenderer*)renderer ;
-(void)renderedAdViewDidFinishedRendering:(UIView*)renderedView;
-(void)renderedAdView:(SOMAAdRenderer*)renderedView needsModalPresentation:(BOOL)yesOrNo;
-(void)renderedAdViewClosed:(SOMAAdRenderer*)renderedView;
@end
