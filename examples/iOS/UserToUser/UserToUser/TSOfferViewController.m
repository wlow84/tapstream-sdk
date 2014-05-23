//
//  TSOfferViewController.m
//  UserToUser
//
//  Created by Eric on 2014-05-16.
//  Copyright (c) 2014 Tapstream. All rights reserved.
//

#import "TSOfferViewController.h"

@implementation TSOfferViewController

@synthesize parentViewController, offer, delegate;

+ (id)controllerWithOffer:(TSOffer *)offer parentViewController:(UIViewController *)parentViewController delegate:(id<TSUserToUserDelegate>)delegate
{
    return AUTORELEASE([[TSOfferViewController alloc] initWithNibName:@"TSOfferView" bundle:nil offer:offer parentViewController:parentViewController delegate:delegate]);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(TSOffer *)offerVal parentViewController:(UIViewController *)parentViewControllerVal delegate:(id<TSUserToUserDelegate>)delegateVal
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.offer = offerVal;
        self.parentViewController = parentViewControllerVal;
        self.delegate = delegateVal;
        ((UIWebView *)self.view).delegate = self;
        [((UIWebView *)self.view) loadHTMLString:self.offer.markup baseURL:[NSURL URLWithString:@""]];
    }
    return self;
}

- (void)dealloc
{
    RELEASE(self->offer);
    RELEASE(self->parentViewController);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = self.parentViewController.view.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)close
{
    [UIView transitionWithView:self.view.superview
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ [self.view removeFromSuperview]; }
                    completion:NULL];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = [[request URL] absoluteString];
    if([url isEqualToString:@"close"]) {
        [self close];
        return NO;
        
    } else if([url isEqualToString:@"accept"]) {
        [self close];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end