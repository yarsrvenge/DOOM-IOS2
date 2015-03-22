//
//  GameMenuViewController.m
//  Doom
//
//  Created by Tobias Baumhöver on 20.03.15.
//
//

#import "GameMenuViewController.h"
#include "doomiphone.h"
#include "iphone_delegate.h"
#import "MissionMenuViewController.h"
#import "EpisodeMenuViewController.h"
#import "MainNavController.h"
/*
 ================================================================================================
 GameMenuViewController
 
 ================================================================================================
 */
@implementation Doom_GameMenuViewController

/*
 ========================
 Doom_GameMenuViewController::initWithNibName
 ========================
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        gameSelection = -1;
        [ nextButton setEnabled: NO ];
        [ nextLabel setEnabled: NO ];
        
    }
    return self;
}

/*
 ========================
 Doom_GameMenuViewController::didReceiveMemoryWarning
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
 Doom_GameMenuViewController::viewDidLoad
 ========================
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [ nextButton setEnabled: NO ];
    [ nextLabel setEnabled: NO ];
}

/*
 ========================
 Doom_GameMenuViewController::viewDidUnload
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
 Doom_GameMenuViewController::BackToMain
 ========================
 */
- (IBAction) BackToMain {
    
    [self.navigationController popViewControllerAnimated:NO];
    Sound_StartLocalSound( "iphone/controller_down_01_SILENCE.wav" );
}

- (void)setLoadSaveGame:(BOOL)loadGame
{
    loadSaveGame = loadGame;
}

/*
 ========================
 Doom_GameMenuViewController::NextToMissions
 ========================
 */
- (IBAction) NextToMissions {
    
    char full_iwad[1024];
    if(gameSelection == 0)
        I_FindFile( "DOOM.WAD", ".wad", full_iwad );
    else if(gameSelection == 1)
        I_FindFile( "DOOM2.WAD", ".wad", full_iwad );
    else if(gameSelection == 2)
        I_FindFile( "TNT.WAD", ".wad", full_iwad );
    else
        I_FindFile( "PLUTONIA.WAD", ".wad", full_iwad );
    
    // if there is a running game, but we now switched to another one reset levelHasBeenLoaded
    if(gameType != gameSelection)
        levelHasBeenLoaded = false;
    
    gameType = gameSelection;
    
    iphoneDoomStartup( full_iwad, NULL );
    
    if(loadSaveGame)
    {
        [ gAppDelegate ShowGLView ];
        
        ResumeGame();
        
        Sound_StartLocalSound( "iphone/baborted_01.wav" );
        
        return;
    }
    else
    {
        if(gameSelection == 0)
        {
            Doom_EpisodeMenuViewController *vc = [[Doom_EpisodeMenuViewController alloc] initWithNibName:GetNibNameForDevice(@"EpisodeMenuView") bundle:nil];
            
            [self.navigationController pushViewController:vc animated:NO];
            
            [vc release];
        }
        else
        {
            Doom_MissionMenuViewController *vc = [[Doom_MissionMenuViewController alloc] initWithNibName:GetNibNameForDevice(@"MissionMenuView") bundle:nil];
            
            [self.navigationController pushViewController:vc animated:NO];
            
            [vc setGame:gameSelection];
            [vc setEpisode:0];
            [vc release];
        }
        
        
    }
    
    Sound_StartLocalSound( "iphone/controller_down_01_SILENCE.wav" );
}

/*
 ========================
 Doom_GameMenuViewController::SelectEpisode1
 ========================
 */
- (IBAction) SelectDoom {
    
    [ nextButton setEnabled: YES ];
    [ nextLabel setEnabled: YES ];
    gameSelection = 0;
    [ doomButton setEnabled: NO ];
    [ doom2Button setEnabled: YES ];
    [ finalDoomTntButton setEnabled: YES ];
    [ finalDoomPlutoniaButton setEnabled: YES ];
}

/*
 ========================
 Doom_GameMenuViewController::SelectEpisode2
 ========================
 */
- (IBAction) SelectDoom2 {
    [ nextButton setEnabled: YES ];
    [ nextLabel setEnabled: YES ];
    gameSelection = 1;
    [ doomButton setEnabled: YES ];
    [ doom2Button setEnabled: NO ];
    [ finalDoomTntButton setEnabled: YES ];
    [ finalDoomPlutoniaButton setEnabled: YES ];
}

/*
 ========================
 Doom_GameMenuViewController::SelectEpisode3
 ========================
 */
- (IBAction) SelectFinalDoomTnt {
    [ nextButton setEnabled: YES ];
    [ nextLabel setEnabled: YES ];
    gameSelection = 2;
    [ doomButton setEnabled: YES ];
    [ doom2Button setEnabled: YES ];
    [ finalDoomTntButton setEnabled: NO ];
    [ finalDoomPlutoniaButton setEnabled: YES ];
}

/*
 ========================
 Doom_GameMenuViewController::SelectEpisode4
 ========================
 */
- (IBAction) SelectFinalDoomPlutiona{
    [ nextButton setEnabled: YES ];
    [ nextLabel setEnabled: YES ];
    gameSelection = 3;
    [ doomButton setEnabled: YES ];
    [ doom2Button setEnabled: YES ];
    [ finalDoomTntButton setEnabled: YES ];
    [ finalDoomPlutoniaButton setEnabled: NO ];
}

@end