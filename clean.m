function discard = clean(data,artifact,window,nits,alpha,debug,EEG)

discard = [];

for i = 1 : size(artifact,1),
    fprintf(1,'\n\n------ ARTIFACT %d --------\n\n',i);
    for j = 1 : size(data,1),

        x = genNull(data(j,:),artifact(i,:),window,nits);        
        fprintf(1,'Analyzing Component %d: ',j);    
        results{j} = x;
        
        reject = false;
        h = ztest(x.H1(1),mean(x.H0(:,1)),std(x.H0(:,1)),.05,'both');
        if h,
            %fprintf(1,'Rejected by ztest\n');
            reject=true;
        end    
        
        if reject,
            fprintf(1,'Rejected H0 ***\n');            
            %% --- debugging
            if debug,
                figure(1);
                subplot(2,1,1);
                topoplot(EEG.icawinv(:,j),EEG.chanlocs,'style','both','electrodes','off');
                events = [];
                for k  = 1 : size(EEG.event,2),
                    if EEG.event(k).type == 2,
                        events = [events;2];
                    elseif EEG.event(k).type == 4,
                        events = [events;4];
                    end
                end

                c2l = mean(EEG.icaact(j,:,find(events==2)),3);
                c2r = mean(EEG.icaact(j,:,find(events==4)),3);

                c2l = c2l - mean(c2l(1:256));
                c2r = c2r - mean(c2r(1:256));
                subplot(2,1,2);
                plot(linspace(-500,1000,768),c2l); hold on; plot(linspace(-500,1000,768),c2r,'r');
                hold off;

                drawnow;
            end
            %% --- end debugging
            discard = [discard;j];
        else
            fprintf(1,'Accepted H0\n');
        end
    end
    art{i} = results;
end

discard = unique(discard);
