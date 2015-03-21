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

#import "MissionMenuViewController.h"
#include "doomiphone.h"
#include "iphone_delegate.h"

/*
 ================================================================================================
 Doom_MissionMenuViewController
 
 ================================================================================================
 */
@implementation Doom_MissionMenuViewController

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
    
    [mapScroller1 setContentSize:CGSizeMake(
                                            mapScroller1.bounds.size.width,
                                            CGRectGetMaxY(lastElement1.frame)
                                            )];
    
    [mapScroller2 setContentSize:CGSizeMake(
                                            mapScroller2.bounds.size.width,
                                            CGRectGetMaxY(lastElement2.frame)
                                            )];
    
    [mapScroller3 setContentSize:CGSizeMake(
                                            mapScroller3.bounds.size.width,
                                            CGRectGetMaxY(lastElement3.frame)
                                            )];
    
    [mapScroller4 setContentSize:CGSizeMake(
                                            mapScroller4.bounds.size.width,
                                            CGRectGetMaxY(lastElement4.frame)
                                            )];
    
    [mapScroller5 setContentSize:CGSizeMake(
                                            mapScroller5.bounds.size.width,
                                            CGRectGetMaxY(lastElement5.frame)
                                            )];
    
    [mapScroller6 setContentSize:CGSizeMake(
                                            mapScroller6.bounds.size.width,
                                            CGRectGetMaxY(lastElement6.frame)
                                            )];
    
    [mapScroller7 setContentSize:CGSizeMake(
                                            mapScroller7.bounds.size.width,
                                            CGRectGetMaxY(lastElement6.frame)
                                            )];

    
    [ playButton setEnabled: NO ];
    [ playLabel setEnabled: NO ];
    
    selectedMap = nil;
    mapSelected = -1;
    
    easySelection.hidden        = NO;
    easySelectionLabel.hidden   = NO;
    mediumSelection.hidden      = YES;
    mediumSelectionLabel.hidden = YES;
    hardSelection.hidden        = YES;
    hardSelectionLabel.hidden   = YES;
    NightmareSelection.hidden   = YES;
    nightmareSelectionLabel.hidden = YES;
    
    mapScroller1.alpha = 0.0f;
    mapScroller2.alpha = 0.0f;
    mapScroller3.alpha = 0.0f;
    mapScroller4.alpha = 0.0f;
    mapScroller5.alpha = 0.0f;
    mapScroller6.alpha = 0.0f;
    mapScroller7.alpha = 0.0f;


    switch( episodeSelected ) {
            
        case 0:
            if(gameSelected == 0)
                selectedScroller = mapScroller1;
            else if(gameSelected == 1)
                selectedScroller = mapScroller5;
            else if (gameSelected ==2)
                selectedScroller = mapScroller6;
            else
                selectedScroller = mapScroller7;
            break;
        case 1:
            selectedScroller = mapScroller2;
            break;
        case 2:
            selectedScroller = mapScroller3;
            break;
        case 3:
            selectedScroller = mapScroller4;
            break;
            
    };
    
    selectedScroller.alpha = 1.0f;
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
    
    if( easySelection.hidden == NO ) {
        return 0;
    } else if( mediumSelection.hidden == NO ) {
        return 1;
    } else if( hardSelection.hidden == NO ) {
        return 2;
    } else if( NightmareSelection.hidden == NO ) {
        return 3;
    }
    
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
    
    if(gameSelected > 0)
        yscrollStop = 1150;
    
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

    int skillLevel = [self getSkill];
    mapStart_t localStartmap;
    
    localStartmap.map = mapSelected;
    localStartmap.episode = episodeSelected;
    localStartmap.dataset = gameSelected;
    localStartmap.skill = skillLevel;
    
    StartSinglePlayerGame( localStartmap );
    
    [ gAppDelegate ShowGLView ];
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
-(IBAction)     EasyPressed {
    
    easySelection.hidden        = NO;
    easySelectionLabel.hidden   = NO;
    mediumSelection.hidden      = YES;
    mediumSelectionLabel.hidden = YES;
    hardSelection.hidden        = YES;
    hardSelectionLabel.hidden   = YES;
    NightmareSelection.hidden   = YES;
    nightmareSelectionLabel.hidden = YES;
    
    Sound_StartLocalSound( "iphone/controller_down_01_SILENCE.wav" );
}

