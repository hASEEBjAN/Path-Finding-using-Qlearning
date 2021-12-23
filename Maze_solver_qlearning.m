function varargout = Maze_solver_qlearning(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Maze_solver_qlearning_OpeningFcn, ...
    'gui_OutputFcn',  @Maze_solver_qlearning_OutputFcn, ...
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


% --- Executes just before Maze_solver_qlearning is made visible.
function Maze_solver_qlearning_OpeningFcn(hObject, ~, handles, varargin)

% Choose default command line output for Maze_solver_qlearning
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global maze alpha itr
maze=zeros(12); %initializing at the start of gui
alpha=1;
itr=0; %for infinite loop in run callback initialy don't do anything

% --- Outputs from this function are returned to the command line.
function varargout = Maze_solver_qlearning_OutputFcn(~, ~, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in random.
function random_Callback(~, ~, handles)
%create maze as global such that in every method it is accessible
global maze itr
itr=1; %in this callback we are going to generate random maze so also go and start solving when run is click
n=12; %size of maze;
maze = -50*ones(n,n); %intialize maze
for i=1:(n-3)*n
    maze(randi([1,n]),randi([1,n]))=1; %randomly specify a path blocks
end

maze(1,1) = 1; %start from first block
maze(n,n) = 10; %end on last block i-e 12x12

%display maze
axes(handles.axes1); %on axes1 in gui
imagesc(maze)  %using imagesc
colormap(winter); %having colormap
for i=1:n
    for j=1:n
        if maze(i,j)==min(maze)
            text(j,i,'X','HorizontalAlignment','center'); %put X on walls to identify in image
        end
    end
end
text(1,1,'START','HorizontalAlignment','right');  % start of maze
text(n,n,'GOAL','HorizontalAlignment','left'); %end of maze
axis off


% --- Executes on button press in create.
function create_Callback(~, ~, ~)
run('maze_create.m'); %run another gui where we create our own maze

% --- Executes on button press in load.
function load_Callback(~, ~, handles)

global maze itr %adding global variables
itr=1;  % we have maze so it can be solved
[FileName,FilePath]=uigetfile(); %geting name and location of file
ExPath = fullfile(FilePath,FileName); %combining path with file name
load(ExPath, 'maze'); %and loading variable maze from specified mat file on specified location
n=size(maze,1); %size of maze
maze(1,1) = 1; %starting position
maze(n,n) = 10; %specifying end position

axes(handles.axes1); %specifying axes of maze to display
imagesc(maze)
colormap(winter)
for i=1:n
    for j=1:n
        if maze(i,j)==min(maze)
            text(j,i,'X','HorizontalAlignment','center')
        end
    end
end
text(1,1,'START','HorizontalAlignment','right')
text(n,n,'GOAL','HorizontalAlignment','left')
axis off

% --- Executes on button press in run.
function run_Callback(~, ~, handles)
global maze alpha itr
if itr==1
    n=size(maze,1); %size of maze
    Goal=n*n; %goal is on 12x12 i-e on 144 position
    
    %creating reward matrix
    reward=zeros(n*n); %which will be of size 144x144
    for i=1:Goal
        reward(i,:)=reshape(maze',1,Goal);
    end
    %specifying moves
    for i=1:Goal
        for j=1:Goal
            if j~=i-n  && j~=i+n  && j~=i-1 && j~=i+1 %like available moves are up, down, left and right
                reward(i,j)=-Inf;
            end
        end
    end
    %and also the path never pass
    for i=1:n:Goal
        for j=1:i+n
            if j==i+n-1 || j==i-1 || j==i-n-1  %through boundries
                reward(i,j)=-Inf;
                reward(j,i)=-Inf;
            end
        end
    end
    
    gamma = 0.9; %gamma
    q = randn(size(reward)); %initializing Q vector as random
    axes(handles.axes1); %axes for display maze updates
    
    
    while itr==1 %run till interrupt by an another button
        % Starting from start position
        cs=1;
        % Repeat until Goal state is reached
        while(1) %run till goal isn't reached
            % possible actions for the chosen state
            n_actions = find(reward(cs,:)>0);
            % choose an action at random and set it as the next state
            ns = n_actions(randi([1 length(n_actions)],1,1));
            
            % find all the possible actions for the selected state
            n_actions = find(reward(ns,:)>=0);
            
            % find the maximum q-value i.e, next state with best action
            max_q = 0;
            for j=1:length(n_actions)
                max_q = max(max_q,q(ns,n_actions(j)));
                pause(0.0000001);
            end
            
            % Update q-values as
            %q(c,a)=r(c,a)+gamma*max(q(c'a') for alpha=0
            q(cs,ns)=(1-alpha)*q(cs,ns)+alpha*(reward(cs,ns)+gamma*max_q);
            
            % Check whether the episode has completed i.e Goal has been reached
            if(cs == Goal)
                break;
            end
            % Set current state as next state
            cs=ns;
            pause(0.0001);
        end
        
        start = 1;
        move = 0;
        path = start;
        ql=q;
        while(move~=Goal)
            [~,move]=max(ql(start,:));
            
            % Deleting chances of getting stuck in small loops  (upto order of 4)
            if ismember(move,path)
                [~,x]=sort(ql(start,:),'descend');
                move=x(2);
                if ismember(move,path)
                    [~,x]=sort(ql(start,:),'descend');
                    move=x(3);
                    if ismember(move,path)
                        [~,x]=sort(ql(start,:),'descend');
                        move=x(4);
                        if ismember(move,path)
                            [~,x]=sort(ql(start,:),'descend');
                            move=x(5);
                        end
                    end
                end
            end
            
            % Appending next action/move to the path
            path=[path,move];
            start=move;
        end
        
        %defing used path block
        pmat=zeros(n,n);
        [ql, rl]=quorem(sym(path),sym(n));
        ql=double(ql);rl=double(rl);
        ql(rl~=0)=ql(rl~=0)+1;rl(rl==0)=n;
        for k=1:length(ql)
            pmat(ql(k),rl(k))=50; %as some highest values that is 50
        end
        
        %displaying maze
        imagesc(maze)
        colormap(white)
        for k=1:n
            for l=1:n
                if maze(k,l)==min(maze)
                    text(l,k,'X','HorizontalAlignment','center') % X on blocks of wall
                end
                if pmat(k,l)==50
                    text(l,k,'\bullet','Color','red','FontSize',20) % Dots on block of path selected for walk from path
                end
            end
        end
        text(1,1,'START','HorizontalAlignment','right')
        text(n,n,'GOAL','HorizontalAlignment','right')
        hold on
        imagesc(maze,'AlphaData',0.2)
        colormap(winter)
        hold off
        axis off
        drawnow;
    end
end


% --- Executes on slider movement.
function alphaval_Callback(~, ~, handles)
global alpha
alpha = get(handles.alphaval,'Value'); % getting value of alpha from slider
set(handles.alphaout,'String',num2str(alpha)); %display it on text field above slider

% --- Executes during object creation, after setting all properties.
function alphaval_CreateFcn(hObject, ~, ~)
global alpha
alpha=1;

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)

global itr
itr=0;
