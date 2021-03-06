function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 29-Nov-2021 17:17:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% TRAIN THE NETWORKS WITH THE DATA SELECED
    data_selected = get(handles.popupmenu1,'Value');
    neuronal_network = get(handles.popupmenu2,'Value');

    switch data_selected
        case 1
            disp("Pick 44202");
            dataset_Trg = load('44202.mat','Trg');
            dataset_Feat = load('44202.mat','FeatVectSel');
        case 2
            disp("Pick 54802");
            dataset_Trg = load('54802.mat','Trg');
            dataset_Feat = load('54802.mat','FeatVectSel');
        case 3
            disp("Pick 63502");
            dataset_Trg = load('63502.mat','Trg');
            dataset_Feat = load('63502.mat','FeatVectSel');
        case 4
            disp("Pick 112502");
            dataset_Trg = load('112502.mat','Trg');
            dataset_Feat = load('112502.mat','FeatVectSel');
    end
    y=preprocess_target(dataset_Trg.Trg);
    
    [X_train,y_train,X_test,y_test] = train_test_split(dataset_Feat.FeatVectSel,y,0.3);
    switch neuronal_network
        case 1
            % CNN
            [X_train,y_train] = create_image_windows(X_train,y_train);
            cnn_net = create_train_cnn(X_train,y_train);
            save('cnn_network','cnn_net');
        case 2 
            % LSTM
            lstm_net = create_train_lstm(X_train,y_train);
            save('lstm_nn',"lstm_net");
        case 3
            % ShallowNN
            shallow_net = train_one_layer_feedforward_net(X_train',y_train');
            save('shallow_net.mat',"shallow_net");

    end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data_selected = get(handles.popupmenu1,'Value');
    neuronal_network = get(handles.popupmenu2,'Value');
    switch data_selected
        case 1
            dataset_Trg = load('44202.mat','Trg');
            dataset_Feat = load('44202.mat','FeatVectSel');
        case 2
            dataset_Trg = load('54802.mat','Trg');
            dataset_Feat = load('54802.mat','FeatVectSel');
        case 3
            dataset_Trg = load('63502.mat','Trg');
            dataset_Feat = load('63502.mat','FeatVectSel');
        case 4
            dataset_Trg = load('112502.mat','Trg');
            dataset_Feat = load('112502.mat','FeatVectSel');
    end
    y=preprocess_target(dataset_Trg.Trg);
    [X_train,y_train,X_test,y_test] = train_test_split(dataset_Feat.FeatVectSel,y,0.3);
    switch neuronal_network
        case 1
            % CNN
            [X_test,y_test] = create_image_windows(X_test,y_test);
            cnn_net = load('cnn_network.mat');
            cnn_predict(cnn_net.cnn_net,X_test,y_test);
        case 2 
            % LSTM
            [X_test,y_test] = create_image_windows(X_test,y_test);

            lstm_net = load('lstm_nn','lstm_net');
            cnn_predict(lstm_net.lstm_net,X_test,y_test);
        case 3
            % ShallowNN
            shallow_net = load("shallow_net.mat","shallow_net");
            y_pred = shallow_net.shallow_net(X_test');
            test = transform_probs_to_classes(y_pred);
           

    end
% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton3.
function pushbutton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over popupmenu1.
function popupmenu1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
