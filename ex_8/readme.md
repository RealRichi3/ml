# Q-Learning Task: Robot Leaving a House

## Introduction
This project explores a Q-learning algorithm for a robot to leave a house. The goal is to understand reinforcement learning concepts through practical implementation and analysis.

## Overview of Reinforcement Learning
Reinforcement learning is a type of machine learning where an agent learns to make decisions by interacting with an environment. The agent receives rewards or penalties for its actions and aims to maximize the total reward over time. Q-learning is a model-free reinforcement learning algorithm that learns the value of an action in a particular state.

## Description of the MATLAB Code
The project consists of the following MATLAB scripts:
- `simple_RL_agent.m`: The main script that trains and tests the Q-learning agent.
- `train.m`: Implements the Q-learning algorithm to train the agent.
- `test.m`: Tests the learned policy by simulating the agent's actions from various initial states.
- `simple_RL_enviroment.m`: Simulates the environment in which the agent operates.

## Procedures to Run the Code
1. Ensure MATLAB is installed on your system.
2. Open MATLAB and navigate to the directory containing the scripts.
3. Run the `simple_RL_agent.m` script to train and test the Q-learning agent.

## Output Analysis
- **Initial States**: Observe the initial state for each episode.
- **Episode Completion**: Check the messages indicating the completion of each episode.
- **Q-table Values**: Review the Q-table to understand the learned Q-values for each state-action pair.
- **Action Sequences**: Observe the sequence of actions taken from each initial state to reach the goal state.

## Policy Analysis
- **Extract the Policy**: Determine the optimal policy by selecting the action with the highest Q-value for each state.
- **Evaluate Policy Efficiency**: Assess how efficiently the policy guides the agent from any initial state to the goal state.

## Performance Metrics
- **Average Reward per Episode**: Calculate the average reward received per episode.
- **Success Rate**: Measure the percentage of episodes in which the agent successfully reaches the goal state.
- **Time to Convergence**: Analyze the number of episodes required for the Q-values to stabilize.

## Exploration vs. Exploitation Analysis
- **Exploration Rate**: Evaluate how the exploration rate affects the learning process.
- **Exploitation of Learned Policy**: Assess how well the agent exploits the learned policy.

## Visualization and Interpretation
- **State-Action Value Plots**: Visualize the Q-values for different state-action pairs.
- **Trajectory Analysis**: Plot the agent's trajectory through the state space.

## Conclusion
Summarize the key findings and insights gained from running the Q-learning task. Reflect on how this exercise enhances understanding of reinforcement learning concepts.

## References
Include any references to literature or resources that provide further context or explanation. 