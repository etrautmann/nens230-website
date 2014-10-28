% Lengthen a node for the tree generating demo
% Niru Maheswaranathan
% 2:15 AM Oct 28, 2013

function node = lengthenNode(currentNode, dt, r)

    % get out the length of this node
    len = size(currentNode,1);

    % lengthen the node (according to some formula)
    node = [currentNode;
            currentNode(len,1) + dt*round(cos(currentNode(len,3))*1e3)/1e3*(r^currentNode(len,4)) ...
            currentNode(len,2) + dt*round(sin(currentNode(len,3))*1e3)/1e3*(r^currentNode(len,4)) ...
            currentNode(len,3)                                                                    ...
            currentNode(len,4)];