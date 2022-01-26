function varargout = hamoud(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hamoud_OpeningFcn, ...
                   'gui_OutputFcn',  @hamoud_OutputFcn, ...
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
function hamoud_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = hamoud_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;
function pushbutton1_Callback(~, ~, handles)
m=get(handles.edit1,'string');
e=get(handles.edit2,'string');
n=get(handles.edit3,'string');
if isempty(m) ||isempty(e)||isempty(n)
    errordlg('please enter values','error')
    return
end
if get(handles.checkbox1,'value');
    len=numel(n);
   m=dec2bin(bin2dec(m),len);
   e=dec2bin(bin2dec(e),len);
   n=dec2bin(bin2dec(n),len);   
   if get(handles.opLM,'value');
    m=m(numel(m):-1:1);
    e=e(numel(e):-1:1);
    n=n(numel(n):-1:1);
   end
   m=bin2dec(m);
   e=bin2dec(e);
   n=bin2dec(n);   
else
    m=str2double(m);
    e=str2double(e);
    n=str2double(n);
end
if e<0 || ~n
    errordlg('unvalid value','error')
    return
end
tic
x=hamod(m,e,n);
z=mul_inv(x,n);
t=toc;
set(handles.text1,'string',num2str(x))
set(handles.text2,'string',num2str(t))
set(handles.texti,'string',num2str(z))
function r=hamod(m,e,n)    
    % r=m^e mod n
  e=dec2bin(e);  len=numel(e);
  e=e(numel(e):-1:1);
  len=numel(e);
  for i=1:numel(e)
    z(i)=2.^(i-1);
    need(i)=e(i)-'0';
    a=z(need>0);
  end
  r=zeros(1,len);r(1)=mod(m,n);
  for i=2:len
    r(i)=mod(r(i-1)^2,n);
  end
  ind=z;
  r=[ind;r];
  s=1;
  for i=1:numel(a)
   for j=1:len
      if a(i)==r(1,j)
           b(i)=r(2,j);
           s=mod(s*r(2,j),n);
           break
      end
   end  
  end
  r=s;
function z=mul_inv(a,m)     
if a>m , x=a; y=m; else x=m;y=a; end
r(1)=x;r(2)=y;
s(1)=1;s(2)=0;
t(1)=0;t(2)=1;
i=3;rem=1;
while rem
   q(i-1)=floor(r(i-2)/r(i-1));
   r(i)=mod(r(i-2),r(i-1));
   s(i)=s(i-2)-(q(i-1)*s(i-1));
   t(i)=t(i-2)-(q(i-1)*t(i-1));
   rem=r(i);
    i=i+1;
end
if a<m
    z=mod(t(i-2),m);
else
    z=mod(s(i-2),m);    
end
return  
  function pushbutton2_Callback(~, ~, ~)
    helpdlg({'This program is designed by  student at Tishreen university of computer and automatic control Department.'...
          '                     Mohammed Hamoud',...
          '                                 M&H'},'About')
function checkbox1_Callback(hObject, ~, handles)
if get(hObject,'Value')
    set(handles.opLM,'enable','on')
    set(handles.text9,'visible','on')
else
    set(handles.opLM,'enable','off')
    set(handles.text9,'visible','off')
end
