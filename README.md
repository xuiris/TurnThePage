# TurnThePage
CS48 Projects Class

There are 3 unintegrated parts to be run separately. 

1.	Matching Input from Microphone to Music.
Install cocoapods: Go to your terminal and run "sudo gem install cocoapods".
Navigate within your terminal to the folder "TurnThePage/Detect Music".
In your terminal, run the command "pod install" which should create an XCode workspace, a Pods folder, and a Podfile.lock file.
Open up the Microphone Analysis XCode workspace.
Build and run the code, which should open up an IPhone simulator. 
Find and click on the “Music Analysis” app in the simulated iPhone.
Once the app is open, you are presented with a list of songs. 
Click on the song you would like to play, which will pull up a new screen displaying the sheet music.
Then click on “Start Detecting” which will boot up the microphone and display a plot of what your microphone picks up.
When inputting audio, please use a piano and play it loudly. This website: https://www.apronus.com/music/flashpiano.htm has a piano simulator which we used for testing. 
Try playing the notes on the sheet music: “A, B, C, D, E, F, G, A”. If those notes are played then the “Status: ” label should output that you have reached the End of Page. This demonstrates the ability to detect the musicians notes and match it to the music. 
Click “Stop” at any time you want to stop detecting.

2.	UI Menu to Navigate App
Build the code within XCode and run the code, which should open up a simulator. Click on the “XYSideViewController”. Navigate around the application to find the Test Song to open, which will open up a PDF (may be slow).

3.	Parsing Music 
Build the code within XCode and run the code. It will run automatically on lauch and display each measure’s notes in a table.
