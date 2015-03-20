This is a fork of the original id software repository.

Currently the following changes have been made:
- merged changes from johnnyw-fork to fix build errors due to now deprecated api used (this also added bluetooth gamecontroller support, though i did not test it)
- changes made to make it build with latest XCode Version 6.2 and IOS Version 8.2 (deployment target updated to 8.2)
- fixed touch-area were out of place error for in-game controls with IOS 8 due to UIScreen is now Orientation-aware
- xcode project file now cotains missing resources (icons, pictures, font and localizatons), BUT THESE HAVE NOT BEEN COMMITTED (gitignore skips them). This is because they were not part of the orginal relase from id-software. If you have a legal copy of the IOS Doom Classic App it's easy to extract them from it. Below is an instruction how to do it:


Extract missing resources from original app-store app
=====================================================
1. Obvious, but you need to have a legal copy of the game
2. You need to have an backup of an IOS device on your PC which has the Doom Classic App installed
3. This is how it works on OSX, but i guess Windows should be more or less the same
4. Open itunes, goto "My Apps" and select the "Doom Classic" App. Right click on it and select "Show in Finder"
5. In finder the file "DOOM 2.7.ipa" will be selected. Copy this file to a temporary directory of your choice
6. Now change the type of the file from ipa to zip, by just renaming it in Finder
7. Extract the zip file
8. In the extracted folder there should be 2 folders: META-INF and Payload
9. In the Payload folder there is an file called: "Doom.app"
10. Select "Doom.app" and right click and select "Show Package content"
11. Select all png-files, one odf-file and the *.lproj folders
12. Copy these files/folders to the repository-folder: /DoomClassic/code/iphone





Contents of readme.txt:

DOOM Classic iOS v3.0 GPL source release
===============================================

This file contains the following sections:

GENERAL NOTES
LICENSE

GENERAL NOTES
=============

DOOM Classic iOS v3.0 is a free release, and can be downloaded from
http://http://www.idsoftware.com/idstuff/doom/doomclassic_ios_v30_src.zip

This source release does not contain any game data, the game data remains subject to the original EULA and applicable law.


LICENSE
=======

See COPYING.txt for the GNU GENERAL PUBLIC LICENSE.  If COPYING.txt does not accompany, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

