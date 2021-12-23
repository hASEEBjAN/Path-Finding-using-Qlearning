function varargout = maze_create(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maze_create_OpeningFcn, ...
                   'gui_OutputFcn',  @maze_create_OutputFcn, ...
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



function maze_create_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = maze_create_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function uitable1_CreateFcn(hObject, eventdata, handles)

function pushbutton1_Callback(hObject, eventdata, handles)

global tableData
maze1=cell2mat(tableData); %take status of table to matrix
maze=-50*ones(12); %create a matrix
maze(maze1)=1; %make the paths i-e ticks positive or 1
uisave('maze') %save maze

function uitable1_CellEditCallback(hObject, eventdata, handles)

global tableData
tableData = get(hObject, 'data'); %get value or status from table
