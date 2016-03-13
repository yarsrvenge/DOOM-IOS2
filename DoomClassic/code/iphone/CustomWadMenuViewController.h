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
@interface Doom_CustomWadMenuViewController : UIViewController {
    

    IBOutlet UIScrollView * mapScroller5;
    
    UIScrollView * selectedScroller;
    
    IBOutlet idLabelButton * playButton;
    IBOutlet idLabel * playLabel;
    
    IBOutlet idLabelButton * deleteButton;
    
    idLabelButton    * selectedMap;
    int gameSelected;
    int episodeSelected;
    int mapSelected;
    UIButton *activeButton;
    NSString *selectPwad;
    BOOL loadSaveGame;
    NSString *inboxPath;
    BOOL initialized;
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

-(IBAction)     DeletePressed;



@end
