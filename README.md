#Bound Breaker
An addiciting iPhone Application 

Contributors
--------
* Victor Palacios
* Matt Schroeder
* Brent Pivnik
* John Richards

Repository Layout 
---------
- Project/Bound Breaker
  - Main XCode Project
  - Framework files are for App Features
  - Bound Breaker.xcodeproj main project file for app
- MockUps
  - Original ideas for the project
- Assets
  - Assets used in the game including player/background
- Documentation
  - Doxygen Documentaion
  - Html folder is for the web version
  - autodoc.pdf is the PDF searchable version



Feature Tracking
-------
https://trello.com/b/X540gviw/boundbreaker

Requirements
-------
Xcode

Build Instructions
-------
1. Download latest Github files 
2. Open Project in XCode
3. Select Product from top menu
4. Select Build

###Automated Test
-------
To create automated test cases, one can utilize XCode’s built-in application Instruments. This application
has an Automation tool that can be used to create user gestures to ensure proper user interface. This 
tool interprets commands in Javascript format, and there is a recording tool as well as tutorials 
(https://www.youtube.com/watch?v=yvm8DyR6fLE) to help the user get familiar with UI Tests. For 
BoundBreaker, a template was created that must be placed under the traces directory. The easiest way 
to access said directory is to initialize the Automation tool and record a gesture; the default directory 
prompt is the desired directory. The file named Game.tracetemplate found under the 
BoundBreakerTests’s directory must be placed in this directory. One can then edited and/or run the 
automated tests.
