classdef DisplayableHandle < handle
  % A mix-in class for custom display with dispstr() and dispstrs(), for handles
  %
  % To use this, inherit from it, and define a custom dispstrs() method. It
  % will be picked up and used by dispstr() and disp(), which will also make
  % display() respect it.
  %
  % Examples:
  %
  % classdef Birthday < dispstrlib.DisplayableHandle
  %
  %     properties
  %         Month
  %         Day
  %     end
  %
  %     methods
  %         function this = Birthday(month, day)
  %             this.Month = month;
  %             this.Day = day;
  %         end
  %     end
  %
  %     methods (Access = protected)
  %         function out = dispstr_scalar(this)
  %             out = datestr(datenum(1, this.Month, this.Day), 'mmm dd');
  %         end
  %     end
  %
  % end
  %
  % See also:
  % dispstrlib.Displayable
  
  methods
    function disp(this)
      %DISP Custom display
      disp(dispstr(this));
    end
    
    function out = dispstr(this)
      %DISPSTR Custom display string
      if isscalar(this)
        strs = dispstrs(this);
        out = strs{1};
      else
        out = sprintf('%s %s', dispstrlib.internal.size2str(size(this)), class(this));
      end
    end
    
    function out = dispstrs(this)
      out = cell(size(this));
      for i = 1:numel(this)
        out{i} = dispstr_scalar(this(i));
      end
    end
    
    function error(varargin)
      args = convertDisplayablesToString(varargin);
      err = MException(args{:});
      throwAsCaller(err);
    end
    
    function warning(varargin)
      args = convertDisplayablesToString(varargin);
      warning(args{:});
    end
    
    function out = sprintf(varargin)
      args = convertDisplayablesToString(varargin);
      out = sprintf(args{:});
    end
    
    function out = fprintf(varargin)
      args = convertDisplayablesToString(varargin);
      out = sprintf(args{:});
    end
    
  end
  
  methods (Access = protected)
    function out = dispstr_scalar(this) %#ok<STOUT>
      error('jl:Unimplemented', ['Subclasses of DisplayableHandle must override ' ...
        'dispstr_scalar; %s does not'], ...
        class(this));
    end
  end
end

function out = convertDisplayablesToString(c)
mustBeA(c, 'cell');
out = c;
for i = 1:numel(c)
  if isa(c{i}, 'dispstrlib.DisplayableHandle')
    out{i} = dispstr(c{i});
  end
end
end