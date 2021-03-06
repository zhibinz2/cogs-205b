classdef Metropolis < handle
    % Metropolis  A class for the Metropolis algorithm
    
    % The main properties
    properties
                
        InitialValues  double {mustBeReal, mustBeFinite}
        
        TargetLogPdf function_handle
        
        TransitionStd  double {mustBeReal, mustBeFinite} = 1
        
    end
    
    % Derived properties that need to be set internally
    properties (SetAccess = private)
        
        CurrentPointX
        CurrentPointY
        
        ProposedPointX
        ProposedPointY
        
        XDim
        StepCount = 1
        Accept = true
        
        XHistory = []
        YHistory = []
        
        LogAcceptanceRatio
        BurnIn = 100;
        
        randList = []
        numSamples
        
        h
        dispFlag = true;
        
    end
        
    % Methods are functions that belong to the class
    methods
        
        %%% Constructor function %%%
        
        % A main constructor, for a new Metropolis
        function obj = Metropolis(TargetLogPdf, InitialValues)
            
            obj.TargetLogPdf   = TargetLogPdf;
            obj.InitialValues  = InitialValues;
            obj.XDim           = numel(InitialValues);
            
            obj.validateInputs;
            
            obj.CurrentPointX  = obj.InitialValues;
            
            obj.EvaluateCurrentPoint();
            
            obj.AddToHistory();
                        
        end
        
        
        %%% Display function %%%
        
        % Print the state of the sampler to screen
        function disp(obj)
            % Draw a progress bar that updates infrequently
            if obj.StepCount == 2
                obj.dispFlag = true;
                obj.h = waitbar(0,'Sampling...');
            end
            if ~mod(obj.StepCount,(obj.numSamples)/100)
                waitbar(obj.StepCount/(obj.numSamples), obj.h);
                drawnow;
            end
            if obj.dispFlag == false
                close(obj.h);
                obj.dispFlag = true;
            end
        end
        
        
        % Sample function
        
        function DrawSamples(obj, R)
            obj.StepCount = 1;
            obj.DetermineBurnIn(R);
            R = R + obj.BurnIn; % these will be removed later
            obj.numSamples = R;
            % Draws R samples from the target distribution
            obj.PreallocateBigVectors();
            tally = 0;
%             obj.disp()
            for i = 1:R
                
                obj.StepCount = i;
                obj.disp();
                %  Draw a randomly selected point from the proposal
                %  distribution
                obj.DrawProposal();
                obj.EvaluateProposedPoint();
                
                %  Compute the acceptance ratio
                obj.ComputeLogAcceptanceRatio();
                
                % Decide whether to accept the proposal
                obj.DecideAccept();
                
                % If the proposal should be accepted, make the proposed
                % point the current point
                if obj.Accept()
                    obj.MakeProposalCurrent();
                    tally = tally + 1;
                end
                
                % Add the current point to the chain
                obj.AddToHistory();
                
            end
            % Strip out the burn in
            [obj.XHistory,obj.YHistory,~] = obj.CleanHistory();
            obj.transposeOutput();
            fprintf(1,"Num times accepted = %i\n",tally)
            
            % Close the waitbar
            obj.endDisp();
            obj.disp();
        end
        
        
        function s = getSampleStatistics(obj)
        
            error('Not yet implemented: getSampleStatistics()')
            s.mean = mean(obj.YHistory,1);
            s.sigma = std(obj.YHistory,0,1);
        end
                
    end
    
end
