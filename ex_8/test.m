function test(Q)
    % Possible permuted initial states, observe that you dont include the
    % goal state 6 (room5)
    possible_initial_states = randperm(5);
    goalState=6;

    % Get the biggest action for every state
    [~, action_max] = max(Q,[],2);

    for idxStates=1:numel(possible_initial_states)
        curr_state = possible_initial_states(idxStates);
        fprintf('initial state room_%d actions=[ ', curr_state-1);
        % Follow optimal policy from intial state to goal state
        while true
            next_state = action_max(curr_state);
            fprintf(' %d,', next_state-1);
            curr_state = next_state;
            if curr_state == goalState
                fprintf(']');
               break 
            end
        end
        fprintf('\n');
    end
end