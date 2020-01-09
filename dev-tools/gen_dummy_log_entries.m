function gen_dummy_log_entries(n)
% Generate a bunch of dummy log entries
%
% Example:
% logger.Log4jConfigurator.setLevels({'foo.bar', 'DEBUG'});
% gen_dummy_log_entries

if nargin < 1 || isempty(n);  n = 50;  end

logDb = logger.Logger.getLogger('foo.bar.Database');
logAlgo = logger.Logger.getLogger('foo.bar.Algorithm');
for i = 1:n
    item = sprintf('id%d', round(rand*10000));
    te = rand * 0.15; pause(te);
    logDb.debug('Fetched data for %s in %0.03f s', item, te);
    te = rand * 0.15; pause(te);
    logAlgo.debug('Ran regression on %s in %0.03f s', item, te);
    if rand < 0.2
        logAlgo.warn('Found %d missing values in item %s', round(rand*10), item);
    end
end

end