/*
 ========================
 Doom_MissionMenuViewController::MediumPressed
 ========================
 */
-(IBAction)     MediumPressed {
    
    easySelection.hidden        = YES;
    mediumSelection.hidden      = NO;
    hardSelection.hidden        = YES;
    NightmareSelection.hidden   = YES;
    
    easySelectionLabel.hidden   = YES;
    mediumSelectionLabel.hidden = NO;
    hardSelectionLabel.hidden   = YES;
    nightmareSelectionLabel.hidden = YES;
    
    Sound_StartLocalSound( "iphone/controller_down_01_SILENCE.wav" );
    
}

/*
 ========================
 Doom_MissionMenuViewController::HardPressed
 ========================
 */
-(IBAction)     HardPressed {
    
    easySelection.hidden        = YES;
    mediumSelection.hidden      = YES;
    hardSelection.hidden        = NO;
    NightmareSelection.hidden   = YES;
    
    easySelectionLabel.hidden   = YES;
    mediumSelectionLabel.hidden = YES;
    hardSelectionLabel.hidden   = NO;
    nightmareSelectionLabel.hidden = YES;
    
    Sound_StartLocalSound( "iphone/controller_down_01_SILENCE.wav" );
    
}

/*
 ========================
 Doom_MissionMenuViewController::NightmarePressed
 ========================
 */
-(IBAction)     NightmarePressed{
    
    easySelection.hidden        = YES;
    mediumSelection.hidden      = YES;
    hardSelection.hidden        = YES;
    NightmareSelection.hidden   = NO;
    
    easySelectionLabel.hidden   = YES;
    mediumSelectionLabel.hidden = YES;
    hardSelectionLabel.hidden   = YES;
    nightmareSelectionLabel.hidden = NO;
    
    Sound_StartLocalSound( "iphone/controller_down_01_SILENCE.wav" );
}


/*
 ========================
 Doom_MissionMenuViewController  DOOM EPISODES
 ========================
 */
-(IBAction)     E1M1 {
    [ self playMap: 0: 1: 1 ];
}
-(IBAction)     E1M2{
    [ self playMap: 0: 1: 2 ];
}
-(IBAction)     E1M3{
    [ self playMap: 0: 1: 3 ];
}
-(IBAction)     E1M4{
    [ self playMap: 0: 1: 4 ];
}
-(IBAction)     E1M5{
    [ self playMap: 0: 1: 5 ];
}
-(IBAction)     E1M6{
    [ self playMap: 0: 1: 6 ];
}
-(IBAction)     E1M7{
    [ self playMap: 0: 1: 7 ];
}
-(IBAction)     E1M8{
    [ self playMap: 0: 1: 8 ];
}
-(IBAction)     E1M9{
    [ self playMap: 0: 1: 9 ];
}

-(IBAction)     E2M1{
    [ self playMap: 0: 2: 1 ];
}
-(IBAction)     E2M2{
    [ self playMap: 0: 2: 2 ];
}
-(IBAction)     E2M3{
    [ self playMap: 0: 2: 3 ];
}
-(IBAction)     E2M4{
    [ self playMap: 0: 2: 4 ];
}
-(IBAction)     E2M5{
    [ self playMap: 0: 2: 5 ];
}
-(IBAction)     E2M6{
    [ self playMap: 0: 2: 6 ];
}
-(IBAction)     E2M7{
    [ self playMap: 0: 2: 7 ];
}
-(IBAction)     E2M8{
    [ self playMap: 0: 2: 8 ];
}
-(IBAction)     E2M9{
    [ self playMap: 0: 2: 9 ];
}

