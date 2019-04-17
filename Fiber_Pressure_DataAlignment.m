function varargout = Fiber_Pressure_DataAlignment(varargin)
% FIBER_PRESSURE_DATAALIGNMENT MATLAB code for Fiber_Pressure_DataAlignment.fig
%      FIBER_PRESSURE_DATAALIGNMENT, by itself, creates a new FIBER_PRESSURE_DATAALIGNMENT or raises the existing
%      singleton*.
%
%      H = FIBER_PRESSURE_DATAALIGNMENT returns the handle to a new FIBER_PRESSURE_DATAALIGNMENT or the handle to
%      the existing singleton*.
%
%      FIBER_PRESSURE_DATAALIGNMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIBER_PRESSURE_DATAALIGNMENT.M with the given input arguments.
%
%      FIBER_PRESSURE_DATAALIGNMENT('Property','Value',...) creates a new FIBER_PRESSURE_DATAALIGNMENT or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fiber_Pressure_DataAlignment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      pushbuttonstop.  All inputs are passed to Fiber_Pressure_DataAlignment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fiber_Pressure_DataAlignment

% Last Modified by GUIDE v2.5 12-Apr-2019 16:55:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fiber_Pressure_DataAlignment_OpeningFcn, ...
                   'gui_OutputFcn',  @Fiber_Pressure_DataAlignment_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before Fiber_Pressure_DataAlignment is made visible.
function Fiber_Pressure_DataAlignment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fiber_Pressure_DataAlignment (see VARARGIN)

% Choose default command line output for Fiber_Pressure_DataAlignment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);

text(0.15,0.65,'Fiber Recording Together','FontSize',30);
text(0.3,0.5,'with Cystometry','FontSize',30);
text(0.65,0.35,'V1.1 (alpha)', 'FontAngle','Italic','FontSize',15);
set(gca, 'XTick', []);
set(gca, 'YTick', []);

axes(handles.axes2);
text(0.15,0.55,'Fiber Signal','FontSize',20);
set(gca, 'XTick', []);
set(gca, 'YTick', []);

axes(handles.axes3);
text(0.15,0.55,'Pressure Signal','FontSize',20);
set(gca, 'XTick', []);
set(gca, 'YTick', []);
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Fiber_Pressure_DataAlignment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fiber_Pressure_DataAlignment_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editVideoPath_Callback(hObject, eventdata, handles)
% hObject    handle to editVideoPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVideoPath as text
%        str2double(get(hObject,'String')) returns contents of editVideoPath as a double


% --- Executes during object creation, after setting all properties.
function editVideoPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVideoPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadAVI.
function LoadAVI_Callback(hObject, eventdata, handles)
% hObject    handle to LoadAVI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes1);

%load an AVI
set(handles.text13,'String','loading ...');
[filename, pathname, filterindex] = uigetfile('*.avi', 'Select an AVI file.');
if filterindex > 0
    VideoObj = VideoReader([pathname,filename]);
    set(handles.editVideoPath,'String', [pathname filename]);
    set(handles.text13,'String','file loaded');    
    % Extract video information
    handles.VideoObj=VideoObj;
    % Initialize the displaying size of video
    handles.Control.Xrange=[1, VideoObj.Width];
    handles.Control.Yrange=[1, VideoObj.Height];
    % Display the first frame
    ImageFrame = read(VideoObj, 1);    
    imagesc(ImageFrame);
    axis image;
    axis off;
        
    NumberofFrames = handles.VideoObj.NumberofFrames;
    % Initialize the sliding control of the video
    SliderStep(1) = 1/(NumberofFrames-1);
    SliderStep(2) = 2/(NumberofFrames-1);
    set(handles.ImageIndexSlider,'sliderstep',SliderStep,'max',NumberofFrames,'min',1,'Value',1);
    set(handles.FrameIndex,'String', '1');

    handles.pathname=pathname;
    handles.filename=filename;

    tempoffset = 0;% default is 5
    handles.Xrange = [tempoffset+1, VideoObj.Width-tempoffset];
    handles.Yrange = [tempoffset+1, VideoObj.Height-tempoffset];

