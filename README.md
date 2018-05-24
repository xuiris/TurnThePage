# TurnThePage
CS48 Projects Class

There are 3 unintegrated parts to be run separately. 

1.	Matching Input from Microphone to Music.
Please go to http://audiokit.io/downloads/ to download the framework needed for this project.
Open up the Microphone Analysis Folder and Microphone Analysis XCode Project in Xcode.
Click on the "Microphone Analysis" project in the left-most navigation bar. 
In the center screen, click on "General" and scroll down to "Linked Frameworks and Libraries" and add the AudioKitUI and AudioKit frameworks from your download.
Build the code and run the code, which should open up a simulator. 
To load the app, find and click on the “Music Analysis” app in the simulated iPhone.
Once the app is open, click on button “1. Load Test Music”, which will load hard coded music with the notes: “A, B, C, D, E, F, G, A”. 
Then click on “2. Start Detecting” which will boot up the microphone and display a plot that records the amplitude of your microphone input. 
When inputting audio, please use a piano and play it loudly. This website: https://www.apronus.com/music/flashpiano.htm has a piano simulator which we used for testing. 
Try playing the notes “A, B, C, D, E, F, G, A”. If those notes are played then the “Status: ” label should output that you have reached the End of Page. This demonstrates the ability to detect the musicians notes and match it to the music. 
Click “Stop” at any time you want to stop detecting. You will need to rerun the app again after clicking “Stop” if you would like to start over.

2.	UI Menu to Navigate App
Build the code within XCode and run the code, which should open up a simulator. Click on the “XYSideViewController”. Navigate around the application to find the Test Song to open, which will open up a PDF (may be slow).

3.	Parsing Music 
Build the code within XCode and run the code. It will run automatically on lauch and display each measure’s notes in a table.
