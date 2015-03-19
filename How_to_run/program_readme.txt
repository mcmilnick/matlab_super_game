Final Project Board Game -

This board game consists of two methods for running.
1 - Running as functions in Matlab

Open your diectory. Run the final_proj_gui.m. This is the main file and the rest are dependents. It is a function, which works since it is a GUI.

Once the GUI opens, you may enter names in the specified fields. If you do not you will get a prompt in matlab saying there are no players. Then use the radio buttons to decide on your choice of loading an existing board or using the generic one we provide. This goes for the die as well. If you do not supply one, random numbers will be generated. When selecting these files, you will just need to double click them.

Feel free to load in a folder for pictures to see how it works code wise, but the resulting implementation has been discontinued. It is now there for aesthetics and pride. An explanation is given in the comments. Once you are ready to play, hit the start button and let the game commence.

To exit exit a game or rid yourself of changes, press reset in the bottom left corner at any time.

If you have any diffuculties running I gaurantee it is a version thing. The GUI in Matlab is finicky based on both version of Matlab and version of windows. If you do not have x64 or Matlab 2014 the code unfortunately replaces UI controls structures with doubles. This is poor rev control on the part of Mathworks and I apologize. Ufortunately it would be insane to finish a cross platform version, as learning the underlying class structures and handles of the 2014 GUI took a really long time in and of itself.


1 - Running as an executable

You may use the executable in the nj board game exe folder in place of the .m files. This runs exactly like the Matlab version but overcomes the Matlab version issue. Unfortunately my compiler to build the executable still requires the user to have an x64.
