function serialDataHandler(src,~)
%serialDataHandler is a simple pass through data processnig callback.
%This is kept as light as possible so as to ensure that serial data is not
%missed.
%  
global objDatalogger;

objDatalogger.record(src);

end

