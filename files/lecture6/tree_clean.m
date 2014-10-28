 %% Generates a fractal-like tree
%  Niru Maheswaranathan
%  Oct 28 2013

%% Define some parameters
r = 0.7;
meanBranchAngle = -pi/2;            % average angle of branch splits
stddevBranchAngle = 0.1;            % std. dev. of branch split angle
plotAxisSize= [-0.5 0.5 0 0.5];     % axis size (may grow with tree size)
dx = 0.01;                          % length scale parameter

%% Initializing variables
treeNodes = {};
treeNodes{1} = [0 0 pi/2 0];
ableToSplit = ones(length(treeNodes),1);

%% Initialize the plot
figure(1); axis([-1 1 -1 3]);                       % make the empty plot
plot(treeNodes{1}(:,1), treeNodes{1}(:,2), 'k.');   % plot the first node

%% Build the tree
while length(treeNodes) < 50
    
    figure(1); clf; hold on;
    
    % loop over each existing node
    for nodeIdx = 1:length(treeNodes)
        
        % Check if this node has been split already, if not, it may be
        % split
        if ableToSplit(nodeIdx)
            
            % pick out the current node and its length
            currentNode = treeNodes{nodeIdx};
            len = size(currentNode,1);
            
            % lengthen this branch
            currentNode = lengthenNode(currentNode, dt, r);
            
            % update the cell array with the new branch
            treeNodes{nodeIdx} = currentNode;
            
            % randomly decide whether to split the branch
            if len*dx > sqrt(rand)
                
                % choose the split angle
                theta = meanBranchAngle + stddevBranchAngle*randn;
                
                % turn off the ability to split in the future
                ableToSplit(nodeIdx) = 0;
                
                % the left split
                treeNodes{length(treeNodes)+1} = [currentNode(len,1) currentNode(len,2) currentNode(len,3)+theta currentNode(len,4)+1];
                ableToSplit(end+1) = 1;
                
                % the right split
                treeNodes{length(treeNodes)+1} = [currentNode(len,1) currentNode(len,2) currentNode(len,3)+theta+pi/2 currentNode(len,4)+1];
                ableToSplit(end+1) = 1;

            end
            
        end
        
        %% if the tree outgrows the plot size, expand the plot
        % increase the height of the plot if necessary
        plotAxisSize(4) = max(max(treeNodes{nodeIdx}(:,2)), plotAxisSize(4));
        
        % increase the left limit if necessary
        plotAxisSize(1) = min(min(treeNodes{nodeIdx}(:,1)), plotAxisSize(1));
        
        % increase the right limit if necessary
        plotAxisSize(2) = max(max(treeNodes{nodeIdx}(:,1)), plotAxisSize(2));

        %% Change the branch thickness
        branchThickness = max(10-treeNodes{nodeIdx}(1,4), 1);
        
        %% update the plot
        plot(treeNodes{nodeIdx}(:,1), treeNodes{nodeIdx}(:,2), ...
             'k-', 'LineWidth', branchThickness);
        
    end
    
    % rescale plot and update title
    axis(plotAxisSize);
    title(['# of Branches: ' num2str(length(treeNodes))]);
    drawnow;
    
end