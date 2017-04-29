%% Loading subject data (data for 10 subjects up to now)  
subjnumber=input('enter subj number (check the current number of subjectnumberX.mat files in your MATLAB path) :', 's'); % change the prompt in a string and record the subject number from the command window in a variable
subjnumber=str2num(subjnumber);
    load('subjectnumber14.mat')
%         case 1
%             subjectData1=subjData;
%         case 2
%             subjectData2=subjData;
%         case 3
%             subjectData3=subjData;
%         case 4
%             subjectData4=subjData;
%         case 5
%             subjectData5=subjData;
%         case 6
%             subjectData6=subjData;
%         case 7
%             subjectData7=subjData;
%         case 8
%             subjectData8=subjData;
%         case 9
%             subjectData9=subjData;
%         case 10
%             subjectData10=subjData;
%         case 11
%             subjectData11=subjData;
%         case 12
%             subjectData12=subjData;
%         case 13
%             subjectData13=subjData;
           subjectData14=subjData; 
       %case N
       %    subjectDataN=subjectData;
       % Add another case as specified above if you collect data for
       % another subject
    clear subjData
%     meanRTs(i)=mean(eval(['subjectData',num2str(i),'.RTs'])');
%     accuracy(i)=mean(eval(['subjectData',num2str(i),'.memaccuracy'])');

% gmeanRTs=mean(meanRTs(1,:));
% gmeanaccuracy=mean(accuracy(1,:));

%% Load a structure containing all the possible strings and creates structures for each condition
load('completestrings.mat');
allStrings=struct2table(myStrings);
myCounter=1;
    for i=1:size(subjectData14,1)
        a=strcmp(eval(['subjectData',num2str(subjnumber),'.utterances(i)']),allStrings.taffabovemem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(a,1)~=0
           [row]=find(a,1);
           taffabovemem(myCounter).string=allStrings.taffabovemem{row};
           taffabovemem(myCounter).RTs=eval(['subjectData',num2str(subjnumber),'.RTs(i)']);
           taffabovemem(myCounter).accuracy=eval(['subjectData',num2str(subjnumber),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        b=strcmp(eval(['subjectData',num2str(subjnumber),'.utterances(i)']),allStrings.tnegabovemem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(b,1)~=0
           [row]=find(b,1);
           tnegabovemem(myCounter).string=allStrings.tnegabovemem{row};
           tnegabovemem(myCounter).RTs=eval(['subjectData',num2str(subjnumber),'.RTs(i)']);
           tnegabovemem(myCounter).accuracy=eval(['subjectData',num2str(subjnumber),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        c=strcmp(eval(['subjectData',num2str(subjnumber),'.utterances(i)']),allStrings.faffabovemem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(c,1)~=0
           [row]=find(c,1);
           faffabovemem(myCounter).string=allStrings.faffabovemem{row};
           faffabovemem(myCounter).RTs=eval(['subjectData',num2str(subjnumber),'.RTs(i)']);
           faffabovemem(myCounter).accuracy=eval(['subjectData',num2str(subjnumber),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        d=strcmp(eval(['subjectData',num2str(subjnumber),'.utterances(i)']),allStrings.fnegabovemem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(d,1)~=0
           [row]=find(d,1);
           fnegabovemem(myCounter).string=allStrings.fnegabovemem{row};
           fnegabovemem(myCounter).RTs=eval(['subjectData',num2str(subjnumber),'.RTs(i)']);
           fnegabovemem(myCounter).accuracy=eval(['subjectData',num2str(subjnumber),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        e=strcmp(eval(['subjectData',num2str(subjnumber),'.utterances(i)']),allStrings.taffbelowmem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(e,1)~=0
           [row]=find(e,1);
           taffbelowmem(myCounter).string=allStrings.taffbelowmem{row};
           taffbelowmem(myCounter).RTs=eval(['subjectData',num2str(subjnumber),'.RTs(i)']);
           taffbelowmem(myCounter).accuracy=eval(['subjectData',num2str(subjnumber),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        g=strcmp(eval(['subjectData',num2str(subjnumber),'.utterances(i)']),allStrings.tnegbelowmem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(g,1)~=0
           [row]=find(g,1);
           tnegbelowmem(myCounter).string=allStrings.tnegbelowmem{row};
           tnegbelowmem(myCounter).RTs=eval(['subjectData',num2str(subjnumber),'.RTs(i)']);
           tnegbelowmem(myCounter).accuracy=eval(['subjectData',num2str(subjnumber),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        h=strcmp(eval(['subjectData',num2str(subjnumber),'.utterances(i)']),allStrings.faffbelowmem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(h,1)~=0
           [row]=find(h,1);
           faffbelowmem(myCounter).string=allStrings.faffbelowmem{row};
           faffbelowmem(myCounter).RTs=eval(['subjectData',num2str(subjnumber),'.RTs(i)']);
           faffbelowmem(myCounter).accuracy=eval(['subjectData',num2str(subjnumber),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        l=strcmp(eval(['subjectData',num2str(subjnumber),'.utterances(i)']),allStrings.fnegbelowmem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(l,1)~=0
           [row]=find(l,1);
           fnegbelowmem(myCounter).string=allStrings.fnegbelowmem{row};
           fnegbelowmem(myCounter).RTs=eval(['subjectData',num2str(subjnumber),'.RTs(i)']);
           fnegbelowmem(myCounter).accuracy=eval(['subjectData',num2str(subjnumber),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
    end

%% Clean the structures out from any empty strings 
for i=length(taffabovemem):-1:1
    if isempty(taffabovemem(i).string)
       taffabovemem(i)=[];
    end
end
for i=length(tnegabovemem):-1:1
    if isempty(tnegabovemem(i).string)
       tnegabovemem(i)=[];
    end
end
for i=length(faffabovemem):-1:1
    if isempty(faffabovemem(i).string)
       faffabovemem(i)=[];
    end
end
for i=length(fnegabovemem):-1:1
    if isempty(fnegabovemem(i).string)
       fnegabovemem(i)=[];
    end
end
for i=length(taffbelowmem):-1:1
    if isempty(taffbelowmem(i).string)
       taffbelowmem(i)=[];
    end
end
for i=length(tnegbelowmem):-1:1
    if isempty(tnegbelowmem(i).string)
       tnegbelowmem(i)=[];
    end
end
for i=length(faffbelowmem):-1:1
    if isempty(faffbelowmem(i).string)
       faffbelowmem(i)=[];
    end
end
for i=length(fnegbelowmem):-1:1
    if isempty(fnegbelowmem(i).string)
       fnegbelowmem(i)=[];
    end
end

%% Descriptive statistics for response times
MRTstaffabovemem=mean([taffabovemem.RTs]');
Maffermative(1)=MRTstaffabovemem;
% SDVRTstaffabovemem=std([taffabovemem.RTs]');
% STDaffermative(1)=SDVRTstaffabovemem;
MRTstnegabovemem=mean([tnegabovemem.RTs]');
Mnegative(1)=MRTstnegabovemem;
% SDVRTstnegabovemem=std([tnegabovemem.RTs]');
% STDnegative(1)=SDVRTstnegabovemem;
MRTsfaffabovemem=mean([faffabovemem.RTs]');
Maffermative(2)=MRTsfaffabovemem;
% SDVRTsfaffabovemem=std([faffabovemem.RTs]');
% STDaffermative(2)=SDVRTsfaffabovemem;
MRTsfnegabovemem=mean([fnegabovemem.RTs]');
Mnegative(2)=MRTsfnegabovemem;
% SDVRTsfnegabovemem=std([fnegabovemem.RTs]');
% STDnegative(2)=SDVRTsfnegabovemem;
MRTstaffbelowmem=mean([taffbelowmem.RTs]');
Maffermative(3)=MRTstaffbelowmem;
% SDVRTstaffbelowmem=std([taffbelowmem.RTs]');
% STDaffermative(3)=SDVRTstaffbelowmem;
MRTstnegbelowmem=mean([tnegbelowmem.RTs]');
Mnegative(3)=MRTstnegbelowmem;
% SDVRTstnegbelowmem=std([tnegbelowmem.RTs]');
% STDnegative(3)=SDVRTstnegbelowmem;
MRTsfaffbelowmem=mean([faffbelowmem.RTs]'); 
Maffermative(4)=MRTsfaffbelowmem;
% SDVRTsfaffbelowmem=std([faffbelowmem.RTs]');
% STDaffermative(4)=SDVRTsfaffbelowmem;
MRTsfnegbelowmem=mean([fnegbelowmem.RTs]'); 
Mnegative(4)=MRTsfnegbelowmem;
% SDVRTsfnegbelowmem=std([fnegbelowmem.RTs]');
% STDnegative(4)=SDVRTsfnegbelowmem;

%% Bar Plot for affirmative response times
figure
affbarplot=bar(Maffermative);
hold on
xlim([0 5.5])
ylim([0 5])
set(affbarplot,'FaceColor',[.3 .7 .2]);
hold on
set(gca,'Color',[1 1 1]);
set(gca,'PlotBoxAspectRatio',[1 2 1]);
set(gca,'FontSize',22)
box off
ylabel('Response Time[s]')
set(gca,'XTickLabelRotation',45)
xticklabels({'taffabove','faffabove','taffbelow','faffbelow'})
%print('affbarplot','-dpdf','-fillpage');

%clf
%% Bar Plot for negative response times
figure
negbarplot=bar(Mnegative);
hold on
xlim([0 5.5])
ylim([0 7])
set(negbarplot,'FaceColor',[.8 .3 .2]);
hold on
set(gca,'Color',[1 1 1]);
set(gca,'PlotBoxAspectRatio',[1 2 1]);
set(gca,'FontSize',22)
box off
ylabel('Response Time[s]')
set(gca,'XTickLabelRotation',45)
xticklabels({'tnegabove','fnegabove','tnegbelow','fnegbelow'})
%print('negbarplot','-dpdf','-fillpage');

%clf
%% Descriptive statistics for accuracy
MACCtaffabovemem=mean([taffabovemem.accuracy]');
MACCaffermative(1)=MACCtaffabovemem;
% SDVACCtaffabovemem=std([taffabovemem.accuracy]');
% STDACCaffermative(1)=SDVACCtaffabovemem;
MACCtnegabovemem=mean([tnegabovemem.accuracy]');
MACCnegative(1)=MACCtnegabovemem;
% SDVACCtnegabovemem=std([tnegabovemem.accuracy]');
% STDACCnegative(1)=SDVACCtnegabovemem;
MACCfaffabovemem=mean([faffabovemem.accuracy]');
MACCaffermative(2)=MACCfaffabovemem;
% SDVACCfaffabovemem=std([faffabovemem.accuracy]');
% STDACCaffermative(2)=SDVACCfaffabovemem;
MACCfnegabovemem=mean([fnegabovemem.accuracy]');
MACCnegative(2)=MACCfnegabovemem;
% SDVACCfnegabovemem=std([fnegabovemem.accuracy]');
% STDACCnegative(2)=SDVACCfnegabovemem;
MACCtaffbelowmem=mean([taffbelowmem.accuracy]');
MACCaffermative(3)=MACCtaffbelowmem;
% SDVACCtaffbelowmem=std([taffbelowmem.accuracy]');
% STDACCaffermative(3)=SDVACCtaffbelowmem;
MACCtnegbelowmem=mean([tnegbelowmem.accuracy]');
MACCnegative(3)=MACCtnegbelowmem;
% SDVACCtnegbelowmem=std([tnegbelowmem.accuracy]');
% STDACCnegative(3)=SDVACCtnegbelowmem;
MACCfaffbelowmem=mean([faffbelowmem.accuracy]'); 
MACCaffermative(4)=MACCfaffbelowmem;
% SDVACCfaffbelowmem=std([faffbelowmem.accuracy]');
% STDACCaffermative(4)=SDVACCfaffbelowmem;
MACCfnegbelowmem=mean([fnegbelowmem.accuracy]'); 
MACCnegative(4)=MACCfnegbelowmem;
% SDVACCfnegbelowmem=std([fnegbelowmem.accuracy]');
% STDACCnegative(4)=SDVACCfnegbelowmem;

%% Bar Plot for affirmative accuracy
figure
affaccuracy=bar(MACCaffermative);
hold on
xlim([0 5])
ylim([0 1.3])
set(affaccuracy,'FaceColor',[.3 .7 .2]);
hold on
set(gca,'Color',[1 1 1]);
set(gca,'PlotBoxAspectRatio',[1 2 1]);
set(gca,'FontSize',22)
box off
ylabel('Accuracy [%]')
set(gca,'XTickLabelRotation',45)
xticklabels({'taffabove','faffabove','taffbelow','faffbelow'})
%print('affaccuracy','-dpdf','-fillpage');

%clf
%% Bar Plot for negative accuracy
figure
negaccuracy=bar(MACCnegative);
hold on
xlim([0 5])
ylim([0 1.3])
set(negaccuracy,'FaceColor',[.8 .3 .2]);
hold on
set(gca,'Color',[1 1 1]);
set(gca,'PlotBoxAspectRatio',[1 2 1]);
set(gca,'FontSize',22)
box off
ylabel('Accuracy [%]')
set(gca,'XTickLabelRotation',45)
xticklabels({'tnegabove','fnegabove','tnegbelow','fnegbelow'})
%print('negaccuracy','-dpdf','-fillpage');