% %     set(handles.StartTimeFrame,'String',1);
% %     set(handles.EndTimeFrame,'String',NumberofFrames);
end
set(handles.text13,'String',' ');
guidata(hObject,handles);
axes(handles.axes1);



% --- Executes on button press in PlayAVI.
function PlayAVI_Callback(hObject, eventdata, handles)
% hObject    handle to PlayAVI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes1);
cla;
set(handles.text13,'String','play movie ...');

% Check whether the Slider button is pushed
SliderButtonValue=get(handles.ImageIndexSlider,'Value');
FrameRate = handles.VideoObj.FrameRate;
NumberOfFrames=handles.VideoObj.NumberOfFrames;
% Initialize the sliding control of the video
SliderStep(1) = 1/(NumberOfFrames-1);
SliderStep(2) = 2/(NumberOfFrames-1);
set(handles.ImageIndexSlider,'sliderstep',SliderStep,'max',NumberOfFrames,'min',1,'Value',SliderButtonValue);
    
%Displaying each frame of the video    
for ImageIndex=SliderButtonValue:NumberOfFrames
%   SliderButtonValue=handles.SliderValue;    
    ImageDataFrame = read(handles.VideoObj, ImageIndex);    
    imagesc(ImageDataFrame);
    
    axis image;
    axis off;  
     
    %caculate the play time
    Time=roundn(ImageIndex/FrameRate,-3);
    StringofTime=num2str(Time);
    set(handles.editTime,'String',StringofTime);
    % Set the frame index and Image Index Slider
    set(handles.ImageIndexSlider,'Value',ImageIndex);
    set(handles.FrameIndex,'String',num2str(ImageIndex));    
     % Check whether the pause button is pushed
    PauseButtonValue=get(handles.pushbuttonPause ,'Value');
    if PauseButtonValue
        text = get(handles.pushbuttonPause, 'String');
        if strcmp(text, 'Pause') == 1
            set(handles.pushbuttonPause,'String','Continue'); 
            uiwait; 
            %waitforbuttonpress;          
            set(handles.pushbuttonPause,'Value',0);
            set(handles.pushbuttonPause,'String','Pause');         
        end            
    end
    
    % Check whether the pushbuttonstop button is pushed
    StopButtonValue=get(handles.pushbuttonStop,'Value');
    if StopButtonValue
        ImageDataFrame = read(handles.VideoObj, ImageIndex);    
        imagesc(ImageDataFrame);
        axis  image off;        
        set(handles.ImageIndexSlider,'Value',ImageIndex);
        set(handles.FrameIndex,'String',num2str(ImageIndex));        
        set(handles.pushbuttonStop,'Value',0);
        set(handles.editTime,'String',StringofTime);
        % Quit the displaying
        break;
    end 
    pause(0.001);
end

set(handles.text13,'String',' ');

guidata(hObject,handles);
axes(handles.axes1);

% --- Executes on button press in pushbuttonStop.
function pushbuttonStop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbuttonStop
guidata(hObject,handles);
set(handles.text13,'String','stop play movie... ');


% --- Executes on button press in LoadFiber.
function LoadFiber_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFiber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes2);
cla

set(handles.text13,'String','loading ...');

[filename1, pathname1, filterindex] = uigetfile('*.txt', 'Select an TXT file.');
Fs1 = str2double(get(handles.editFs1,'String')); 
set(handles.FiberPath,'String', [pathname1 filename1]);

