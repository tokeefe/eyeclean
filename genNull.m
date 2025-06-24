function x = genNull(data,artifact,window,nits)

artifact = artifact(window);

P = 1 : length(data);

%% build array of usable indices
if min(window) == 1,
    P(length(data) - length(window) : length(data)) = [];
    P(window) = [];
elseif min(window) == length(data) - length(window),
    P(window(1) - length(window) : window(end)) = [];
else
    P(length(data) - length(window) : length(data)) = [];
    P(window(1) - length(window) : window(end)) = [];
end

%% Use all or random subset of indices
if ischar(nits) && strcmp(nits,'all'),
    %% using all indices
elseif isnumeric(nits),
    %% using random subset of indices
    rand('state',sum(100*clock));
    P = P(randperm(length(P)));
    try,
        P = P(1:nits);
    catch
        fprintf(1,'Cannot perform more iterations than there are available points.\n',nits);
    end 
end

%% generate the null
for j = 1 : length(P),
    currDataWin = P(j) : P(j) + length(window) - 1;
    A = [artifact; data(currDataWin)];
    [r,p] = corrcoef(A');
    x.H0(j,:) = [r(2,1) p(2,1)];
end

%% generate the null reject
A = [artifact; data(window)];
[r p] = corrcoef(A');
x.H1 = [r(2,1) p(2,1)];
