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

#import <UIKit/UIKit.h>
#import "ios/Label.h"
#import "ios/LabelButton.h"
/*
 ================================================================================================
 Doom_MissionMenuViewController
 
 ================================================================================================
 */
@interface Doom_MissionMenuViewController : UIViewController {
    
    IBOutlet UIScrollView * mapScroller1;
    IBOutlet UIScrollView * mapScroller2;
    IBOutlet UIScrollView * mapScroller3;
    IBOutlet UIScrollView * mapScroller4;
    IBOutlet UIScrollView * mapScroller5;
    IBOutlet UIScrollView * mapScroller6;
    IBOutlet UIScrollView * mapScroller7;

    
    IBOutlet UIButton *     lastElement1;
    IBOutlet UIButton *     lastElement2;
    IBOutlet UIButton *     lastElement3;
    IBOutlet UIButton *     lastElement4;
    IBOutlet UIButton *     lastElement5;
    IBOutlet UIButton *     lastElement6;
    IBOutlet UIButton *     lastElement7;
    
    
    IBOutlet UIImageView *   easySelection;
    IBOutlet UIImageView *   mediumSelection;
    IBOutlet UIImageView *   hardSelection;
    IBOutlet UIImageView *   NightmareSelection;
    
    UIScrollView * selectedScroller;
    
    IBOutlet idLabel *  easySelectionLabel;
    IBOutlet idLabel *  mediumSelectionLabel;
    IBOutlet idLabel *  hardSelectionLabel;
    IBOutlet idLabel *  nightmareSelectionLabel;
    
    IBOutlet idLabelButton * playButton;
    IBOutlet idLabel * playLabel;
    
    idLabelButton    * selectedMap;
    int gameSelected;
    int episodeSelected;
    int mapSelected;
}

- (int)  getSkill;
- (void) playMap:(int)dataset
				:(int)episode
				:(int)map;

- (void) setEpisode: (int) episode;
- (void) setGame: (int) game;

-(IBAction)     BackPressed;
-(IBAction)     Play;

-(IBAction)     UpMission;
-(IBAction)     DownMission;

// Difficulty Setting
-(IBAction)     EasyPressed;
-(IBAction)     MediumPressed;
-(IBAction)     HardPressed;
-(IBAction)     NightmarePressed;


// DOOM EPISODES
-(IBAction)     E1M1;
-(IBAction)     E1M2;
-(IBAction)     E1M3;
-(IBAction)     E1M4;
-(IBAction)     E1M5;
-(IBAction)     E1M6;
-(IBAction)     E1M7;
-(IBAction)     E1M8;
-(IBAction)     E1M9;

-(IBAction)     E2M1;
-(IBAction)     E2M2;
-(IBAction)     E2M3;
-(IBAction)     E2M4;
-(IBAction)     E2M5;
-(IBAction)     E2M6;
-(IBAction)     E2M7;
-(IBAction)     E2M8;
-(IBAction)     E2M9;

-(IBAction)     E3M1;
-(IBAction)     E3M2;
-(IBAction)     E3M3;
-(IBAction)     E3M4;
-(IBAction)     E3M5;
-(IBAction)     E3M6;
-(IBAction)     E3M7;
-(IBAction)     E3M8;
-(IBAction)     E3M9;

-(IBAction)     E4M1;
-(IBAction)     E4M2;
-(IBAction)     E4M3;
-(IBAction)     E4M4;
-(IBAction)     E4M5;
-(IBAction)     E4M6;
-(IBAction)     E4M7;
-(IBAction)     E4M8;
-(IBAction)     E4M9;

- (IBAction)MAP01;
- (IBAction)MAP02;
- (IBAction)MAP03;
- (IBAction)MAP04;
- (IBAction)MAP05;
- (IBAction)MAP06;
- (IBAction)MAP07;
- (IBAction)MAP08;
- (IBAction)MAP09;
- (IBAction)MAP10;
- (IBAction)MAP11;
- (IBAction)MAP12;
- (IBAction)MAP13;
- (IBAction)MAP14;
- (IBAction)MAP15;
- (IBAction)MAP16;
- (IBAction)MAP17;
- (IBAction)MAP18;
- (IBAction)MAP19;
- (IBAction)MAP20;
- (IBAction)MAP21;
- (IBAction)MAP22;
- (IBAction)MAP23;
- (IBAction)MAP24;
- (IBAction)MAP25;
- (IBAction)MAP26;
- (IBAction)MAP27;
- (IBAction)MAP28;
- (IBAction)MAP29;
- (IBAction)MAP30;
- (IBAction)MAP31;
- (IBAction)MAP32;


@end
