# MATLAB Fall 2014 – Research Plan

> * Group Name: Game Theory Players
> * Group participants names: Fabian Keller, Sebastian Klotz, Simon Zimmermann
> * Project Title: Sequential Investment Game

## General Introduction
The sequential investment game problem is one of the basic problems in game theory. There is already a solution given by Kelly in 1956 which solves the problem for one player. 
In our project we want to expand the problem to two players, which are playing the sequential investment game against each other. The most important goal for every player is to beat the 
other player in one game. One game consists of a finite number n of rounds (we will start with n = 10). Every player plays this n rounds indepentently from the other player. Every player
starts with the same amout of money. Then he sets a part of this money in every round. If he wins he will get the double of what he has invested. When he lose he will lose all the invested money.
The winning probability p is always the same (we will set it to 60%). The player with the higher amount of money at the end of the n rounds will win one game and gets one score. Such a game will
be repeated several times (at the beginning we set this number of repeats N = 1000). The player with the higher sum of scores finally wins the whole game.
 

## The Model

First we start with trying to solve the problem for some fixed variables (like number of players, number of games, amout of money per round, etc.). If there is enough time maybe we can do 
some research by changing this variables.
We also want to solve the problem by using different learning algorithms for the players. We will start with "Fictitious Play" and maybe we are able to optimize it for our problem.


## Fundamental Questions

We hope to find a (or several) nash equilibrium(s) for our problem. Our players should have no intention to change from this specific play strategy. We hope that we can find out how this strategy
looks like or at least if there exit a nash equilibrium or not.


## Expected Results

Our problem can not be solved by a closed form solution, so we are going to simulate different cases with different parameters and different learing algorithms to find out if there are any nash 
equilibriums.


## References 

- "A Sequential Investment Game" by Ryan Murphy (2011)
- "A New Interpretation of Information Rate" by J. L. Kelly (1956)
- Meeting with Prof. Murphy in KW 43


## Research Methods

We are going to use Agend-Based Model to solve this problem.


## Other

We are going to do some researches about Game Theory, Investment Sequential Game and Learning Algorithms by ourselves to find out more about these topics.
