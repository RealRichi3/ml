function Q = train()

% Initial training parameters
gamma = 0.8;
goalState=6;
numTrainingEpisodes = 20;

% Set Q initial value
Q = zeros(6,6);

% Learn from enviroment iteraction
for idxEpisode=1:numTrainingEpisodes
    validActionOnState = -1;
    
    % Reset environment
    [~,currentState] = simple_RL_enviroment(1, true);
    
    % Episode (initial state to goal state)
    % Break only when we reach the goal state
    while true
        % Choose a random action possible for the current state
        while validActionOnState == -1
            % Select a random possible action
            possibleAction = randi([1,6]);
            
            % Interact with enviroment and get the immediate reward
            [ reward, ~ ] = simple_RL_enviroment(possibleAction, false);
            validActionOnState = reward;
        end
        validActionOnState = -1;
        
        % Update Q
        % Get the biggest value from each row of Q, this will create the
        % qMax for each state
        next_state = possibleAction;
        qMax = max(Q,[],2);
        Q(currentState,possibleAction) = reward + ...
            (gamma*(qMax(next_state)));

        if currentState == goalState
            break;
        end

        % Non this simple example the next state will be the action
        currentState = possibleAction;
    end
    fprintf('Finished episode %d restart enviroment\n',idxEpisode);
end
end