//
//  ViewController.m
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/6/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

//@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardView;
@property (strong, nonatomic) AVPlayer *songPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //play background music
    [self playselectedsong];
    
    
}

-(void)playselectedsong{
    
    
    //NSString *urlString = @"https://www.dropbox.com/s/lqdo6fq7j0mlmzr/deephouse2017.m4a?dl=0";
    //NSString *urlString = @"http://www.kpphillips.com/tvos/deephouse2017.m4a";
    NSString *urlString = @"http://www.kpphillips.com/tvos/foria.mp3";
    
    
    AVPlayer *player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:urlString]];
    self.songPlayer = player;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.songPlayer currentItem]];
    [self.songPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    
    [self.songPlayer play];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.songPlayer && [keyPath isEqualToString:@"status"]) {
        if (self.songPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            
        } else if (self.songPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
            
        } else if (self.songPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
            
        }
    }
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    //  code here to play next sound file
    NSLog(@"Play Next Song");
    
    
}

- (void)updateProgress:(NSTimer *)timer{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
