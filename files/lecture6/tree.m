% Tree Generation
% Niru Maheswaranathan
%
% Generates a random tree through simulating a branching process
%
% v0.5      Oct 27 2013
%           Refactored code
%
% v0.1      May  5 2012
%           original version

% define parameters
branchRatio = 0.7;          % ratio of child branch to parent
meanBranchAngle = -pi/4;    % avg. angle of new branch splits
angleStdDev = 0.1;          % std. dev. of angle of new branch splits
numTreeNodes = 50;          % the total number of trees
treeMax = [-0.5 0.5 0 0.5]; % the maximum tree size
dt = 0.01;                  % simulation time step

% initialize variables
treeBranches = {};                            % store the set of tree nodes
treeBranches{1} = [0 0 pi/2 0];               % initialize the first node
visitedBranches = ones(length(treeBranches),1); % init. the branch indices

% set up the figure and plot the first node
figure(1); clf; hold on; axis([-1 1 -1 3]);
plot(treeBranches{1}(:,1), treeBranches{1}(:,2), 'k.');

% while we still have tree nodes to generate
while length(treeBranches) < numTreeNodes

    % for each existing branch
    for bidx = 1:length(treeBranches)

        if visitedBranches(bidx)

            % get the current node
            currentNode = treeBranches{bidx};
            nodeLength  = size(currentNode,1);

            % make the current node longer
            currentNode = lengthenNode(currentNode, dt, branchRatio);

            % overwrite the current node
            treeBranches{bidx} = currentNode;

            % if the length is more than a random value, make a new branch
            if nodeLength*dt > sqrt(rand)

                % generate the angle of the new split
                theta = meanBranchAngle + angleStdDev*randn;

                % define the extent of this branch
                visitedBranches(bidx) = 0;
                L = length(treeBranches);

                % the first branch
                treeBranches{L+1} = ...
                        [currentNode(nodeLength,1)            currentNode(nodeLength,2)  ...
                         currentNode(nodeLength,3)+theta      currentNode(nodeLength,4)+1];

                % and the second
                treeBranches{L+2} = ...
                        [currentNode(nodeLength,1)            currentNode(nodeLength,2)    ...
                         currentNode(nodeLength,3)+theta+pi/2 currentNode(nodeLength,4)+1];

                % add to the branch indices array
                visitedBranches(end+1:end+2) = 1;

            end

        end

        % update the treeMax bounds if the tree outgrows the plot
        treeMax(1) = min(treeMax(1), min(treeBranches{bidx}(:,1)));
        treeMax(2) = max(treeMax(2), max(treeBranches{bidx}(:,1)));
        treeMax(4) = max(treeMax(4), max(treeBranches{bidx}(:,2)));

        % define the new branch thickness, make sure it is at least 1
        thickness = max(10-treeBranches{bidx}(1,4), 1);

        % plot this branch
        plot(treeBranches{bidx}(:,1), treeBranches{bidx}(:,2), 'k-', 'LineWidth', thickness);

    end

    % update the plot
    axis(treeMax);
    title(['# of Branches: ' num2str(length(treeBranches))]);
    drawnow;

end
