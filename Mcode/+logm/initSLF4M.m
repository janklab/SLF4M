function initSLF4M
%INITSLF4M Initialize SLF4M
%
% This function must be called once before you use SLF4M.
%
% Alternately, you can manually ensure that Dispstr is on the Matlab
% path. That's all the initialization does.

if ~isempty(which('dispstr'))
	% Assume caller got Dispstr loaded themselves
else
	% Load Dispstr
	thisFile = mfilename('fullpath');
	distDir = fileparts(fileparts(fileparts(thisFile)));
	matLibDir = [distDir '/lib/matlab'];
	dispstrDir = [matLibDir '/dispstr-HEAD'];
	addpath([dispstrDir '/Mcode']);
end

logm.Log4jConfigurator.configureBasicConsoleLogging()