if filterindex > 0
   Data1=importdata([pathname1 filename1]);
   StimulusData1=Data1(:,1);
   threshold1=max(StimulusData1)*0.8;
   % extract marker frame
   PosAbove=find(StimulusData1>threshold1);  
   PosAboveDiff=diff(PosAbove); 
   PosAboveDoubleDiff=diff(PosAboveDiff);
   FirstPointOfPos=find(PosAboveDoubleDiff>2*Fs1)+2;
   MarkerPositions1=PosAbove([1 FirstPointOfPos'])-1; 
   MarkerTime1=MarkerPositions1/Fs1;
   FiberData_raw=Data1(:,1); % marker and fiber have same channel 
end

% calculate delta F/F
f0=mean(FiberData_raw(MarkerPositions1+10*Fs1:end)); % 10 seconds after stimuli
FiberData=(FiberData_raw-f0)/f0; 

% plot fiber data
axes(handles.axes2);
plot((1:length(FiberData))/Fs1,FiberData,'k');
set(gca,'yLim',[mean(FiberData)*-1 mean(FiberData)*5])
xlabel('Time (s)'); 
ylabel('dF/F');
title('Fiber Data');

handles.pathname1=pathname1;
handles.filename1=filename1;
handles.FiberData=FiberData;
handles.MarkerPositions1=MarkerPositions1;
handles.threshold1=threshold1;
handles.Fs1=Fs1;

set(handles.MarkerManual1,'String',num2str(MarkerPositions1));
set(handles.text13,'String',' ');
guidata(hObject,handles);
axes(handles.axes2);



% --- Executes on button press in LoadPressure.
function LoadPressure_Callback(hObject, eventdata, handles)
% hObject    handle to LoadPressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes3);
cla

set(handles.text13,'String','loading ...');
[filename2, pathname2, filterindex] = uigetfile('*.txt', 'Select an TXT file.');

Fs2 = str2double(get(handles.editFs2,'String')); 
set(handles.PressurePath,'String', [pathname2 filename2]);
if filterindex > 0
   Data2=importdata([pathname2 filename2]);
   StimulusData2=Data2(:,2);
   PressureData=Data2(:,3);
   threshold2=max(StimulusData2)*0.8;
   % extract marker frame
   PosAbove=find(StimulusData2<threshold2);  
   PosAboveDiff=diff(PosAbove); 
   PosAboveDoubleDiff=diff(PosAboveDiff);
   FirstPointOfPos=find(PosAboveDoubleDiff>2*Fs2)+2;
   MarkerPositions2=PosAbove([1 FirstPointOfPos'])-1; 
   MarkerPositions2=MarkerPositions2(1);
   MarkerTime2=MarkerPositions2/Fs2;   
end
% plot pressure data
axes(handles.axes3);
plot((1:length(StimulusData2))/Fs2,StimulusData2,'g');
hold on
plot((1:length(PressureData))/Fs2,PressureData,'k');
xlabel('Time (s)'); 
ylabel('H2O (cm)');
title('Pressure Data');

handles.pathname2=pathname2;
handles.filename2=filename2;
handles.PressureData=PressureData;
handles.StimulusData2=StimulusData2;
handles.MarkerPositions2=MarkerPositions2;
handles.threshold2=threshold2;
handles.Fs2=Fs2;

set(handles.MarkerManual2,'String',num2str(MarkerPositions2));
set(handles.text13,'String',' ');
guidata(hObject,handles);
axes(handles.axes3);

% --- Executes on button press in DrawLight.
function DrawLight_Callback(hObject, eventdata, handles)
% hObject    handle to DrawLight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes1);

set(handles.text13,'String','Draw Light ...');

%view one image
movdata = read(handles.VideoObj, 1);    
axes(handles.axes1);
imshow(movdata);
grid on

h = imrect;
position = wait(h); 

handles.RedX = floor(position(1));
handles.RedY = floor(position(2));
handles.Width = floor(position(3));
handles.Length = floor(position(4));

guidata(hObject,handles);
axes(handles.axes1);
hold on;

pt = [handles.RedX,handles.RedY];
wSize = [handles.Width,handles.Length];
des = drawRect(movdata,pt,wSize,5);
%figure
axes(handles.axes1);
imshow(des);
%hold off;
set(handles.text13,'String',' ');    
%return;


% --- Executes on button press in MovieMarker.
function MovieMarker_Callback(hObject, eventdata, handles)
% hObject    handle to MovieMarker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes1);

set(handles.text13,'String','movie marker extrcting ... ');

MovieMarker=str2double(get(handles.MovieMarker,'String'));

if isnan(MovieMarker); 
    if exist('handles.RedX')
       set(handles.text13,'String','please push "Draw Light" button first '); 
    else
        RedX_1=handles.RedX:(handles.RedX+handles.Width);
        RedY_1=handles.RedY:(handles.RedY+handles.Length);

        FrameRate = handles.VideoObj.FrameRate;
        NumberOfFrames=handles.VideoObj.NumberOfFrames;

        rdata=zeros(1,NumberOfFrames);
        for k = 1 : FrameRate*1*60   % first 1 min
            movdata = read(handles.VideoObj, k);    
            movdata_gray=rgb2gray(movdata); 
            rdata(1,k)=squeeze(mean(mean(movdata_gray(RedY_1,RedX_1),1),2));  %delete single dimension
        end
       
        rdata_corrected=rdata;
        rdata_corrected(2:end)=diff(rdata);
        rdata_corrected(1)=0;
        % extract marker
        StimulusData3=rdata_corrected;
        threshold3=40;
        % extract marker frame
        PosAbove=find(StimulusData3>threshold3);  
        PosAboveDiff=diff(PosAbove);
        PosAboveDoubleDiff=diff(PosAboveDiff);
        FirstPointOfPos=find(PosAboveDoubleDiff>2*FrameRate)+2;
        MarkerPositions3=PosAbove([1 FirstPointOfPos']);
        MarkerPositions3=MarkerPositions3(1);
        MarkerTime3=MarkerPositions3/FrameRate;
        % light frame
        MovieMarker=MarkerPositions3; 
    end  
end

if ~isnan(MovieMarker)
    % Check whether the Slider button is pushed
    SliderButtonValue=MovieMarker;
    FrameRate = handles.VideoObj.FrameRate;
    NumberOfFrames=handles.VideoObj.NumberOfFrames;
    % Initialize the sliding control of the video
    SliderStep(1) = 1/(NumberOfFrames-1);
    SliderStep(2) = 2/(NumberOfFrames-1);
    set(handles.ImageIndexSlider,'sliderstep',SliderStep,'max',NumberOfFrames,'min',1,'Value',SliderButtonValue);

    %Displaying each frame of the video    
    ImageIndex=SliderButtonValue;      
    ImageDataFrame = read(handles.VideoObj, ImageIndex);    
    imagesc(ImageDataFrame);

    axis image;
    axis off;  

    %caculate the play time
    Time=roundn(ImageIndex/FrameRate,-3);
    StringofTime=num2str(Time);
    set(handles.editTime,'String',StringofTime);
    % Set the frame index and Image Index Slider
    set(handles.ImageIndexSlider,'Value',ImageIndex);
    set(handles.FrameIndex,'String',num2str(ImageIndex));    
    set(handles.MarkerManual3,'String',num2str(MovieMarker));

    handles.MovieMarker=MovieMarker;
    set(handles.text13,'String',' ');
end

guidata(hObject,handles);
axes(handles.axes1);



% --- Executes on button press in FiberMarker.
function FiberMarker_Callback(hObject, eventdata, handles)
% hObject    handle to FiberMarker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes2);

set(handles.text13,'String','fiber marker extrcting... ');
MarkerManual1=str2double(get(handles.MarkerManual1,'String'));

hold on
x1=MarkerManual1/(handles.Fs1);
y1=max(handles.FiberData);
plot([x1 x1],[0 y1],'r-')      

set(handles.text13,'String',' ');
guidata(hObject,handles);
axes(handles.axes2);



% --- Executes on button press in PressureMarker.
function PressureMarker_Callback(hObject, eventdata, handles)
% hObject    handle to PressureMarker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes3);
hold on

set(handles.text13,'String','fiber marker extrcting... ');
MarkerManual2=str2double(get(handles.MarkerManual2,'String'));

x2=MarkerManual2/(handles.Fs2);
y2=max(handles.StimulusData2);
axes(handles.axes3);
hold on
plot([x2 x2],[0 y2],'r-')     
   
set(handles.text13,'String',' ');
guidata(hObject,handles);
axes(handles.axes3);




function editTime_Callback(hObject, eventdata, handles)
% hObject    handle to editTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTime as text
%        str2double(get(hObject,'String')) returns contents of editTime as a double


% --- Executes during object creation, after setting all properties.
function editTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function ImageIndexSlider_Callback(hObject, eventdata, handles)
% hObject    handle to ImageIndexSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

guidata(hObject,handles);
SliderValue=round(get(handles.ImageIndexSlider,'Value'));

NumberofFrames = handles.VideoObj.NumberofFrames;
FrameRate=handles.VideoObj.FrameRate;
% Set the sliding control of the video
SliderStep(1) = 1/(NumberofFrames-1);
SliderStep(2) = 2/(NumberofFrames-1);
set(handles.ImageIndexSlider,'sliderstep',SliderStep,'max',NumberofFrames,'min',1,'Value',1);

% Display the image
axes(handles.axes1);
hold on
ImageDataFrame = read(handles.VideoObj, SliderValue);  
imagesc(ImageDataFrame);
axis image;
axis off;

% Set the frame index
set(handles.ImageIndexSlider,'Value',SliderValue);
set(handles.FrameIndex,'String', num2str(SliderValue));
%Set the Video Time
Time=roundn(SliderValue/FrameRate,-3);
StringofTime=num2str(Time);
set(handles.editTime,'String',StringofTime);

% display alignmented fiber data
MarkerManual1=str2double(get(handles.MarkerManual1,'String'));
MarkerManual3=str2double(get(handles.MarkerManual3,'String'));

if ~isnan(MarkerManual1)
    axes(handles.axes2);
    cla
    plot((1:length(handles.FiberData))/handles.Fs1,handles.FiberData,'k');
    hold on
    y_need=handles.FiberData(MarkerManual1+handles.Fs1*5*60:end);
    set(gca,'ylim',[min(y_need)*0.9 max(y_need)*1.2])
    set(gca,'xlim',[0 max(length(handles.FiberData)/handles.Fs1,length(handles.PressureData)/handles.Fs2)])
    xlabel('Time (s)'); 
    ylabel('dF/F');
    title('Fiber Data');    
    x1=(SliderValue-MarkerManual3)/FrameRate+MarkerManual1/handles.Fs1;
    y1=max(handles.FiberData);   
    plot([x1 x1],[min(y_need)*0.9 y1],'g-')
    hold off
end

% display alignmented pressure data
MarkerManual2=str2double(get(handles.MarkerManual2,'String'));

if ~isnan(MarkerManual2)
    axes(handles.axes3);
    cla
    plot((1:length(handles.PressureData))/handles.Fs2,handles.PressureData,'k');
    hold on
    y_need=handles.PressureData(MarkerManual2+handles.Fs2*5*60:end);
    set(gca,'ylim',[min(y_need) max(y_need)])
    set(gca,'xlim',[0 max(length(handles.FiberData)/handles.Fs1,length(handles.PressureData)/handles.Fs2)])
    xlabel('Time (s)'); 
    ylabel('H2O (cm)');
    title('Pressure Data');    
    x1=(SliderValue-MarkerManual3)/FrameRate+MarkerManual2/handles.Fs2;
    y1=max(handles.PressureData);
    plot([x1 x1],[min(y_need) y1],'g-')
    hold off
end

guidata(hObject,handles);
axes(handles.axes1);


% --- Executes during object creation, after setting all properties.
function ImageIndexSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageIndexSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function FrameIndex_Callback(hObject, eventdata, handles)
% hObject    handle to FrameIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FrameIndex as text
%        str2double(get(hObject,'String')) returns contents of FrameIndex as a double
guidata(hObject,handles);
axes(handles.axes1);

% Set the frame according to the input data
FrameofIndex=round(str2double(get(hObject,'String')));
if FrameofIndex < handles.VideoObj.NumberofFrames
    handles.Control.FrameIndex=FrameofIndex;
    
    NumberofFrames = handles.VideoObj.NumberofFrames;
    FrameRate=handles.VideoObj.FrameRate;
    % Set the sliding control of the video
    SliderStep(1) = 1/(NumberofFrames-1);
    SliderStep(2) = 2/(NumberofFrames-1);
    set(handles.ImageIndexSlider,'sliderstep',SliderStep,'max',NumberofFrames,'min',1,'Value',1);
    ImageDataFrame = read(handles.VideoObj, FrameofIndex);  
    imagesc(ImageDataFrame);
    axis image;
    axis off;
    % Set the slider
    set(handles.ImageIndexSlider,'Value',FrameofIndex);
    ImageIndexSlider_Callback(hObject, eventdata, handles);
    % Set the Video Time
    Time=roundn(FrameofIndex/FrameRate,-3);
    StringofTime=num2str(Time);
    set(handles.editTime,'String',StringofTime);
end

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function FrameIndex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrameIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FiberPath_Callback(hObject, eventdata, handles)
% hObject    handle to FiberPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FiberPath as text
%        str2double(get(hObject,'String')) returns contents of FiberPath as a double


% --- Executes during object creation, after setting all properties.
function FiberPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FiberPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PressurePath_Callback(hObject, eventdata, handles)
% hObject    handle to PressurePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PressurePath as text
%        str2double(get(hObject,'String')) returns contents of PressurePath as a double


% --- Executes during object creation, after setting all properties.
function PressurePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PressurePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function text13_Callback(hObject, eventdata, handles)
% hObject    handle to text13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text13 as text
%        str2double(get(hObject,'String')) returns contents of text13 as a double


% --- Executes during object creation, after setting all properties.
function text13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbuttonPause.
function pushbuttonPause_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
text = get(handles.pushbuttonPause, 'String');
if strcmp(text, 'Continue') == 1
    uiresume(gcf);
    set(handles.pushbuttonPause,'String','Pause'); 
end

% Hint: get(hObject,'Value') returns toggle state of pushbuttonPause



function editFs1_Callback(hObject, eventdata, handles)
% hObject    handle to editFs1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFs1 as text
%        str2double(get(hObject,'String')) returns contents of editFs1 as a double


% --- Executes during object creation, after setting all properties.
function editFs1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFs1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFs2_Callback(hObject, eventdata, handles)
% hObject    handle to editFs2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFs2 as text
%        str2double(get(hObject,'String')) returns contents of editFs2 as a double


% --- Executes during object creation, after setting all properties.
function editFs2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFs2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function MarkerManual2_Callback(hObject, eventdata, handles)
% hObject    handle to MarkerManual2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MarkerManual2 as text
%        str2double(get(hObject,'String')) returns contents of MarkerManual2 as a double


% --- Executes during object creation, after setting all properties.
function MarkerManual2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MarkerManual2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveData.
function SaveData_Callback(hObject, eventdata, handles)
% hObject    handle to SaveData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SaveData

guidata(hObject,handles);

set(handles.text13,'String','saving ...');

FrameRate = handles.VideoObj.FrameRate;

FrameIndex=str2double(get(handles.FrameIndex,'String'));
TimeLength=str2double(get(handles.TimeLength,'String'));
MarkerManual1=str2double(get(handles.MarkerManual1,'String')); %fiber
MarkerManual2=str2double(get(handles.MarkerManual2,'String')); %pressure
MarkerManual3=str2double(get(handles.MarkerManual3,'String')); %moive

FiberInd=round((FrameIndex-MarkerManual3)/FrameRate*handles.Fs1+MarkerManual1);
PressureInd=round((FrameIndex-MarkerManual3)/FrameRate*handles.Fs2+MarkerManual2);

FiberSaved=handles.FiberData(FiberInd:FiberInd+TimeLength*handles.Fs1);
PressureSaved=handles.PressureData(PressureInd:PressureInd+TimeLength*handles.Fs2);

% save as text
save([handles.pathname '\fiber_signal_' num2str(FiberInd) ' Time_' num2str(TimeLength) 's.txt'], 'FiberSaved','-ascii');
save([handles.pathname '\Pressure_signal_' num2str(PressureInd) ' Time_' num2str(TimeLength) 's.txt'], 'PressureSaved','-ascii');

set(handles.text13,'String',' ');
guidata(hObject,handles);


function MarkerManual3_Callback(hObject, eventdata, handles)
% hObject    handle to MarkerManual3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MarkerManual3 as text
%        str2double(get(hObject,'String')) returns contents of MarkerManual3 as a double


% --- Executes during object creation, after setting all properties.
function MarkerManual3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MarkerManual3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MarkerManual1_Callback(hObject, eventdata, handles)
% hObject    handle to MarkerManual1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MarkerManual1 as text
%        str2double(get(hObject,'String')) returns contents of MarkerManual1 as a double


% --- Executes during object creation, after setting all properties.
function MarkerManual1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MarkerManual1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TimeLength_Callback(hObject, eventdata, handles)
% hObject    handle to TimeLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeLength as text
%        str2double(get(hObject,'String')) returns contents of TimeLength as a double


% --- Executes during object creation, after setting all properties.
function TimeLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Filter.
function Filter_Callback(hObject, eventdata, handles)
% hObject    handle to Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Filter
guidata(hObject,handles);
axes(handles.axes2);
cla
set(handles.text13,'String','Filtering... ');
% filter
Fs_filter=str2double(get(handles.FilterFrequency,'String'));
y1=handles.FiberData;
[fb,fa] = butter(3,Fs_filter*2/handles.Fs1,'low');
y1 = filtfilt(fb,fa,y1);
filteredData=y1;
FiberData=filteredData;
% plot
axes(handles.axes2);
plot((1:length(FiberData))/handles.Fs1,FiberData,'k');
set(gca,'yLim',[mean(FiberData)*-1 mean(FiberData)*5])
xlabel('Time (s)'); 
ylabel('dF/F');
title('Fiber Data');
       
handles.FiberData=FiberData;
set(handles.text13,'String',' ');
guidata(hObject,handles);



% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ss=questdlg('Are you sure you want to exit?','Exit Message Window?','No, I still want to use it!','Yes, I want to quit!','Yes, I want to quit!');
switch ss
    case 'Yes, I want to quit!'
        delete(handles.figure1);
end


% --- Executes on button press in BaselineCorrection.
function BaselineCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to BaselineCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles);
axes(handles.axes2);
cla
set(handles.text13,'String','Baseline Correction ...');
% baseline correction
     
y=handles.FiberData(handles.MarkerPositions1+10*handles.Fs1:end); % 10 seconds after stimuli
frame=(1:length(y))';
opol = 6;
[p,~,mu] = polyfit(frame,y,opol); 
f_y = polyval(p, frame,[],mu); 
dt_ecgnl = y - f_y+mean(f_y);
FiberData= [handles.FiberData(1:handles.MarkerPositions1+10*handles.Fs1-1);dt_ecgnl];

% plot
axes(handles.axes2);
plot((1:length(FiberData))/handles.Fs1,FiberData,'k');
hold on
set(gca,'yLim',[mean(FiberData)*-1 mean(FiberData)*5])
xlabel('Time (s)'); 
ylabel('dF/F');
title('Fiber Data');    

set(handles.text13,'String',' ');

handles.FiberData=FiberData;
axes(handles.axes3);
guidata(hObject,handles);



function FilterFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to FilterFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FilterFrequency as text
%        str2double(get(hObject,'String')) returns contents of FilterFrequency as a double


% --- Executes during object creation, after setting all properties.
function FilterFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilterFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
