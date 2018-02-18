function out = dispstr(this)
% Custom display for database (monkeypatched)

out = sprintf('%s: %s@%s (%s)', class(this), this.UserName, this.URL, this.Driver);
end