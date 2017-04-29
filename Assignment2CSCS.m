%{

    file_name: Assignment2CSCS
    author: Francesco Mantegna
    studentID: 188824
    date: 11/04/2017
    course: Computational Skills For Cognitive Science
    assignment n?: 2

%}

function [myTrials,memaccuracy]=Assignment2CSCS(subjnumber)

% FUNCTION Assignment2CSCS
% Run a multimodal memory experiment designed to investigate how people process negative sentences.
%
% Syntax:
% [data,accuracy] = Assignment2CSCS(subjnumber)
%
% subjnumber : should be a number from 1 to n (data from 10 subjects have
% already been collected)
% myTrials : is a structure containing all filenames (both images and audio),
% the corrisponding words, the strings presented in the encoding phase, the
% utterances presented in the retrieval phase, RTs and accuracy
% memaccuracy : is the overall accuracy for each subject

    
    %% Setting up PTB's Screen
    [win,screenRect]=Screen('OpenWindow',0,[1 1 1],[0 0 850 650]); % creates a window in PTB
    Screen('TextFont', win, 'Arial', 1); % defines the font and the style (bold) for the instructions 
    Screen('TextSize', win, 30); % defines the text size for the instructions
    Screen('BlendFunction', win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA'); % allows to combine color values of pixels already in the window with new color values from drawing commands

    %% Creating audio
    samplingRate = 44100; % quality of sound
    InitializePsychSound(1); % perform basic initialization of the sound driver
    pahandle = PsychPortAudio('Open', [], [], [], samplingRate,1); % correspond to Open Window for PTB's sound system

    %% Setting up Constants and Variables
    intertrialint=1.2;
    interstringint=1;
    randseq=randperm(16,16); % random sequence for the encoding phase
    randseq2=randperm(16,16); % random sequence for the retrieval phase
    fixCrossDimPix = (screenRect(4))/10; % set fixation point dimension
    fixxCoords = [-fixCrossDimPix fixCrossDimPix 0 0]; % set fixation point x coordinates
    fixyCoords = [0 0 -fixCrossDimPix fixCrossDimPix]; % set fixation point y coordinates
    fixallCoords = [fixxCoords; fixyCoords]; % set fixation point all coordinates

    %% Downloading files
    for i=1:4 % this loop is designed to download and organize single images and their corresponding audio
        if i==1 || i==2
            myInstructions(i).type='audio files';
            myInstructions(i).format='*.wav';
        else
            myInstructions(i).type='images';
            myInstructions(i).format='*.jpg';
        end
        switch i % specifies the folder path for each bunch of files to be upload 
            case 1
                 myInstructions(i).folder='Assignment2CSCS/Audio/single/topsound';
            case 2
                 myInstructions(i).folder='Assignment2CSCS/Audio/single/bottomsound';
            case 3
                 myInstructions(i).folder='Assignment2CSCS/topImage';
            case 4
                 myInstructions(i).folder='Assignment2CSCS/bottomimage';
        end
        myInstructions(i).text=['Please upload all ',myInstructions(i).type,'\n from the folder: \n',myInstructions(i).folder]; % the instructions iterate following the parameters defined above
        DrawFormattedText(win,myInstructions(i).text,'center','center',[200 200 0]); % defines the text and the color of instructions
        Screen('Flip',win) ; % display the instructions on the screen
        switch i % assign different variable names to the different type of files to be upload 
            case 1
                audfiles1=uigetfile([myInstructions(i).format],'MultiSelect','on');
            case 2
                audfiles2=uigetfile([myInstructions(i).format],'MultiSelect','on');
            case 3
                visfiles1=uigetfile([myInstructions(i).format],'MultiSelect','on');
            case 4
                visfiles2=uigetfile([myInstructions(i).format],'MultiSelect','on');
        end
    end

    for i=5:6 % this loop is designed to download and organize the recurring structure both for the truth judgement and audio files 
        switch i
            case 5
                myInstructions(i).folder='/Users/francesco/Documents/MATLAB/Computational  Skills for Cognitive Science/Assignment2CSCS_Francesco_Mantegna/TValue';
                myInstructions(i).format='*.jpg';
            case 6
                myInstructions(i).folder='/Users/francesco/Documents/MATLAB/Computational  Skills for Cognitive Science/Assignment2CSCS_Francesco_Mantegna/Audio/structure';
                myInstructions(i).format='*.wav';
        end
        filePattern = fullfile([myInstructions(i).folder],[myInstructions(i).format]);
        switch i
            case 5
                truefalse = dir(filePattern);
            case 6
                audstruct = dir(filePattern);
        end
    end

    %% Building structures for stimuli and strings
    numvisStimuli=length(visfiles1);
    randsixteen=randperm(numvisStimuli,16);
    for i=1:numvisStimuli
        myStimuli(i).filenametop=visfiles1{i};
        myStimuli(i).filenamebot=visfiles2{i};
    end

    numaudStimuli=length(audfiles1);
    for i=1:numaudStimuli
        myStimuli(i).filesoundtop=audfiles1{i};
        myStimuli(i).filesoundbot=audfiles1{i};
    end

    numTrials=0;
    for k=randsixteen(1:16)
        numTrials=numTrials+1;
        myTrials(numTrials).audfilename1=audfiles1{k};
        myTrials(numTrials).audfilename2=audfiles2{k};
        myTrials(numTrials).audword1=myTrials(numTrials).audfilename1(1:end-4);
        myTrials(numTrials).audword2=myTrials(numTrials).audfilename2(1:end-4);
    end

    numTrials=0;
    for k=randsixteen(1:16)
        numTrials=numTrials+1;
        myTrials(numTrials).visfilename1=visfiles1{k};
        myTrials(numTrials).visfilename2=visfiles2{k};
        myTrials(numTrials).visword1=myTrials(numTrials).visfilename1(1:end-4);
        myTrials(numTrials).visword2=myTrials(numTrials).visfilename2(1:end-4);
        myStrings(numTrials).taffabove=['There is a ' myTrials(numTrials).visword1 ' above a ' myTrials(numTrials).visword2] ;
        myStrings(numTrials).tnegabove=['There is not a ' myTrials(numTrials).visword2 ' above a ' myTrials(numTrials).visword1] ;
        myStrings(numTrials).faffabove=['There is a ' myTrials(numTrials).visword2 ' above a ' myTrials(numTrials).visword1] ;
        myStrings(numTrials).fnegabove=['There is not a ' myTrials(numTrials).visword1 ' above a ' myTrials(numTrials).visword2] ;
        myStrings(numTrials).taffbelow=['There is a ' myTrials(numTrials).visword2 ' below a ' myTrials(numTrials).visword1] ;
        myStrings(numTrials).tnegbelow=['There is not a ' myTrials(numTrials).visword1 ' below a ' myTrials(numTrials).visword2] ;
        myStrings(numTrials).faffbelow=['There is a ' myTrials(numTrials).visword1 ' below a ' myTrials(numTrials).visword2] ;
        myStrings(numTrials).fnegbelow=['There is not a ' myTrials(numTrials).visword2 ' below a ' myTrials(numTrials).visword1] ;
    end
    % creates eight more columns in the structure 'myStrings' corresponding to the strings for the memory
    % test, replacing 'is' with 'was' for each previously defined string
    names = fieldnames(myStrings);
    for i=1:8
        newstr(i).name=char(strcat(names{i},{'mem'}));
        for p=1:16
            myStrings(p).(newstr(i).name)=myStrings(p).(names{i});
            myStrings(p).(newstr(i).name)=strrep(myStrings(p).(names{i}),' is ',' was ');
        end
    end
    
    names=fieldnames(myStrings); % this adds the names of the new fields to the variable names, because it will be used in the accuracy estimation

    %% Preparing Rectangles (for different screen sizes)
    sizeRatio=[2.5 3];
    screenCntrX=(screenRect(3))/2;
    screenYRatio=[2 1.5];
    gridSize=2;
    myCounter=0;
    for i=1:2 % this loop creates both the rectangles for the encoding phase (vertically arranged) and the ones for the truth judgement (arranged orizontally)
        rectangleSize(i)=round((screenRect(3))/sizeRatio(i));
        screenCntrY(i)=(screenRect(4))/screenYRatio(i);
        switch i
            case 1
                for xcoords=1 % defines x coordinates of the grid
                    for ycoords=1:rectangleSize(i):rectangleSize(i)*gridSize % defines y coordinates of the grid
                        myCounter=myCounter+1;
                        imgRects(myCounter,:)=[xcoords ycoords xcoords+rectangleSize(i)/2 ycoords+rectangleSize(i)/2]; %[left top right bottom]
                    end
                end
                allMax=max(imgRects);
                maxX=allMax(3);
                maxY=allMax(4);
                gridCntrX=round(maxX/2);
                gridCntrY=round(maxY/2);
                imgRects(:,[1 3])=imgRects(:,[1 3])+screenCntrX-gridCntrX;
                imgRects(:,[2 4])=imgRects(:,[2 4])+screenCntrY(i)-gridCntrY;
            case 2
                rectangleSize(i)=round((screenRect(3))/sizeRatio(i));
                screenCntrY(i)=(screenRect(4))/screenYRatio(i);
                myCounter=0;
                for xcoords=1:rectangleSize(i):rectangleSize(i)*gridSize % defines x coordinates of the grid
                    for ycoords=1 % defines y coordinates of the grid
                        myCounter=myCounter+1;
                        tvRects(myCounter,:)=[xcoords ycoords xcoords+rectangleSize(i)/2 ycoords+rectangleSize(i)/2]; %[left top right bottom]
                    end
                end
                allMax=max(tvRects);
                maxX=allMax(3);
                maxY=allMax(4);
                gridCntrX=round(maxX/2);
                gridCntrY=round(maxY/2);
                tvRects(:,[1 3])=tvRects(:,[1 3])+screenCntrX-gridCntrX;
                tvRects(:,[2 4])=tvRects(:,[2 4])+screenCntrY(i)-gridCntrY;
        end
    end
    stingcoordy=round((screenRect(4))/4);

    %% Implementing the experiment
    for condition = 1:2
        if condition ==1
            %% Draw text instructions for condition 1
            DrawFormattedText(win,'Welcome!\n\n You will be shown with 2 images at a time.\n For each pair, you will be presented with\n a sentence concerning the spatial relationship\n Press any key to continue.','center','center',[200 200 0]); % defines the text and the color of instructions
        else
            %% Draw text instructions for conditon 2
            DrawFormattedText(win,'Alright!\n\n Now, you are going to do a Memory Test.\n You are going to ear some utterances\n concerning the relationship\n between the previously presented images.\n You are supposed to evaluate them\n either true or false.\n Press any key to continue.','center','center',[200 200 0]); % defines the text and the color of instructions
        end
            Screen('Flip',win) ; % display the instructions on the screen
            KbWait(-1); % wait for any key digited by the user
            KbReleaseWait; % once the key has been digited the wait command is interrupted
            Screen('Flip',win) ; % clean the instructions from the screen
        %% Encoding phase
        for trial=1:numTrials
                if condition == 1
                    Screen('DrawLines',win,fixallCoords,5,[200 200 0],[screenCntrX screenCntrY(1)],2); % draw fixation cross in the middle of the screen
                    Screen(win,'Flip') ; % display fixation cross in the middle of the screen
                    WaitSecs(intertrialint);
                    for i=1:2 % this loop draw two different textures for top and bottom rectangles
                        switch i
                            case 1
                                image1=imread(myTrials(trial).visfilename1);
                                tex(i)=Screen('MakeTexture',win,image1);
                            case 2
                                image2=imread(myTrials(trial).visfilename2);
                                tex(i)=Screen('MakeTexture',win,image2);
                        end
                        Screen('DrawTexture',win,tex(i),[],imgRects(i,:));
                    end
                    Screen('Flip',win)
                    WaitSecs(intertrialint);
                    Screen('Flip',win)

                    if  randseq(trial) <= 4 % this first sequence is designed to display only stings which describe the correct spatial relations between the two images
                            myTrials(trial).strings=myStrings(trial).taffabove;
                        elseif randseq(trial) >= 5 && randseq(trial) <=8
                            myTrials(trial).strings=myStrings(trial).tnegabove;
                        elseif randseq(trial) >= 9 && randseq(trial) <= 12
                            myTrials(trial).strings=myStrings(trial).taffbelow;
                        elseif randseq(trial) >= 13 && randseq(trial) <= 16
                            myTrials(trial).strings=myStrings(trial).tnegbelow;
                    end
                    DrawFormattedText(win, myTrials(trial).strings,'center','center',[200 200 0]);
                    Screen('Flip',win)
                    WaitSecs(interstringint);

              %% Retrieval Stage
                else   
                    if  randseq2(trial) <= 2 % this second sequence is designed to display strings describing both true and false spatial relations between the two images shown in the encoding phase
                           myTrials(trial).utterances=myStrings(trial).taffabovemem;
                        elseif randseq2(trial) >= 3 && randseq2(trial) <= 4
                                  myTrials(trial).utterances=myStrings(trial).tnegabovemem;
                        elseif randseq2(trial) >= 3 && randseq2(trial) <= 4
                                  myTrials(trial).utterances=myStrings(trial).tnegabovemem;
                        elseif randseq2(trial) >= 5 && randseq2(trial) <= 6
                                  myTrials(trial).utterances=myStrings(trial).faffabovemem;
                        elseif randseq2(trial) >= 7 && randseq2(trial) <= 8
                                  myTrials(trial).utterances=myStrings(trial).fnegabovemem;
                        elseif randseq2(trial) >= 9 && randseq2(trial) <= 10
                                  myTrials(trial).utterances=myStrings(trial).taffbelowmem;
                        elseif randseq2(trial) >= 11 && randseq2(trial) <= 12
                                  myTrials(trial).utterances=myStrings(trial).tnegbelowmem;
                        elseif randseq2(trial) >= 13 && randseq2(trial) <= 14
                                  myTrials(trial).utterances=myStrings(trial).faffbelowmem;
                        elseif randseq2(trial) >= 15 && randseq2(trial) <= 16
                                  myTrials(trial).utterances=myStrings(trial).fnegbelowmem;
                    end
                    
                    % this instruction is an attempt to use the TTS (Text 
                    % To Speech) system of the machine that is running the 
                    % script. This command is designed for Macintosh machines
                    % so perhaps it could return an error when the script is
                    % run in another platform. Therefore, I used a
                    % try-catch statement in order to countinue running the
                    % sctipt even if it returns an error, in that case
                    % there is an alternative path for sound presentation.
                    try
                          talktospeech=system(['say ', myTrials(trial).utterances]);
                    catch
                          warning('Problem using TTS function in this computer. The script will follow an alternative path.');
                    end
                    DrawFormattedText(win, myTrials(trial).utterances,'center',stingcoordy, [200 200 0]);

                    %% Alternative path for audio buffer for systems that are not provided with TTS 
                        if ~any(strcmp(who,'talktospeech'))

                            if  randseq2(trial) <= 2
                                [stimulus1,samplingRate1]=audioread(audstruct(1).name);
                                [stimulus2,samplingRate2]=audioread(audstruct(3).name);
                                [stimulus3,samplingRate3]=audioread(myTrials(trial).audfilename1);
                                [stimulus4,samplingRate4]=audioread(myTrials(trial).audfilename2);
                                elseif randseq2(trial) >= 3 && randseq2(trial) <= 4
                                        [stimulus1,samplingRate1]=audioread(audstruct(2).name);
                                        [stimulus2,samplingRate2]=audioread(audstruct(3).name);
                                        [stimulus3,samplingRate3]=audioread(myTrials(trial).audfilename2);
                                        [stimulus4,samplingRate4]=audioread(myTrials(trial).audfilename1);
                                elseif randseq2(trial) >= 5 && randseq2(trial) <= 6
                                        [stimulus1,samplingRate1]=audioread(audstruct(1).name);
                                        [stimulus2,samplingRate2]=audioread(audstruct(3).name);
                                        [stimulus3,samplingRate3]=audioread(myTrials(trial).audfilename2);
                                        [stimulus4,samplingRate4]=audioread(myTrials(trial).audfilename1);
                                elseif randseq2(trial) >= 7 && randseq2(trial) <= 8
                                        [stimulus1,samplingRate1]=audioread(audstruct(2).name);
                                        [stimulus2,samplingRate2]=audioread(audstruct(3).name);
                                        [stimulus3,samplingRate3]=audioread(myTrials(trial).audfilename1);
                                        [stimulus4,samplingRate4]=audioread(myTrials(trial).audfilename2);
                                elseif randseq2(trial) >= 9 && randseq2(trial) <= 10
                                        [stimulus1,samplingRate1]=audioread(audstruct(1).name);
                                        [stimulus2,samplingRate2]=audioread(audstruct(4).name);
                                        [stimulus3,samplingRate3]=audioread(myTrials(trial).audfilename2);
                                        [stimulus4,samplingRate4]=audioread(myTrials(trial).audfilename1);
                                elseif randseq2(trial) >= 11 && randseq2(trial) <= 12
                                        [stimulus1,samplingRate1]=audioread(audstruct(2).name);
                                        [stimulus2,samplingRate2]=audioread(audstruct(4).name);
                                        [stimulus3,samplingRate3]=audioread(myTrials(trial).audfilename1);
                                        [stimulus4,samplingRate4]=audioread(myTrials(trial).audfilename2);
                                elseif randseq2(trial) >= 13 && randseq2(trial) <= 14
                                        [stimulus1,samplingRate1]=audioread(audstruct(1).name);
                                        [stimulus2,samplingRate2]=audioread(audstruct(4).name);
                                        [stimulus3,samplingRate3]=audioread(myTrials(trial).audfilename1);
                                        [stimulus4,samplingRate4]=audioread(myTrials(trial).audfilename2);
                                elseif randseq2(trial) >= 15 && randseq2(trial) <= 16
                                        [stimulus1,samplingRate1]=audioread(audstruct(2).name);
                                        [stimulus2,samplingRate2]=audioread(audstruct(4).name);
                                        [stimulus3,samplingRate3]=audioread(myTrials(trial).audfilename2);
                                        [stimulus4,samplingRate4]=audioread(myTrials(trial).audfilename1);
                            end


                            stimulus1 = resample(stimulus1,samplingRate,samplingRate1);
                            buffer1=PsychPortAudio('CreateBuffer',pahandle, stimulus1');
                            stimulus3 = resample(stimulus3,samplingRate,samplingRate3);
                            buffer2=PsychPortAudio('CreateBuffer',pahandle, stimulus3');
                            stimulus2 = resample(stimulus2,samplingRate,samplingRate2);
                            buffer3=PsychPortAudio('CreateBuffer',pahandle, stimulus2');
                            stimulus4 = resample(stimulus4,samplingRate,samplingRate4);
                            buffer4=PsychPortAudio('CreateBuffer',pahandle, stimulus4');

                            PsychPortAudio('UseSchedule', pahandle, 1); % this command creates a playlist importing all the different sounds in a unique playlist

                            % Play buffer(i) from startSample 0.0 seconds to endSample 1.0 
                            % seconds. Play one repetition for each soundbuffer
                            for i=1:4
                                PsychPortAudio('AddToSchedule', pahandle, eval(['buffer',num2str(i)]), 1, 0.0, 1.5, 1);
                            end
                            PsychPortAudio('Start', pahandle, [], 0, 1);

                            stillgoing=1;
                            while stillgoing==1
                                s = PsychPortAudio('GetStatus', pahandle); % query current playback status
                                    if s.Active == 0
                                    % Schedule is finished, the engine is stopped. Before adding new
                                    % slots we first must delete the old ones, i.e. reset the
                                    % schedule:
                                    PsychPortAudio('UseSchedule', pahandle, 2);
                                    stillgoing=0;
                                    break
                                    end
                            end
                        end

                        for i=1:2
                        switch i
                            case 1
                                tcheck=imread(truefalse(2).name);
                                tex(i)=Screen('MakeTexture',win,tcheck);
                            case 2
                                fcross=imread(truefalse(1).name);
                                tex(i)=Screen('MakeTexture',win,fcross);
                        end
                        Screen('DrawTexture',win,tex(i),[],tvRects(i,:));
                        end
                        myTrials(trial).resp_onset=Screen('Flip',win);

                        %% Truth judgements
                        noclickYet = 1; % set the value of noclickYet 'true' again in order to start with another while loop
                            while noclickYet == 1 % while this is true
                                [mouseX,mouseY,buttons] = GetMouse(win); % returns the current (x,y) position of the cursor and the up/down state of the mouse button
                                    if buttons(1) % the element is true '1' if the corresponding mouse button is pressed and false '0' otherwise 
                                            if mouseX>tvRects(1,1) && mouseX<tvRects(1,3) && mouseY>tvRects(1,2) && mouseY<tvRects(1,4) % whenever the coordinates of the mouse click are inside the first rectangle of the grid
                                                myTrials(trial).response='t'; % collect click on the check
                                                myTrials(trial).timeresponse=GetSecs;
                                                Screen('Flip',win);
                                                WaitSecs(intertrialint);
                                                KbReleaseWait % stay here while key down
                                                noclickYet = 0; % set the value of noclickYet 'false' in order to momentarily exit the while loop
                                            break
                                            elseif mouseX>tvRects(2,1) && mouseX<tvRects(2,3) && mouseY>tvRects(2,2) && mouseY<tvRects(2,4) % whenever the coordinates of the mouse click are inside the second rectangle of the grid
                                                myTrials(trial).response='f'; % collect click on the cross
                                                myTrials(trial).timeresponse=GetSecs;
                                                Screen('Flip',win);
                                                WaitSecs(intertrialint);
                                                KbReleaseWait % stay here while key down
                                                noclickYet = 0; % set the value of noclickYet 'false' in order to momentarily exit the while loop
                                            break
                                            end
                                    end
                            end
                            %% Response Times Estimate
                            myTrials(trial).RTs=(myTrials(trial).timeresponse)-(myTrials(trial).resp_onset);

                            %% Accuracy
                            if strcmp(myTrials(trial).utterances,myStrings(trial).taffabovemem) % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
                                    label=char(names(9));
                                elseif strcmp(myTrials(trial).utterances,myStrings(trial).tnegabovemem) % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
                                            label=char(names(10));
                                elseif strcmp(myTrials(trial).utterances,myStrings(trial).faffabovemem) % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
                                            label=char(names(11));
                                elseif strcmp(myTrials(trial).utterances,myStrings(trial).fnegabovemem) % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
                                            label=char(names(12));
                                elseif strcmp(myTrials(trial).utterances,myStrings(trial).taffbelowmem) % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
                                            label=char(names(13));
                                elseif strcmp(myTrials(trial).utterances,myStrings(trial).tnegbelowmem) % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
                                            label=char(names(14));
                                elseif strcmp(myTrials(trial).utterances,myStrings(trial).faffbelowmem) % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
                                            label=char(names(15));
                                elseif strcmp(myTrials(trial).utterances,myStrings(trial).fnegbelowmem) % compares the strings in the column .name with the name of the images which have been shown for encoding and returns a truth-value
                                            label=char(names(16));
                            end
                            tvalue=label(1); % tvalue is equal to the first character of the label of the corresponding field, that is either "t" or "f"
                            if strcmp(myTrials(trial).response,tvalue)
                                 myTrials(trial).memaccuracy=1;
                            else
                                 myTrials(trial).memaccuracy=0;
                            end
                            
                end
                pause(.5);
        end
        if  condition ==2
            %% Displaying Accuracy
            memaccuracy=round(mean([myTrials.memaccuracy]'),2)*100; % this is for calculating accuracy and round it to integers numbers
            meanRTs=mean([myTrials.RTs],1)'; % this calculates the mean RTs across conditions
            DrawFormattedText(win,['Your memory accuracy is: ' num2str(memaccuracy) '%\n\n Press "Enter" to exit the experiment.'],'center','center',[200 200 0]); % defines the text and the color of instructions
            Screen('Flip',win) ; % display the accuracy on the screen
            % same as line 275
            try
                system('say Thank you for participating, have a nice day!');
            catch
                warning('Problem using TTS function in this computer. You wont ear the farewells, sorry about that.');
            end
            KbWait(-1); % wait for any key digited by the user
            KbReleaseWait; % once the key has been digited the wait command is interrupted
            %% Organizing Data and Saving Output
            subjData=struct2table(myTrials); % converts myTrials into a table 
            writetable(subjData); % creates a table containing myTrials' data
            save(['subjectnumber',num2str(subjnumber),'.mat'],'subjData')
        end
    end

    sca
end

% Please check the script DataProcessingAssignment2.m for Data Analysis