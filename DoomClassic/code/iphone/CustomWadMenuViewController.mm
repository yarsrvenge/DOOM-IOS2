/*
 
 Copyright (C) 2009-2011 id Software LLC, a ZeniMax Media company. 
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 2
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 
 */

#import "CustomWadMenuViewController.h"
#include "doomiphone.h"
#include "iphone_delegate.h"
#import "GameMenuViewController.h"


/*
 ================================================================================================
 Doom_MissionMenuViewController
 
 ================================================================================================
 */
@implementation Doom_CustomWadMenuViewController

/*
 ========================
 Doom_MissionMenuViewController::initWithNibName
 ========================
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 ========================
 Doom_MissionMenuViewController::didReceiveMemoryWarning
 ========================
 */
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 ========================
 Doom_MissionMenuViewController::viewDidLoad
 ========================
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateList];
}

- (void)populateList
{
    NSArray *viewsToRemove = [mapScroller5 subviews];
    for (UIView *v in viewsToRemove) [v removeFromSuperview];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    inboxPath = [[documentsDirectory stringByAppendingPathComponent:@"Inbox"] copy];
    NSArray *dirFiles = [filemgr contentsOfDirectoryAtPath:inboxPath error:nil];
    
    //dirFiles = [NSArray arrayWithObjects: @"Test.wad", @"Test2.wad", @"Test3.wad", @"Test4.wad" , @"Test5.wad", nil];
    
    if(!initialized && dirFiles.count == 0)
    {
        [self Play];
        return;
    }
    
    UIButton *button;
    int y = 15;
    for (id dir in dirFiles) {
        // do something with object
        
        NSString *value = (NSString *)dir;
        
        /*
         NSArray *components = [NSArray arrayWithObjects:inboxPath, value, nil];
         
         NSString *path = [NSString pathWithComponents:components];
         [filemgr removeItemAtPath:path error:NULL];
         */
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(MAP01:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:value forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        
        button.frame = CGRectMake(15, y, 270, 22.0);
        [mapScroller5 addSubview:button];
        y += 45;
    }
    
    [mapScroller5 setContentSize:CGSizeMake(
                                            mapScroller5.bounds.size.width,
                                            CGRectGetMaxY(button.frame)
                                            )];
    
    selectedMap = nil;
    mapSelected = -1;
    
    
    mapScroller5.alpha = 0.0f;
    
    selectedScroller = mapScroller5;
    
    
    selectedScroller.alpha = 1.0f;
    initialized = true;
}

/*
 ========================
 Doom_MissionMenuViewController::viewDidUnload
 ========================
 */
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*
 ========================
 Doom_MissionMenuViewController::setEpisode
 ========================
 */
- (void) setEpisode: (int) episode {
    
    episodeSelected = episode;
}

/*
 ========================
 Doom_MissionMenuViewController::setGame
 ========================
 */
- (void) setGame: (int) game {
    
    gameSelected = game;
}

/*
 ========================
 Doom_MissionMenuViewController::BackPressed
 ========================
 */
-(IBAction)     BackPressed {
    
    [self.navigationController popViewControllerAnimated:NO];
    
    Sound_StartLocalSound( "iphone/controller_down_01_SILENCE.wav" );
    
}

/*
 ========================
 Doom_MissionMenuViewController::getSkill
 ========================
 */
- (int)  getSkill {
    
    return 0;
}

/*
 ========================
 Doom_MissionMenuViewController::UpMission
 ========================
 */
-(IBAction)     UpMission {
    
    CGFloat xOffset = selectedScroller.contentOffset.x;
    CGFloat yOffset = selectedScroller.contentOffset.y;
    
    if (selectedScroller.contentOffset.y > 10 )
    {
        [selectedScroller setContentOffset:CGPointMake(xOffset, yOffset - 50 ) animated:YES];
    }
}

/*
 ========================
 Doom_MissionMenuViewController::DownMission
 ========================
 */
-(IBAction)     DownMission {
    
    CGFloat xOffset = selectedScroller.contentOffset.x;
    CGFloat yOffset = selectedScroller.contentOffset.y;
    
    int yscrollStop = 300;
    
    if(gameSelected > 0 && IS_IPAD)
        yscrollStop = 1150;
    else if(gameSelected > 0 && (IS_IPHONE))
        yscrollStop = 1250;
    
    if (selectedScroller.contentOffset.y < yscrollStop )
    {
        [selectedScroller setContentOffset:CGPointMake(xOffset, yOffset + 50 ) animated:YES];
    }
    
}

/*
 ========================
 Doom_MissionMenuViewController::Play
 ========================
 */
-(IBAction)     Play {
    // Switch to episode view menu.
    Doom_GameMenuViewController *vc = [[Doom_GameMenuViewController alloc] initWithNibName:[gAppDelegate GetNibNameForDevice:@"GameMenuView"] bundle:nil];
    
    NSArray *components = [NSArray arrayWithObjects:inboxPath, selectPwad, nil];
    NSString *path = [NSString pathWithComponents:components];
    
    [self.navigationController pushViewController:vc animated:NO];
    [vc SetPwad: [path copy]];
    [vc setLoadSaveGame:loadSaveGame];
    [vc release];
    
    Sound_StartLocalSound( "iphone/baborted_01.wav" );
}

- (void)setLoadSaveGame:(BOOL)loadGame
{
    loadSaveGame = loadGame;
}


/*
 ========================
 Doom_MissionMenuViewController::playMap
 ========================
 */
- (void) playMap:(int)dataset
				:(int)episode
				:(int) map {
    
	(void)dataset;
	
    [ playButton setEnabled: YES ];
    [ playLabel setEnabled: YES ];
    
    if( selectedMap != nil ) {
        [ selectedMap setEnabled: YES ];
    }
    episodeSelected = episode;
    mapSelected = map;
    
    
    int mapTag = 0;
    
    if(gameSelected == 0)
        mapTag = episode * 10 + ( map - 1 );
    else if(gameSelected == 1)
        mapTag = 100 +( map - 1);
    else if(gameSelected == 2)
        mapTag = 200 +( map - 1);
    else
        mapTag = 300 +( map - 1);
    
    selectedMap = (idLabelButton *)[ self.view viewWithTag: mapTag ];
    
    if(selectedMap != nil)
        [selectedMap setEnabled: NO];
    
    Sound_StartLocalSound( "iphone/controller_down_01_SILENCE.wav" );
}

/*
 ========================
 Doom_MissionMenuViewController::EasyPressed
 ========================
 */


- (IBAction)MAP01:(UIControl *)sender  {
    if(activeButton != nil)
    {
        activeButton.selected = false;
    }
    
    UIButton *resultButton = (UIButton *)sender;
    activeButton = resultButton;
    [activeButton setSelected:TRUE];
    selectPwad = [[[activeButton titleLabel] text] copy];
}

-(IBAction)     DeletePressed {
    
    NSArray *components = [NSArray arrayWithObjects:inboxPath, selectPwad, nil];
    NSString *path = [NSString pathWithComponents:components];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:path error:&error];
    
    if (success) {
        NSLog(@"Deleted file -:%@ ", path);
        selectPwad = nil;
        activeButton.selected = false;
        [self populateList];
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}


@end
