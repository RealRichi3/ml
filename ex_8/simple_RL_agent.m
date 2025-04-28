function [ Q ] = simple_RL_agent( )
% Simple agent of reinforcement learning example
% Train, then normalize Q (divide Q by its biggest value)

[Q, totalRewards] = train();
Q = Q / max(Q(:));

% Get the best actions for each possible initial state (1,2,3,4,5)
test(Q);

% Plot the total rewards per episode
figure;
plot(1:length(totalRewards), totalRewards, '-o');
title('Convergence Analysis: Total Rewards per Episode');
xlabel('Episode');
ylabel('Total Reward');
grid on;

end

function [Q, totalRewards] = train()

% Initial training parameters
gamma = 0.8;
goalState = 6;
numTrainingEpisodes = 100;

% Set Q initial value
Q = zeros(6,6);

% Initialize total rewards array
totalRewards = zeros(1, numTrainingEpisodes);

% Learn from environment interaction
for idxEpisode = 1:numTrainingEpisodes
    validActionOnState = -1;
    episodeReward = 0;
    
    % Reset environment
    [~, currentState] = simple_RL_enviroment(1, true);
    
    % Episode (initial state to goal state)
    while true
        % Choose a random action possible for the current state
        while validActionOnState == -1
            % Select a random possible action
            possibleAction = randi([1,6]);
            
            % Interact with environment and get the immediate reward
            [reward, ~] = simple_RL_enviroment(possibleAction, false);
            validActionOnState = reward;
        end
        validActionOnState = -1;
        
        % Update Q
        next_state = possibleAction;
        qMax = max(Q,[],2);
        Q(currentState, possibleAction) = reward + ...
            (gamma * (qMax(next_state)));
        
        % Accumulate reward
        episodeReward = episodeReward + reward;

        if currentState == goalState
            break;
        end

        % In this simple example, the next state will be the action
        currentState = possibleAction;
    end
    
    % Store total reward for the episode
    totalRewards(idxEpisode) = episodeReward;
    
    fprintf('Finished episode %d restart environment\n', idxEpisode);
end
end
