%{

    file_name: DataProcessingAssignment2
    author: Francesco Mantegna
    studentID: 188824
    date: 11/04/2017
    course: Computational Skills For Cognitive Science
    assignment n?: 2

%}

%% Loading subject data (data for 10 subjects up to now)  
subjnumber=input('enter subj number (check the current number of subjectnumberX.mat files in your MATLAB path) :', 's'); % change the prompt in a string and record the subject number from the command window in a variable
subjnumber=str2num(subjnumber);
for i=1:subjnumber(1)
    load(['subjectnumber',num2str(i),'.mat'])
    switch i
        case 1
            subjectData1=subjData;
        case 2
            subjectData2=subjData;
        case 3
            subjectData3=subjData;
        case 4
            subjectData4=subjData;
        case 5
            subjectData5=subjData;
        case 6
            subjectData6=subjData;
        case 7
            subjectData7=subjData;
        case 8
            subjectData8=subjData;
        case 9
            subjectData9=subjData;
        case 10
            subjectData10=subjData;
       %case N
       %    subjectDataN=subjectData;
       % Add another case as specified above if you collect data for
       % another subject
    end
    clear subjData
    meanRTs(i)=mean(eval(['subjectData',num2str(i),'.RTs'])');
    accuracy(i)=mean(eval(['subjectData',num2str(i),'.memaccuracy'])');
end
gmeanRTs=mean(meanRTs(1,:));
gmeanaccuracy=mean(accuracy(1,:));

%% Load a structure containing all the possible strings and creates structures for each condition
load('completestrings.mat');
allStrings=struct2table(myStrings);
myCounter=1;
for p=1:subjnumber(1)
    for i=1:size(subjectData1,1)
        a=strcmp(eval(['subjectData',num2str(p),'.utterances(i)']),allStrings.taffabovemem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(a,1)~=0
           [row]=find(a,1);
           taffabovemem(myCounter).string=allStrings.taffabovemem{row};
           taffabovemem(myCounter).RTs=eval(['subjectData',num2str(p),'.RTs(i)']);
           taffabovemem(myCounter).accuracy=eval(['subjectData',num2str(p),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        b=strcmp(eval(['subjectData',num2str(p),'.utterances(i)']),allStrings.tnegabovemem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(b,1)~=0
           [row]=find(b,1);
           tnegabovemem(myCounter).string=allStrings.tnegabovemem{row};
           tnegabovemem(myCounter).RTs=eval(['subjectData',num2str(p),'.RTs(i)']);
           tnegabovemem(myCounter).accuracy=eval(['subjectData',num2str(p),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        c=strcmp(eval(['subjectData',num2str(p),'.utterances(i)']),allStrings.faffabovemem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(c,1)~=0
           [row]=find(c,1);
           faffabovemem(myCounter).string=allStrings.faffabovemem{row};
           faffabovemem(myCounter).RTs=eval(['subjectData',num2str(p),'.RTs(i)']);
           faffabovemem(myCounter).accuracy=eval(['subjectData',num2str(p),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        d=strcmp(eval(['subjectData',num2str(p),'.utterances(i)']),allStrings.fnegabovemem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(d,1)~=0
           [row]=find(d,1);
           fnegabovemem(myCounter).string=allStrings.fnegabovemem{row};
           fnegabovemem(myCounter).RTs=eval(['subjectData',num2str(p),'.RTs(i)']);
           fnegabovemem(myCounter).accuracy=eval(['subjectData',num2str(p),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        e=strcmp(eval(['subjectData',num2str(p),'.utterances(i)']),allStrings.taffbelowmem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(e,1)~=0
           [row]=find(e,1);
           taffbelowmem(myCounter).string=allStrings.taffbelowmem{row};
           taffbelowmem(myCounter).RTs=eval(['subjectData',num2str(p),'.RTs(i)']);
           taffbelowmem(myCounter).accuracy=eval(['subjectData',num2str(p),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        g=strcmp(eval(['subjectData',num2str(p),'.utterances(i)']),allStrings.tnegbelowmem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(g,1)~=0
           [row]=find(g,1);
           tnegbelowmem(myCounter).string=allStrings.tnegbelowmem{row};
           tnegbelowmem(myCounter).RTs=eval(['subjectData',num2str(p),'.RTs(i)']);
           tnegbelowmem(myCounter).accuracy=eval(['subjectData',num2str(p),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        h=strcmp(eval(['subjectData',num2str(p),'.utterances(i)']),allStrings.faffbelowmem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(h,1)~=0
           [row]=find(h,1);
           faffbelowmem(myCounter).string=allStrings.faffbelowmem{row};
           faffbelowmem(myCounter).RTs=eval(['subjectData',num2str(p),'.RTs(i)']);
           faffbelowmem(myCounter).accuracy=eval(['subjectData',num2str(p),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
        l=strcmp(eval(['subjectData',num2str(p),'.utterances(i)']),allStrings.fnegbelowmem); % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
        if find(l,1)~=0
           [row]=find(l,1);
           fnegbelowmem(myCounter).string=allStrings.fnegbelowmem{row};
           fnegbelowmem(myCounter).RTs=eval(['subjectData',num2str(p),'.RTs(i)']);
           fnegbelowmem(myCounter).accuracy=eval(['subjectData',num2str(p),'.memaccuracy(i)']);
           myCounter=myCounter+1;
        end
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
SDVRTstaffabovemem=std([taffabovemem.RTs]');
STDaffermative(1)=SDVRTstaffabovemem;
MRTstnegabovemem=mean([tnegabovemem.RTs]');
Mnegative(1)=MRTstnegabovemem;
SDVRTstnegabovemem=std([tnegabovemem.RTs]');
STDnegative(1)=SDVRTstnegabovemem;
MRTsfaffabovemem=mean([faffabovemem.RTs]');
Maffermative(2)=MRTsfaffabovemem;
SDVRTsfaffabovemem=std([faffabovemem.RTs]');
STDaffermative(2)=SDVRTsfaffabovemem;
MRTsfnegabovemem=mean([fnegabovemem.RTs]');
Mnegative(2)=MRTsfnegabovemem;
SDVRTsfnegabovemem=std([fnegabovemem.RTs]');
STDnegative(2)=SDVRTsfnegabovemem;
MRTstaffbelowmem=mean([taffbelowmem.RTs]');
Maffermative(3)=MRTstaffbelowmem;
SDVRTstaffbelowmem=std([taffbelowmem.RTs]');
STDaffermative(3)=SDVRTstaffbelowmem;
MRTstnegbelowmem=mean([tnegbelowmem.RTs]');
Mnegative(3)=MRTstnegbelowmem;
SDVRTstnegbelowmem=std([tnegbelowmem.RTs]');
STDnegative(3)=SDVRTstnegbelowmem;
MRTsfaffbelowmem=mean([faffbelowmem.RTs]'); 
Maffermative(4)=MRTsfaffbelowmem;
SDVRTsfaffbelowmem=std([faffbelowmem.RTs]');
STDaffermative(4)=SDVRTsfaffbelowmem;
MRTsfnegbelowmem=mean([fnegbelowmem.RTs]'); 
Mnegative(4)=MRTsfnegbelowmem;
SDVRTsfnegbelowmem=std([fnegbelowmem.RTs]');
STDnegative(4)=SDVRTsfnegbelowmem;

%% Bar Plot for affirmative response times
figure
subplot(2,2,1), affbarplot=bar(Maffermative);
hold on
xlim([0 5.5])
ylim([0 14])
set(affbarplot,'FaceColor',[.3 .7 .2]);
hold on
plot([1 1],[Maffermative(1)+STDaffermative(1), Maffermative(1)-STDaffermative(1)],'LineWidth',1.8,'Color','k')
hold on
plot([2 2],[Maffermative(2)+STDaffermative(2), Maffermative(2)-STDaffermative(2)],'LineWidth',1.8,'Color','k')
hold on
plot([3 3],[Maffermative(3)+STDaffermative(3), Maffermative(3)-STDaffermative(3)],'LineWidth',1.8,'Color','k')
hold on
plot([4 4],[Maffermative(4)+STDaffermative(4), Maffermative(4)-STDaffermative(4)],'LineWidth',1.8,'Color','k')
hold on
plot([.8 1.2],[Maffermative(1)+STDaffermative(1), Maffermative(1)+STDaffermative(1)],'LineWidth',1.8,'Color','k')
plot([.8 1.2],[Maffermative(1)-STDaffermative(1), Maffermative(1)-STDaffermative(1)],'LineWidth',1.8,'Color','k')
plot([1.8 2.2],[Maffermative(2)+STDaffermative(2), Maffermative(2)+STDaffermative(2)],'LineWidth',1.8,'Color','k')
plot([1.8 2.2],[Maffermative(2)-STDaffermative(2), Maffermative(2)-STDaffermative(2)],'LineWidth',1.8,'Color','k')
plot([2.8 3.2],[Maffermative(3)+STDaffermative(3), Maffermative(3)+STDaffermative(3)],'LineWidth',1.8,'Color','k')
plot([2.8 3.2],[Maffermative(3)-STDaffermative(3), Maffermative(3)-STDaffermative(3)],'LineWidth',1.8,'Color','k')
plot([3.8 4.2],[Maffermative(4)+STDaffermative(4), Maffermative(4)+STDaffermative(4)],'LineWidth',1.8,'Color','k')
plot([3.8 4.2],[Maffermative(4)-STDaffermative(4), Maffermative(4)-STDaffermative(4)],'LineWidth',2,'Color','k')
set(gca,'Color',[1 1 1]);
set(gca,'PlotBoxAspectRatio',[1 2 1]);
set(gca,'FontSize',22)
box off
ylabel('Response Time[s]')
set(gca,'ticklength', 2*get(gca,'ticklength'))
set(gca,'Tickdir', 'out')
set(gca,'XTickLabelRotation',45)
xticklabels({'taffabove','faffabove','taffbelow','faffbelow'})
% print('affbarplot','-dpdf','-fillpage');

%clf
%% Bar Plot for negative response times
% figure
subplot(2,2,2), negbarplot=bar(Mnegative);
hold on
xlim([0 5.5])
ylim([0 14])
set(negbarplot,'FaceColor',[.8 .3 .2]);
hold on
plot([1 1],[Mnegative(1)+STDnegative(1), Mnegative(1)-STDnegative(1)],'LineWidth',1.8,'Color','k')
hold on
plot([2 2],[Mnegative(2)+STDnegative(2), Mnegative(2)-STDnegative(2)],'LineWidth',1.8,'Color','k')
hold on
plot([3 3],[Mnegative(3)+STDnegative(3), Mnegative(3)-STDnegative(3)],'LineWidth',1.8,'Color','k')
hold on
plot([4 4],[Mnegative(4)+STDnegative(4), Mnegative(4)-STDnegative(4)],'LineWidth',1.8,'Color','k')
hold on
plot([.8 1.2],[Mnegative(1)+STDnegative(1), Mnegative(1)+STDnegative(1)],'LineWidth',1.8,'Color','k')
plot([.8 1.2],[Mnegative(1)-STDnegative(1), Mnegative(1)-STDnegative(1)],'LineWidth',1.8,'Color','k')
plot([1.8 2.2],[Mnegative(2)+STDnegative(2), Mnegative(2)+STDnegative(2)],'LineWidth',1.8,'Color','k')
plot([1.8 2.2],[Mnegative(2)-STDnegative(2), Mnegative(2)-STDnegative(2)],'LineWidth',1.8,'Color','k')
plot([2.8 3.2],[Mnegative(3)+STDnegative(3), Mnegative(3)+STDnegative(3)],'LineWidth',1.8,'Color','k')
plot([2.8 3.2],[Mnegative(3)-STDnegative(3), Mnegative(3)-STDnegative(3)],'LineWidth',1.8,'Color','k')
plot([3.8 4.2],[Mnegative(4)+STDnegative(4), Mnegative(4)+STDnegative(4)],'LineWidth',1.8,'Color','k')
plot([3.8 4.2],[Mnegative(4)-STDnegative(4), Mnegative(4)-STDnegative(4)],'LineWidth',2,'Color','k')
set(gca,'Color',[1 1 1]);
set(gca,'PlotBoxAspectRatio',[1 2 1]);
set(gca,'FontSize',22)
box off
ylabel('Response Time[s]')
set(gca,'ticklength', 2*get(gca,'ticklength'))
set(gca,'Tickdir', 'out')
set(gca,'XTickLabelRotation',45)
xticklabels({'tnegabove','fnegabove','tnegbelow','fnegbelow'})
% print('negbarplot','-dpdf','-fillpage');

%clf
%% Descriptive statistics for accuracy
MACCtaffabovemem=mean([taffabovemem.accuracy]');
MACCaffermative(1)=MACCtaffabovemem;
SDVACCtaffabovemem=std([taffabovemem.accuracy]');
STDACCaffermative(1)=SDVACCtaffabovemem;
MACCtnegabovemem=mean([tnegabovemem.accuracy]');
MACCnegative(1)=MACCtnegabovemem;
SDVACCtnegabovemem=std([tnegabovemem.accuracy]');
STDACCnegative(1)=SDVACCtnegabovemem;
MACCfaffabovemem=mean([faffabovemem.accuracy]');
MACCaffermative(2)=MACCfaffabovemem;
SDVACCfaffabovemem=std([faffabovemem.accuracy]');
STDACCaffermative(2)=SDVACCfaffabovemem;
MACCfnegabovemem=mean([fnegabovemem.accuracy]');
MACCnegative(2)=MACCfnegabovemem;
SDVACCfnegabovemem=std([fnegabovemem.accuracy]');
STDACCnegative(2)=SDVACCfnegabovemem;
MACCtaffbelowmem=mean([taffbelowmem.accuracy]');
MACCaffermative(3)=MACCtaffbelowmem;
SDVACCtaffbelowmem=std([taffbelowmem.accuracy]');
STDACCaffermative(3)=SDVACCtaffbelowmem;
MACCtnegbelowmem=mean([tnegbelowmem.accuracy]');
MACCnegative(3)=MACCtnegbelowmem;
SDVACCtnegbelowmem=std([tnegbelowmem.accuracy]');
STDACCnegative(3)=SDVACCtnegbelowmem;
MACCfaffbelowmem=mean([faffbelowmem.accuracy]'); 
MACCaffermative(4)=MACCfaffbelowmem;
SDVACCfaffbelowmem=std([faffbelowmem.accuracy]');
STDACCaffermative(4)=SDVACCfaffbelowmem;
MACCfnegbelowmem=mean([fnegbelowmem.accuracy]'); 
MACCnegative(4)=MACCfnegbelowmem;
SDVACCfnegbelowmem=std([fnegbelowmem.accuracy]');
STDACCnegative(4)=SDVACCfnegbelowmem;

%% Bar Plot for affirmative accuracy
% figure
subplot(2,2,3), affaccuracy=bar(MACCaffermative);
hold on
xlim([0 5])
ylim([0 1.3])
set(affaccuracy,'FaceColor',[.3 .7 .2]);
hold on
plot([1 1],[MACCaffermative(1)+STDACCaffermative(1), MACCaffermative(1)-STDACCaffermative(1)],'LineWidth',1.8,'Color','k')
hold on
plot([2 2],[MACCaffermative(2)+STDACCaffermative(2), MACCaffermative(2)-STDACCaffermative(2)],'LineWidth',1.8,'Color','k')
hold on
plot([3 3],[MACCaffermative(3)+STDACCaffermative(3), MACCaffermative(3)-STDACCaffermative(3)],'LineWidth',1.8,'Color','k')
hold on
plot([4 4],[MACCaffermative(4)+STDACCaffermative(4), MACCaffermative(4)-STDACCaffermative(4)],'LineWidth',1.8,'Color','k')
hold on
plot([.8 1.2],[MACCaffermative(1)+STDACCaffermative(1), MACCaffermative(1)+STDACCaffermative(1)],'LineWidth',1.8,'Color','k')
plot([.8 1.2],[MACCaffermative(1)-STDACCaffermative(1), MACCaffermative(1)-STDACCaffermative(1)],'LineWidth',1.8,'Color','k')
plot([1.8 2.2],[MACCaffermative(2)+STDACCaffermative(2), MACCaffermative(2)+STDACCaffermative(2)],'LineWidth',1.8,'Color','k')
plot([1.8 2.2],[MACCaffermative(2)-STDACCaffermative(2), MACCaffermative(2)-STDACCaffermative(2)],'LineWidth',1.8,'Color','k')
plot([2.8 3.2],[MACCaffermative(3)+STDACCaffermative(3), MACCaffermative(3)+STDACCaffermative(3)],'LineWidth',1.8,'Color','k')
plot([2.8 3.2],[MACCaffermative(3)-STDACCaffermative(3), MACCaffermative(3)-STDACCaffermative(3)],'LineWidth',1.8,'Color','k')
plot([3.8 4.2],[MACCaffermative(4)+STDACCaffermative(4), MACCaffermative(4)+STDACCaffermative(4)],'LineWidth',1.8,'Color','k')
plot([3.8 4.2],[MACCaffermative(4)-STDACCaffermative(4), MACCaffermative(4)-STDACCaffermative(4)],'LineWidth',2,'Color','k')
set(gca,'Color',[1 1 1]);
set(gca,'PlotBoxAspectRatio',[1 2 1]);
set(gca,'FontSize',22)
box off
ylabel('Accuracy [%]')
set(gca,'ticklength', 2*get(gca,'ticklength'))
set(gca,'Tickdir', 'out')
set(gca,'XTickLabelRotation',45)
xticklabels({'taffabove','faffabove','taffbelow','faffbelow'})
% print('affaccuracy','-dpdf','-fillpage');

%clf
%% Bar Plot for negative accuracy
% figure
subplot(2,2,4), negaccuracy=bar(MACCnegative);
hold on
xlim([0 5])
ylim([0 1.3])
set(negaccuracy,'FaceColor',[.8 .3 .2]);
hold on
plot([1 1],[MACCnegative(1)+STDACCnegative(1), MACCnegative(1)-STDACCnegative(1)],'LineWidth',1.8,'Color','k')
hold on
plot([2 2],[MACCnegative(2)+STDACCnegative(2), MACCnegative(2)-STDACCnegative(2)],'LineWidth',1.8,'Color','k')
hold on
plot([3 3],[MACCnegative(3)+STDACCnegative(3), MACCnegative(3)-STDACCnegative(3)],'LineWidth',1.8,'Color','k')
hold on
plot([4 4],[MACCnegative(4)+STDACCnegative(4), MACCnegative(4)-STDACCnegative(4)],'LineWidth',1.8,'Color','k')
hold on
plot([.8 1.2],[MACCnegative(1)+STDACCnegative(1), MACCnegative(1)+STDACCnegative(1)],'LineWidth',1.8,'Color','k')
plot([.8 1.2],[MACCnegative(1)-STDACCnegative(1), MACCnegative(1)-STDACCnegative(1)],'LineWidth',1.8,'Color','k')
plot([1.8 2.2],[MACCnegative(2)+STDACCnegative(2), MACCnegative(2)+STDACCnegative(2)],'LineWidth',1.8,'Color','k')
plot([1.8 2.2],[MACCnegative(2)-STDACCnegative(2), MACCnegative(2)-STDACCnegative(2)],'LineWidth',1.8,'Color','k')
plot([2.8 3.2],[MACCnegative(3)+STDACCnegative(3), MACCnegative(3)+STDACCnegative(3)],'LineWidth',1.8,'Color','k')
plot([2.8 3.2],[MACCnegative(3)-STDACCnegative(3), MACCnegative(3)-STDACCnegative(3)],'LineWidth',1.8,'Color','k')
plot([3.8 4.2],[MACCnegative(4)+STDACCnegative(4), MACCnegative(4)+STDACCnegative(4)],'LineWidth',1.8,'Color','k')
plot([3.8 4.2],[MACCnegative(4)-STDACCnegative(4), MACCnegative(4)-STDACCnegative(4)],'LineWidth',2,'Color','k')
set(gca,'Color',[1 1 1]);
set(gca,'PlotBoxAspectRatio',[1 2 1]);
set(gca,'FontSize',22)
box off
ylabel('Accuracy [%]')
set(gca,'ticklength', 2*get(gca,'ticklength'))
set(gca,'Tickdir', 'out')
set(gca,'XTickLabelRotation',45)
xticklabels({'tnegabove','fnegabove','tnegbelow','fnegbelow'})
% print('negaccuracy','-dpdf','-fillpage');

print('figure','-dpdf','-fillpage')
