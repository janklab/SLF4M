function initSLF4M
%INITSLF4M Initialize SLF4M
%
% This function must be called once before you use SLF4M.
%
% Alternately, you can manually ensure that Dispstr is on the Matlab
% path. That's all the initialization does.

thisFile = mfilename('fullpath');
distDir = fileparts(fileparts(fileparts(thisFile)));
libDir = fullfile(distDir, 'lib');

if ~isempty(which('dispstr'))
  % Assume caller got Dispstr loaded themselves
else
  % Load Dispstr
  matlabLibDir = fullfile(libDir, 'matlab');
  dispstrDir = fullfile(matlabLibDir, 'dispstr', 'dispstr-1.1.1');
  addpath(fullfile(dispstrDir, 'Mcode'));
end

% Compatibility shims
% TODO: Replace "eq" logic with lt/ge logic

matlabRel = ['R' version('-release')];
shimsDir = fullfile(libDir, 'shims', 'eq', matlabRel);
if isfolder(shimsDir)
  javaShimsDir = fullfile(shimsDir, 'java');
  % TODO: Replace this with dir('.../**/*.jar') globbing logic
  subdirs = readdir(javaShimsDir);
  for iLib = 1:numel(subdirs)
    thisLibDir = fullfile(javaShimsDir, subdirs{iLib});
    files = readdir(thisLibDir);
    for iFile = 1:numel(files)
      file = files{iFile};
      if endsWith(lower(file), '.jar')
        javaaddpath(fullfile(thisLibDir, file));
      end
    end
  end
end

logger.Log4jConfigurator.configureBasicConsoleLogging()

end

function out = readdir(pth)
d = dir(pth);
d(ismember({d.name}, {'.','..'})) = [];
out = {d.name};
end