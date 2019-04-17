Fiber Recording Together with Cystometry (FRC)
FRC is an open-source MATLAB program used for synchronized recording data analysis, including fiber data, bladder pressure data and mouse behavior data. This toolbox is demonstrated in the paper *****(link:)
# Installation
1.	Extract the ZIP file (or clone the GitHub repository) somewhere you can easily reach it.
2.	Add the FRC/ folder to your path in MATLAB by e.g.,
① using the “Set Path” dialog in MATLAB;
② running the “addpath” function from your command window or startup script.
3.	Run the script GUI: FRC.m

# Usage
1.	Load Video data:
The “Load Video” function is to load a video file (such as *.avi file), and the “Play Video” function is to play video files. The “Pause” function is to pause the playing video, and the “Stop” function is to stop the playing video.
2.	Draw Marker Light:
The “Draw Marker Light” function is to draw the location of marker light in video. The larger the rectangular area is, the longer the calculation time is. 
3.	Get Movie Marker:
The “Movie Marker” function is to get the frame (or time) when the light is on. In order to shorten the calculation time, we only calculated the first two minutes of the video as default. 
4.	Load Fiber Data:
The “Load Fiber Data” function is to load a fiber recording file (*.txt file). The default sampling frequency is 2000 Hz.
5.	Data Preprocessing: 
The data preprocessing including baseline correction and filter. The “baseline correction” function is to remove baseline by polynomial fitting. The “Low-pass Filter” function is to filter the fiber data with Butterworth low-pass filter. Default sampling frequency is 20 Hz. 
6.	Fiber Marker:
The “Fiber Marker” function is to get the marker of fiber data.
7.	Load Pressure Data:
The “Load Pressure Data” function is to load a pressure data (*.txt file). The default sampling frequency is 800 Hz.
8.	Pressure Marker:
The “Pressure Marker” function is to obtain the marker of pressure data.
9.	Set markers manually:
Instead of getting the marker automatically. You can input the marker point manually.
10.	Data synchronization:
All three markers must be obtained firstly, then you only need to drag the slider to synchronize the data.
11.	Save and Exit:
The “Save Data” function is to save the information of synchronize data including fiber data and pressure data. And the “Exit” function is to end the procedure.

*The software was tested on MATLAB R2014a version.

# Contact:
Jiwei Yao (moerfusi@126.com)
Shanshan Liang (15340520947@163.com)
