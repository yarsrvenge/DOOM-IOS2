//
//  GameMenuViewController.h
//  Doom
//
//  Created by Tobias Baumhöver on 20.03.15.
//
//
#import <UIKit/UIKit.h>
#import "ios/LabelButton.h"

/*
 ================================================================================================
GameMenuViewController
 
 ================================================================================================
 */
@interface Doom_GameMenuViewController : UIViewController {
    
    IBOutlet idLabelButton *     doomButton;
    IBOutlet idLabelButton *     doom2Button;
    IBOutlet idLabelButton *     finalDoomTntButton;
    IBOutlet idLabelButton *     finalDoomPlutoniaButton;
    
    int                         gameSelection;
    IBOutlet idLabelButton *    nextButton;
    IBOutlet idLabel *          nextLabel;
    BOOL loadSaveGame;
    
    NSString *pwad;
}

- (void) SetPwad:(NSString *)customWad;
- (void) setLoadSaveGame: (BOOL) loadGame;
- (IBAction) BackToMain;
- (IBAction) NextToMissions;


- (IBAction) SelectDoom;
- (IBAction) SelectDoom2;
- (IBAction) SelectFinalDoomTnt;
- (IBAction) SelectFinalDoomPlutonia;

@end
