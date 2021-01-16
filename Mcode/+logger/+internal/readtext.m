function out = readtext(file, encoding)
arguments
  file (1,1) string
  encoding (1,1) string = 'UTF-8' % TODO: auto-detect file encoding via sniffing
end
[fid,msg] = fopen(file, 'r', 'n', encoding);
if fid < 1
  error('Failed opening file %s: %s', file, msg);
end
RAII.fh = onCleanup(@() fclose(fid));
c = fread(fid, Inf, 'uint8=>char');
out = string(c');
end