-(IBAction)     E3M1{
    [ self playMap: 0: 3: 1 ];
}
-(IBAction)     E3M2{
    [ self playMap: 0: 3: 2 ];
}
-(IBAction)     E3M3{
    [ self playMap: 0: 3: 3 ];
}
-(IBAction)     E3M4{
    [ self playMap: 0: 3: 4 ];
}
-(IBAction)     E3M5{
    [ self playMap: 0: 3: 5 ];
}
-(IBAction)     E3M6{
    [ self playMap: 0: 3: 6 ];
}
-(IBAction)     E3M7 {
    [ self playMap: 0: 3: 7 ];
}
-(IBAction)     E3M8{
    [ self playMap: 0: 3: 8 ];
}
-(IBAction)     E3M9{
    [ self playMap: 0: 3: 9 ];
}

-(IBAction)     E4M1{
    [ self playMap: 0: 4: 1 ];
}
-(IBAction)     E4M2{
    [ self playMap: 0: 4: 2 ];
}
-(IBAction)     E4M3{
    [ self playMap: 0: 4: 3 ];
}
-(IBAction)     E4M4{
    [ self playMap: 0: 4: 4 ];
}
-(IBAction)     E4M5{
    [ self playMap: 0: 4: 5 ];
}
-(IBAction)     E4M6{
    [ self playMap: 0: 4: 6 ];
}
-(IBAction)     E4M7{
    [ self playMap: 0: 4: 7 ];
}
-(IBAction)     E4M8{
    [ self playMap: 0: 4: 8 ];
}
-(IBAction)     E4M9{
    [ self playMap: 0: 4: 9 ];
}

- (IBAction)MAP01 {
    [self playMap:gameSelected :0 :1];
}

- (IBAction)MAP02 {
    [self playMap:gameSelected :0 :2];
}

- (IBAction)MAP03 {
    [self playMap:gameSelected :0 :3];
}

- (IBAction)MAP04 {
    [self playMap:gameSelected :0 :4];
}

- (IBAction)MAP05 {
    [self playMap:gameSelected :0 :5];
}

- (IBAction)MAP06 {
    [self playMap:gameSelected :0 :6];
}

- (IBAction)MAP07 {
    [self playMap:gameSelected :0 :7];
}

- (IBAction)MAP08 {
    [self playMap:gameSelected :0 :8];
}

- (IBAction)MAP09 {
    [self playMap:gameSelected :0 :9];
}

- (IBAction)MAP10 {
    [self playMap:gameSelected :0 :10];
}

- (IBAction)MAP11 {
    [self playMap:gameSelected :0 :11];
}

- (IBAction)MAP12 {
    [self playMap:gameSelected :0 :12];
}

- (IBAction)MAP13 {
    [self playMap:gameSelected :0 :13];
}

- (IBAction)MAP14 {
    [self playMap:gameSelected :0 :14];
}

- (IBAction)MAP15 {
    [self playMap:gameSelected :0 :15];
}

- (IBAction)MAP16 {
    [self playMap:gameSelected :0 :16];
}

- (IBAction)MAP17 {
    [self playMap:gameSelected :0 :17];
}

- (IBAction)MAP18 {
    [self playMap:gameSelected :0 :18];
}

- (IBAction)MAP19 {
    [self playMap:gameSelected :0 :19];
}

- (IBAction)MAP20 {
    [self playMap:gameSelected :0 :20];
}

- (IBAction)MAP21 {
    [self playMap:gameSelected :0 :21];
}

- (IBAction)MAP22 {
    [self playMap:gameSelected :0 :22];
}

- (IBAction)MAP23 {
    [self playMap:gameSelected :0 :23];
}

- (IBAction)MAP24 {
    [self playMap:gameSelected :0 :24];
}

- (IBAction)MAP25 {
    [self playMap:gameSelected :0 :25];
}

- (IBAction)MAP26 {
    [self playMap:gameSelected :0 :26];
}

- (IBAction)MAP27 {
    [self playMap:gameSelected :0 :27];
}

- (IBAction)MAP28 {
    [self playMap:gameSelected :0 :28];
}

- (IBAction)MAP29 {
    [self playMap:gameSelected :0 :29];
}

- (IBAction)MAP30 {
    [self playMap:gameSelected :0 :30];
}

- (IBAction)MAP31 {
    [self playMap:gameSelected :0 :31];
}

- (IBAction)MAP32 {
    [self playMap:gameSelected :0 :32];
}


@end
