function varargout = EWLsim(varargin)
% EWLsim MATLAB code for EWLsim.fig
%      EWLsim, by itself, creates a new EWLsim or raises the existing
%      singleton*.
%
%      H = EWLsim returns the handle to a new EWLsim or the handle to
%      the existing singleton*.
%
%      EWLsim('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EWLsim.M with the given input arguments.
%
%      EWLsim('Property','Value',...) creates a new EWLsim or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EWLsim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EWLsim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help EWLsim
% Last Modified by GUIDE v2.5 02-Nov-2016 09:40:42
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EWLsim_OpeningFcn, ...
                   'gui_OutputFcn',  @EWLsim_OutputFcn, ...
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

% --- Executes just before EWLsim is made visible.
function EWLsim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EWLsim (see VARARGIN)

% Choose default command line output for EWLsim
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Clear GUI
set(handles.InfoTable,'Data',cell(0,0));
set(handles.ElecVoltagesTable,'Data',cell(0,0));
set(handles.StatusBox, 'String', '');
set(handles.errorbox, 'String', '');
set(handles.NumElectrodesMenu,'Value',1);
set(handles.LLE,'String',''); 
set(handles.L1WE,'String','');
set(handles.L2WE,'String','');
set(handles.DEP,'String','');
set(handles.DET,'String','');
set(handles.CapConst,'String','');
set(handles.LagrangeParam,'String','');
set(handles.ErrorAlert,'visible','off')
set(handles.saturationminonoff,'visible','off')
set(handles.saturationmaxonoff,'visible','off')
set(handles.saturationmin,'visible','off')
set(handles.saturationmax,'visible','off')
set(handles.saturationmax,'String','');
set(handles.saturationmin,'String','');
set(handles.saturationonoff,'Value',0);
axes(handles.ElecPlot)
cla
axes(handles.SurfPlot)
cla
axes(handles.SurfVoltPlot)
cla
%show lens description image
I = imread('Lens.png');
axes(handles.Image)
imshow(I);

% UIWAIT makes EWLsim wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = EWLsim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in NumElectrodesMenu.
function NumElectrodesMenu_Callback(hObject, eventdata, handles)
NumElecs = get(handles.NumElectrodesMenu,'Value')-1; %Set number of electrodes
set(handles.ElecVoltagesTable,'Data',cell(NumElecs,1)); %Set size of voltage input table to match number of electrodes
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns NumElectrodesMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NumElectrodesMenu

% --- Executes during object creation, after setting all properties.
function NumElectrodesMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection of no voltage surface in "select plot" buttons
function SelNoVolt_Callback(hObject, eventdata, handles)
%hide voltage applied surface plot
set(handles.SelVolt,'Value',0)
handles2hide = [handles.SurfVoltPlot;get(handles.SurfVoltPlot,'Children')];
set(handles2hide,'visible','off')
axes(handles.SurfVoltPlot)
title ''
colorbar('off')
handles2show = [handles.SurfPlot;get(handles.SurfPlot,'Children')];
set(handles2show,'visible','on')
axes(handles.SurfPlot)
% xlim([-1 1])
% ylim([-1 1])
% zlim([-1 1])
title 'Surface With No Voltages'
colorbar
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns NumElectrodesMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NumElectrodesMenu

% --- Executes during object creation, after setting all properties.
function SelNoVolt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection of voltage surface in "select plot" buttons
function SelVolt_Callback(hObject, eventdata, handles)
%hide no voltage applied surface plot
set(handles.SelNoVolt,'Value',0)
handles2hide = [handles.SurfPlot;get(handles.SurfPlot,'Children')];
set(handles2hide,'visible','off')
axes(handles.SurfPlot)
title ''
colorbar('off')
handles2show = [handles.SurfVoltPlot;get(handles.SurfVoltPlot,'Children')];
set(handles2show,'visible','on')
axes(handles.SurfVoltPlot)
% xlim([-1 1])
% ylim([-1 1])
% zlim([-1 1])
title 'Surface With Voltages Applied'
colorbar
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns NumElectrodesMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NumElectrodesMenu

% --- Executes during object creation, after setting all properties.
function SelVolt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on "Clear Values" button press.
function ClearVals_Callback(hObject, eventdata, handles)
%Clear all input areas and plots
set(handles.InfoTable,'Data',cell(0,0));
set(handles.ElecVoltagesTable,'Data',cell(0,0));
set(handles.StatusBox, 'String', '');
set(handles.errorbox, 'String', '');
set(handles.NumElectrodesMenu,'Value',1);
set(handles.LLE,'String',''); 
set(handles.L1WE,'String','');
set(handles.L2WE,'String','');
set(handles.DEP,'String','');
set(handles.DET,'String','');
set(handles.CapConst,'String','');
set(handles.LagrangeParam,'String','');
set(handles.SelNoVolt,'Value',0);
set(handles.SelVolt,'Value',0);
set(handles.saturationonoff,'Value',0);
set(handles.saturationminonoff,'Value',0);
set(handles.saturationmaxonoff,'Value',0);
set(handles.saturationmin,'String','');
set(handles.saturationmax,'String','');
set(handles.saturationminonoff,'visible','off')
set(handles.saturationmaxonoff,'visible','off')
set(handles.saturationmin,'visible','off')
set(handles.saturationmax,'visible','off')
set(handles.ErrorAlert,'visible','off')
axes(handles.ElecPlot)
cla
axes(handles.SurfPlot)
cla
title ''
colorbar('off')
axes(handles.SurfVoltPlot)
cla
title ''
colorbar('off')

% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns NumElectrodesMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NumElectrodesMenu



% --- Executes during object creation, after setting all properties.
function ClearVals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% % --- Executes on "Save Surface" button press.
% function savebtn_Callback(hObject, eventdata, handles)
% axes(handles.SurfVoltPlot)
% % [xy]=model2('XYData');
% % [z]=model2('ZData');
% dlmwrite('YourOutputFile.txt', u2, 'delimiter', ',');
% % hObject    handle to NumElectrodesMenu (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % Hints: contents = cellstr(get(hObject,'String')) returns NumElectrodesMenu contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from NumElectrodesMenu



% --- Executes during object creation, after setting all properties.
function savebtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function E1V_Callback(hObject, eventdata, handles)
% hObject    handle to E1V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E1V as text
%        str2double(get(hObject,'String')) returns contents of E1V as a double

% --- Executes during object creation, after setting all properties.
function E1V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E1V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function E2V_Callback(hObject, eventdata, handles)
% hObject    handle to E2V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E2V as text
%        str2double(get(hObject,'String')) returns contents of E2V as a double

% --- Executes during object creation, after setting all properties.
function E2V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E2V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function E3V_Callback(hObject, eventdata, handles)
% hObject    handle to E3V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E3V as text
%        str2double(get(hObject,'String')) returns contents of E3V as a double

% --- Executes during object creation, after setting all properties.
function E3V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E3V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function E4V_Callback(hObject, eventdata, handles)
% hObject    handle to E4V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E4V as text
%        str2double(get(hObject,'String')) returns contents of E4V as a double

% --- Executes during object creation, after setting all properties.
function E4V_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E4V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function LLE_Callback(hObject, eventdata, handles)
% hObject    handle to LLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LLE as text
%        str2double(get(hObject,'String')) returns contents of LLE as a double

% --- Executes during object creation, after setting all properties.
function LLE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function L1WE_Callback(hObject, eventdata, handles)
% hObject    handle to L1WE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of L1WE as text
%        str2double(get(hObject,'String')) returns contents of L1WE as a double

% --- Executes during object creation, after setting all properties.
function L1WE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L1WE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function L2WE_Callback(hObject, eventdata, handles)
% hObject    handle to L2WE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of L2WE as text
%        str2double(get(hObject,'String')) returns contents of L2WE as a double

% --- Executes during object creation, after setting all properties.
function L2WE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to L2WE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function DEP_Callback(hObject, eventdata, handles)
% hObject    handle to DEP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DEP as text
%        str2double(get(hObject,'String')) returns contents of DEP as a double

% --- Executes during object creation, after setting all properties.
function DEP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DEP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DET_Callback(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DET as text
%        str2double(get(hObject,'String')) returns contents of DET as a double

% --- Executes during object creation, after setting all properties.
function DET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function CapConst_Callback(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DET as text
%        str2double(get(hObject,'String')) returns contents of DET as a double

% --- Executes during object creation, after setting all properties.
function CapConst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function LagrangeParam_Callback(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DET as text
%        str2double(get(hObject,'String')) returns contents of DET as a double

% --- Executes during object creation, after setting all properties.
function LagrangeParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function saturationonoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on application of saturation limits
function saturationonoff_Callback(hObject, eventdata, handles)
if get(hObject,'Value')
    set(handles.saturationminonoff,'Visible','On')
    set(handles.saturationmin,'Visible','On')
    set(handles.saturationminonoff,'Value',0)
    set(handles.saturationmin,'string','')
    set(handles.saturationmaxonoff,'Visible','On')
    set(handles.saturationmax,'Visible','On')
    set(handles.saturationmaxonoff,'Value',0)
    set(handles.saturationmax,'string','')
else
    set(handles.saturationminonoff,'Visible','Off')
    set(handles.saturationmin,'Visible','Off')
    set(handles.saturationmaxonoff,'Visible','Off')
    set(handles.saturationmax,'Visible','Off')
end
% hObject    handle to NumElectrodesMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns NumElectrodesMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NumElectrodesMenu

function saturationminonoff_Callback(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
% Hints: get(hObject,'String') returns contents of DET as text
%        str2double(get(hObject,'String')) returns contents of DET as a double

% --- Executes during object creation, after setting all properties.
function saturationminonoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function saturationmin_Callback(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DET as text
%        str2double(get(hObject,'String')) returns contents of DET as a double

% --- Executes during object creation, after setting all properties.
function saturationmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function saturationmaxonoff_Callback(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DET as text
%        str2double(get(hObject,'String')) returns contents of DET as a double

% --- Executes during object creation, after setting all properties.
function saturationmaxonoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function saturationmax_Callback(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DET as text
%        str2double(get(hObject,'String')) returns contents of DET as a double

% --- Executes during object creation, after setting all properties.
function saturationmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in SIM.
function SIM_Callback(hObject, eventdata, handles)
% hObject    handle to SIM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic; %start timer
% warning('off','all') 
% uncomment ^^^ when all errors have been caught & displayed in GUI
set(handles.SelNoVolt,'Value',0) % Set select plot buttons to 
set(handles.SelVolt,'Value',1)   % Set buttons to show voltage applied surface
set(handles.errorbox, 'String', ''); %clear error box
set(handles.StatusBox, 'String', ''); %clear status box
set(handles.InfoTable,'Data',cell(0,0)); %Clear tables/plots
set(handles.ErrorAlert,'visible','off')
axes(handles.ElecPlot)
cla
axes(handles.SurfPlot)
cla
axes(handles.SurfVoltPlot)
cla
%Gather inputs
NumElecs = get(handles.NumElectrodesMenu,'Value')-1;
VoltageElec=cell2mat(get(handles.ElecVoltagesTable,'data')); 
VoltageElec(any(isnan(VoltageElec),2),:)=[];%reject any NaN input
LiqLiqIFSE = get(handles.LLE,'String'); 
Liq1WallIFSE = get(handles.L1WE,'String');
Liq2WallIFSE = get(handles.L2WE,'String');
DielecPerm = get(handles.DEP,'String');
DielecThick = get(handles.DET,'String');
CapCon = get(handles.CapConst,'String');
LParam = get(handles.LagrangeParam,'String');
minang = get(handles.saturationmin,'String');
maxang = get(handles.saturationmax,'String');


%Error Checking
    if NumElecs==0
        set(handles.errorbox, 'String', 'Select Number of Electrodes');
        set(handles.ErrorAlert,'visible','on')
    elseif size(VoltageElec,1)~=NumElecs
        set(handles.errorbox, 'String', sprintf('Missing or Invalid Voltages for %d Electrodes',NumElecs-size(VoltageElec,1)));
        set(handles.ErrorAlert,'visible','on')
    elseif isempty(LiqLiqIFSE)
        set(handles.errorbox, 'String', 'Missing Liquid1-Liquid2 Surface Energy');
        set(handles.ErrorAlert,'visible','on')
    elseif strcmp(LiqLiqIFSE,'0')
        set(handles.errorbox, 'String', 'Liquid1-Liquid2 Surface Energy Cannot Equal Zero');
        set(handles.ErrorAlert,'visible','on')
    elseif isempty(Liq1WallIFSE)
        set(handles.errorbox, 'String', 'Missing Liquid1-Wall Surface Energy');
        set(handles.ErrorAlert,'visible','on')
    elseif strcmp(Liq1WallIFSE,'0')
        set(handles.errorbox, 'String', 'Liquid1-Wall Surface Energy Cannot Equal Zero');
        set(handles.ErrorAlert,'visible','on')
    elseif isempty(Liq2WallIFSE)
        set(handles.errorbox, 'String', 'Missing Liquid2-Wall Surface Energy');
        set(handles.ErrorAlert,'visible','on')
    elseif strcmp(Liq2WallIFSE,'0')
        set(handles.errorbox, 'String', 'Liquid2-Wall Surface Energy Cannot Equal Zero');
        set(handles.ErrorAlert,'visible','on')
    elseif isempty(DielecPerm)
        set(handles.errorbox, 'String', 'Missing Dielectric Permittivity');
        set(handles.ErrorAlert,'visible','on')
    elseif strcmp(DielecPerm,'0')
        set(handles.errorbox, 'String', 'Dielectric Permittivity Cannot Equal Zero');
        set(handles.ErrorAlert,'visible','on')
    elseif isempty(DielecThick)
        set(handles.errorbox, 'String', 'Missing Dielectric Thickness');
        set(handles.ErrorAlert,'visible','on')
    elseif strcmp(DielecThick,'0')
        set(handles.errorbox, 'String', 'Dielectric Thickness Cannot Equal Zero');
        set(handles.ErrorAlert,'visible','on')
    elseif isempty(CapCon)
        set(handles.errorbox, 'String', 'Missing Capillarity Constant');
        set(handles.ErrorAlert,'visible','on')
    elseif strcmp(CapCon,'0')
        set(handles.errorbox, 'String', 'Capillarity Constant Cannot Equal Zero');
        set(handles.ErrorAlert,'visible','on')
    elseif isempty(LParam)
        set(handles.errorbox, 'String', 'Missing Lagrange Paramater');
        set(handles.ErrorAlert,'visible','on')
    elseif strcmp(LiqLiqIFSE,'i') || strcmp(LiqLiqIFSE,'j') ||...
            strcmp(Liq1WallIFSE,'i') || strcmp(Liq1WallIFSE,'j') || strcmp(Liq2WallIFSE,'i') ||...
            strcmp(Liq2WallIFSE,'j') || strcmp(DielecPerm,'i') || strcmp(DielecPerm,'j') ||...
            strcmp(DielecThick,'i') || strcmp(DielecThick,'j') || strcmp(CapCon,'i') ||...
            strcmp(CapCon,'j') || strcmp(LParam,'i') || strcmp(LParam,'j')
        set(handles.errorbox, 'String', 'Non-Numeric Input')
        set(handles.ErrorAlert,'visible','on')   
    elseif (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationminonoff,'Value')) == 1 ...
            && isempty(minang)
                set(handles.errorbox, 'String', 'Missing Saturation Minimum Angle');
                set(handles.ErrorAlert,'visible','on')
    elseif (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationminonoff,'Value')) == 1 ...
            && strcmp(minang,'i') || strcmp(minang,'j')
                set(handles.errorbox, 'String', 'Non-Numeric Saturation Input')
                set(handles.ErrorAlert,'visible','on')
    elseif (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationmaxonoff,'Value')) == 1 ... 
            && isempty(maxang)
                set(handles.errorbox, 'String', 'Missing Saturation Maximum Angle');
                set(handles.ErrorAlert,'visible','on')
    elseif (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationmaxonoff,'Value')) == 1 ...
            && strcmp(maxang,'i') || strcmp(maxang,'j')
                set(handles.errorbox, 'String', 'Non-Numeric Saturation Input')
                set(handles.ErrorAlert,'visible','on')
    elseif (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationminonoff,'Value')) == 0 ...
            && (get(handles.saturationmaxonoff,'Value')) == 0
                set(handles.errorbox, 'String', 'Select Saturation Limits to Apply')
                set(handles.ErrorAlert,'visible','on')
    else %Proceed if no errors found here
        set(handles.StatusBox, 'String', 'Simulation Running'); %Tells user simulation has started
        %Convert str variables to double
        LiqLiqIFSE = str2double(LiqLiqIFSE); 
        Liq1WallIFSE = str2double(Liq1WallIFSE);
        Liq2WallIFSE = str2double(Liq2WallIFSE);
        DielecPerm = str2double(DielecPerm);
        DielecThick = str2double(DielecThick);
        if (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationminonoff,'Value')) == 1
            minang = str2double(minang);
        end
        if (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationmaxonoff,'Value')) == 1
            maxang = str2double(maxang);
        end
    
        if LiqLiqIFSE <0 || Liq1WallIFSE <0  || Liq2WallIFSE <0
            set(handles.errorbox, 'String', 'Surface Energies Cannot Be Less Than Zero');
            set(handles.ErrorAlert,'visible','on')
            set(handles.StatusBox, 'String', '')
        elseif DielecPerm <0
            set(handles.errorbox, 'String', 'Dielectric Permittivity Cannot Be Less Than Zero');
            set(handles.ErrorAlert,'visible','on')
            set(handles.StatusBox, 'String', '')
        elseif DielecThick <0
            set(handles.errorbox, 'String', 'Dielectric Thickness Cannot Be Less Than Zero');
            set(handles.ErrorAlert,'visible','on')
            set(handles.StatusBox, 'String', '')
        else  
            InitContactAng = acosd((Liq1WallIFSE-Liq2WallIFSE)/LiqLiqIFSE); %initial contact angle from Young eqn
            
        for i=1:NumElecs
            if VoltageElec(i)==0
                ContactAngElec(i)=InitContactAng;%If no voltage is applied, contact angle is set to initial value(no voltage)
                ThetaElec(i)=((i-1)/NumElecs)*2*pi;%Locate position electrode, first always at 0 radians   
            else  
            ContactAngElec(i)=real(acosd(cosd(InitContactAng) + DielecPerm*VoltageElec(i)*VoltageElec(i)/(2*DielecThick*LiqLiqIFSE))); %(VoltageElec(i)/abs(VoltageElec(i)))*
            ThetaElec(i)=((i-1)/NumElecs)*2*pi;
                if isnan(ContactAngElec(i))==1 %Find non-numeric input error in surface energies
                    set(handles.ErrorAlert,'visible','on')
                    set(handles.errorbox,'String','Non-Numeric Input');
                    set(handles.StatusBox,'String','');
                    set(handles.InfoTable,'Data',cell(0,0));
                    axes(handles.ElecPlot)
                    cla
                    axes(handles.SurfPlot)
                    cla
                    axes(handles.SurfVoltPlot)
                    cla
                    break
                elseif (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationminonoff,'Value')) == 1 ...
                        && (ContactAngElec(i) < minang)
                            ContactAngElec(i) = minang;
                            ThetaElec(i)=((i-1)/NumElecs)*2*pi;
                elseif (get(handles.saturationonoff,'Value')) == 1 && (get(handles.saturationmaxonoff,'Value')) == 1 ...
                        && (ContactAngElec(i) > maxang)
                            ContactAngElec(i) = maxang;
                            ThetaElec(i)=((i-1)/NumElecs)*2*pi;
                end
            end
        end
      
ebox = get(handles.errorbox,'String');
if isempty(ebox) %If no errors found, begin simulation
    %Convert str variables to doubles
    CapCon = str2double(CapCon);
    LParam = str2double(LParam);
    set(handles.InfoTable,'Data',cell(2,NumElecs)); %Set size of info table
    set(handles.InfoTable,'RowName',{'Voltage';'Contact Angle'}) %Set names of rows in info table
    VoltageContact = cat(1,transpose(VoltageElec),ContactAngElec); %Concatenate voltage & contact angle
    set(handles.InfoTable,'data',VoltageContact) %Display concatenated voltage & contact angle info
    %Plot electrode distribution
    axes(handles.ElecPlot)
    pos = [-1 -1 2 2];
    rectangle('Position',pos,'Curvature',[1 1]);
    xlim([-1.75 1.75])
    ylim([-1.75 1.75])
        for i=1:NumElecs
            txt1 = sprintf('V%d=%.1f',i,VoltageElec(i));
            txt2 = sprintf('%d=%.2f ',i,ContactAngElec(i)');
            txt3 = sprintf('Initial Contact Angle = %.2f',InitContactAng);
            x=cos(ThetaElec(i));
            y=sin(ThetaElec(i));
            text(1.35*x-0.1,1.35*y,txt1);
            text(1.35*x-0.18,1.35*y-0.12,'\theta');
            text(1.35*x-0.11,1.35*y-0.12,txt2);
            text(-1.6,-1.55,txt3);
            viscircles([x y],0.05);
        end
        
%%%INITIAL SURFACE PDE
numberOfPDEs = 1; %1 PDE to be solved
%PDE: m*(par^2 u /par t^2) + d(par u /par t) - del(dot)(c*del u)+au=f
model = createpde(numberOfPDEs);
geometryFromEdges(model,@circlefunction2); %Creates circle geometry with 2 edges
cCoef = @(region,state) 1./sqrt(1+state.ux.^2 + state.uy.^2); %C coef. for capillary surface equation
%Capillary surface equation: del(dot)(del u/sqrt(1 + |del u|^2))=ku+lambda
%   u(x,y)   k=capillary constant, rho*g/sigma (dens*grav/area(?))    lambda=Lagrange parameter
% see: https://www.mathworks.com/help/pde/ug/minimal-surface-problem.html 
% see: https://people.maths.ox.ac.uk/trefethen/pdectb/capsurf2.pdf
try
    specifyCoefficients(model,'m',0,'d',0,'c',cCoef,'a',CapCon,'f',-1*LParam);
    %Specify coefficients in PDE
catch ME %check for and report error due to non-numeric input in lens parameters
    if (strcmp(ME.identifier,'pde:pdeCoefficientSpecification:invalidCoefValueNaN'))
        set(handles.ErrorAlert,'visible','on')
        set(handles.errorbox,'String','Non-Numeric Input');
        set(handles.StatusBox,'String','');
        set(handles.InfoTable,'Data',cell(0,0));
        axes(handles.ElecPlot)
        cla
    end
    rethrow(ME)
end 

applyBoundaryCondition(model,'neumann','Edge',1:model.Geometry.NumEdges,'q',0,'g',cosd(InitContactAng));
%neumann boundary condition: norm(dot)(c*del u) + qu = g
%boundary condition for cap. surface: norm(dot)(del u/sqrt(1 + |del u|^2)) = cos(contact angle)
generateMesh(model,'Hmax',0.1);

try
    result = solvepde(model);
catch ME %check for and report error due to PDE solving failure
    if (strcmp(ME.identifier,'pde:pdenonlin:TooManyIter'))
        set(handles.ErrorAlert,'visible','on')
        set(handles.errorbox,'String','Too Many Iterations on No Voltages Surface');
        set(handles.StatusBox,'String','Simulation Failed');
        set(handles.InfoTable,'Data',cell(0,0));
        axes(handles.ElecPlot)
        cla
    elseif (strcmp(ME.identifier,'pde:pdenonlin:SmallStepSize'))
        set(handles.ErrorAlert,'visible','on')
        set(handles.errorbox,'String','No Voltages Applied Simulation Stepsize Too Small');
        set(handles.StatusBox,'String','Simulation Failed');
        set(handles.InfoTable,'Data',cell(0,0));
        axes(handles.ElecPlot)
        cla
    end
    rethrow(ME)
end 

u = result.NodalSolution; 
axes(handles.SurfPlot)
pdeplot(model,'XYData',u,'ZData',u);
xlabel 'x'
xtickformat('%.0f')
ylabel 'y'
ytickformat('%.0f')
zlabel 'u(x,y)'
%hide initial surface plot so voltage applied plot shows
axes(handles.SurfPlot)
title ''
colorbar('off')
handles2hide = [handles.SurfPlot;get(handles.SurfPlot,'Children')];
set(handles2hide,'visible','off') 

%%%SURFACE AFTER VOLTAGE 
%same process as above, but applying unique contact angle bound. cond. at
%each electrode
numberOfPDEs=1; 
model2 = createpde(numberOfPDEs);

%create geometry with edge for each electrode
if NumElecs==1
geometryFromEdges(model2,@circlefunction2);
elseif NumElecs==2
geometryFromEdges(model2,@circlefunction2);
elseif NumElecs==3
geometryFromEdges(model2,@circlefunction3);
elseif NumElecs==4
geometryFromEdges(model2,@circlefunction4);
elseif NumElecs==5
geometryFromEdges(model2,@circlefunction5);
elseif NumElecs==6
geometryFromEdges(model2,@circlefunction6);
elseif NumElecs==7
geometryFromEdges(model2,@circlefunction7);
elseif NumElecs==8
geometryFromEdges(model2,@circlefunction8);
elseif NumElecs==9
geometryFromEdges(model2,@circlefunction9);
elseif NumElecs==10
geometryFromEdges(model2,@circlefunction10);
elseif NumElecs==11
geometryFromEdges(model2,@circlefunction11);
elseif NumElecs==12
geometryFromEdges(model2,@circlefunction12);
elseif NumElecs==13
geometryFromEdges(model2,@circlefunction13);
elseif NumElecs==14
geometryFromEdges(model2,@circlefunction14);
elseif NumElecs==15
geometryFromEdges(model2,@circlefunction15);
elseif NumElecs==16
geometryFromEdges(model2,@circlefunction16);
elseif NumElecs==17
geometryFromEdges(model2,@circlefunction17);
elseif NumElecs==18
geometryFromEdges(model2,@circlefunction18);
elseif NumElecs==19
geometryFromEdges(model2,@circlefunction19);
elseif NumElecs==20
geometryFromEdges(model2,@circlefunction20);
end

cCoef = @(region,state) 1./sqrt(1+state.ux.^2 + state.uy.^2);
specifyCoefficients(model2,'m',0,'d',0,'c',cCoef,'a',CapCon,'f',-1*LParam);

if NumElecs==1
    for i=1:2
        applyBoundaryCondition(model2,'neumann','Edge',i,'q',0,'g',cosd(ContactAngElec(1))); 
    end
else
    for i=1:NumElecs
        applyBoundaryCondition(model2,'neumann','Edge',i,'q',0,'g',cosd(ContactAngElec(i)));
        %apply unique contact angle at each electrode (edge)
    end
end

generateMesh(model2,'Hmax',0.1);

try
    result2 = solvepde(model2);
catch ME
    if (strcmp(ME.identifier,'pde:pdenonlin:TooManyIter'))
        set(handles.ErrorAlert,'visible','on')
        set(handles.errorbox,'String','Too Many Iterations on Voltages Applied Surface');
        set(handles.StatusBox,'String','Simulation Failed');
        set(handles.InfoTable,'Data',cell(0,0));
        axes(handles.ElecPlot)
        cla
        axes(handles.SurfPlot)
        cla
    elseif (strcmp(ME.identifier,'pde:pdenonlin:SmallStepSize'))
        set(handles.ErrorAlert,'visible','on')
        set(handles.errorbox,'String','Voltages Applied Simulation Stepsize Too Small');
        set(handles.StatusBox,'String','Simulation Failed');
        set(handles.InfoTable,'Data',cell(0,0));
        axes(handles.ElecPlot)
        cla
        axes(handles.SurfPlot)
        cla
    end
    rethrow(ME)
end 

u2 = result2.NodalSolution; 
axes(handles.SurfVoltPlot)
surf2=pdeplot(model2,'XYData',u2,'ZData',u2);
xlabel 'x'
ylabel 'y'
zlabel 'u(x,y)'
title 'Surface With Voltages Applied'
% xlim([-1 1])
% ylim([-1 1])
% zlim([-1 1])
timerVal=toc;%end timer
stat=sprintf('Simulation Complete in %.3f Seconds',timerVal);
set(handles.StatusBox, 'String',stat); %report simulation time
end
end
end