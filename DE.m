% Differential_Evolution           Created by: Eleanor McSporran /3524848
%                                  Created on: 22 January 2018
%                                  Last modified on: 23 January 2018
% Differential_Evolution accesses the appropriate function to try and use
%   a differential approach to evolution to determine the fittest solution
%   to the optimization problem.

% REMEMBER DE MAXIMIZES?

%% Start
clc
clear all
close all
eval_count = 0;
t = datetime('now');
disp(t);

%%  Population Size
% Determines a random population size, minimum 18.
%rng('shuffle', 'twister');
%pop = round(rand(1)*100);
%if (pop < 18)
%    pop = 18;
%end

%if (pop > 60)
%    pop = 60;
%end

pop = 400;
runs = 1000;
F = 1.5;
probChange = 0.5;

%% Population Creation
% Assigns random binary values to the above size population.
%disp(pop);
scale = 10;
n = 2;
x1 = 1;
x2 = 1;
%x3 = 0;
%x4 = 0;
%x5 = 0;
population = zeros(pop,n);
for l = 1:(pop-1)
    x1 = rand(1)*scale;
    x2 = rand(1)*scale;
    num = [x1 x2];
    population(l,:) = num;
    %new = [population ; num];
    %disp(new);
    %population = new;
    %run = run + 1;
end
%disp(population);
%disp(size(population));
fitTotFinal = size(1,runs);
aveFitFinal = size(1,runs);
fittestPoint1 = size(1,runs);
fittestPoint2 = size(1,runs);
B = zeros(pop,3);
C = zeros(pop,3);
P = zeros(pop,3);
inBounds = 0;
mutatedPop = zeros(pop,n);
bestFunction = size(1,runs);
%% Driving Loop
%mutatedPop = zeros(pop,max_Bits);

for c = 1:runs
    %% Mutation
    % Mutating the new population's individuals.
    if c~=1
        mutatedPop(:,1) = C(:,2);
        mutatedPop(:,2) = C(:,3);
    end
    r1 = zeros(1,n);
    r2 = zeros(1,n);
    r3 = zeros(1,n);
    r4 = zeros(1,n);
    for l = 1:pop
        i = round(rand(1)*pop);
        p = round(rand(1)*pop);
        o = round(rand(1)*pop);
        if (i == p)||(i == o)   %Check to see if the vectors will be copies
            i = round(rand(1)*pop);
        elseif (p == o)
            p = round(rand(1)*pop);
        end
        if (i == 0)
            i = 1;
        end
        if (p ==0)
            p = 1;
        end
        if (o == 0)
            o = 1;
        end
        r1 = population(i,:);
        r2 = population(p,:);
        r3 = population(o,:);
        if (all(r1 == r2)||all(r1 == r3))   %Check to see if the vectors will be copies
            i = round(rand(1)*pop);
            if (i == 0)
                i = 1;
            end
            r1 = population(i,:);
        elseif (r2 == r3)
            p = round(rand(1)*pop);
            if (p == 0)
                p = 1;
            end
            r2 = population(p,:);
        end
        r4 = r1 + F*(r2 - r3);
        mutatedPop(l,:) = r4;
    end
    %% CrossOver
    % Using a basic number line simulation
    
    crossedPop = zeros(pop,n);
    newPop = zeros(1,n);
    
    for l = 1:pop
        probJ(1,1) = rand(1);
        probJ(1,2) = rand(1);
        for i = 1:n
            rndrI = round(rand(1)*n);   %Random number of an integer
            if (probJ(1,i) <= probChange)||(i == rndrI)
                newPop(1,i) = mutatedPop(l,i);
            elseif (probJ(1,i) > probChange)||(i ~= rndrI)
                newPop(1,i) = population(l,i);
            end
        end
        crossedPop(l,:) = newPop;
    end
    
    %% Evaluation of Fitness
    % Determines how fit each of the parents are with respect to the optimizing
    % function.
    
    fit = zeros(1, pop);
    fitness = zeros(1, pop);
    for l = 1:pop
        x = crossedPop(l,:);
        [eval_countOut,fitness(l)] = DigMar_F1(eval_count,x);
        eval_count = eval_countOut;
        fit(1,l) = fitness(l);
    end
    
    %% Selection
    % Using Elitist selection methods to determine the best individual in
    % the population.
    index = 0;
    if c ~= 1
        B(:,1) = fit;
        B(:,2) = crossedPop(:,1);
        B(:,3) = crossedPop(:,2);
        for i = 1:pop
            if C(1,:) ~= P(i,:)
                index = index + 1;
            end
            if index == population  % if the best element doesnt appear in the population then the best population is added at a random point.
                p = round(rand(1)*pop);
                crossedPop(p,:) = P;
            end
        end
        P = sortrows(B,1,'descend');
    end
    
    %% Deterministic Crowding
    % Using a selection of 2 parents offspring are produced and compared
    p1_rand = round(rand(1)*pop);
    p2_rand = round(rand(1)*pop);
    p1 = zeros(1,n);
    p2 = zeros(1,n);
    o1 = zeros(1,n);
    o2 = zeros(1,n);
    mutatedVector = zeros(2,n);
    crossedVector = zeros(2,n);
    if all(p1_rand==0)
        p1_rand = 1;
    end
    if (p2_rand==0)
        p2_rand = 1;
    end
    p1 = crossedPop(p1_rand,:);
    p2 = crossedPop(p2_rand,:);
    %Creating the mutating vector
    r1 = zeros(1,n);
    r2 = zeros(1,n);
    r3 = zeros(1,n);
    r4 = zeros(1,n);
    for l = 1:n
        i = round(rand(1)*pop);
        p = round(rand(1)*pop);
        o = round(rand(1)*pop);
        if (i == p)||(i == o)   %Check to see if the vectors will be copies
            i = round(rand(1)*pop);
        elseif (p == o)
            p = round(rand(1)*pop);
        end
        if (i == 0)
            i = 1;
        end
        if (p ==0)
            p = 1;
        end
        if (o == 0)
            o = 1;
        end
        r1 = crossedPop(i,:);
        r2 = crossedPop(p,:);
        r3 = crossedPop(o,:);
        if (all(r1 == r2)||all(r1 == r3))   %Check to see if the vectors will be copies
            i = round(rand(1)*pop);
            if (i == 0)
                i = 1;
            end
            r1 = population(i,:);
        elseif (r2 == r3)
            p = round(rand(1)*pop);
            if (p == 0)
                p = 1;
            end
            r2 = population(p,:);
        end
        r4 = r1 + F*(r2 - r3);
        mutatedVector(l,:) = r4;        % Might be some trouble with dimensions here
    end
    %Cross Over
    newPop = zeros(1,n);
    for l = 1:n
        probJ(1,1) = rand(1);
        probJ(1,2) = rand(1);
        for i = 1:n
            rndrI = round(rand(1)*n);   %Random number of an integer
            if (probJ(1,i) <= probChange)||(i == rndrI)
                newPop(1,i) = mutatedPop(l,i);
            elseif (probJ(1,i) > probChange)||(i ~= rndrI)
                newPop(1,i) = population(l,i);
            end
        end
        crossedVector(l,:) = newPop;
    end
    
    o1 = crossedVector(1,:);
    o2 = crossedVector(2,:);
    dist1 = abs(p1 - o1);
    dist2 = abs(p1 - o2);
    dist3 = abs(p2 - o1);
    dist4 = abs(p2 - o2);
    [eval_countOut,fitness] = DigMar_F1(eval_count,p1);
    eval_count = eval_countOut;
    fitDistP1 = fitness;
    [eval_countOut,fitness] = DigMar_F1(eval_count,o1);
    eval_count = eval_countOut;
    fitDistO1 = fitness;
    [eval_countOut,fitness] = DigMar_F1(eval_count,p2);
    eval_count = eval_countOut;
    fitDistP2 = fitness;
    [eval_countOut,fitness] = DigMar_F1(eval_count,o2);
    eval_count = eval_countOut;
    fitDistO2 = fitness;
    y = 0;
    if (dist1-dist3 > 0)    % Determining the first pair.
        if fitDistP1>fitDistO1      %Determining which point has the bigger fitness
            crossedPop(p1_rand,:) = p1;
        else
            crossedPop(p1_rand,:) = o1;
        end
        y = 1;
    elseif (dist1-dist3 < 0)
        if fitDistP2>fitDistO1      %Determining which point has the bigger fitness
            crossedPop(p2_rand,:) = p1;
        else
            crossedPop(p2_rand,:) = o1;
        end
        y = 2;
    end
    if (y == 1)     % Determining the second pair based off of the first
        if fitDistP2>fitDistO2      %Determining which point has the bigger fitness
            crossedPop(p2_rand,:) = p2;
        else
            crossedPop(p2_rand,:) = o2;
        end
    elseif (y == 2)
        if fitDistP1>fitDistO2      %Determining which point has the bigger fitness
            crossedPop(p1_rand,:) = p1;
        else
            crossedPop(p1_rand,:) = o2;
        end
    end
    
    
    
    
    %% Average fitness
    
    B(:,1) = fit;
    B(:,2) = crossedPop(:,1);
    B(:,3) = crossedPop(:,2);
    C = sortrows(B,1,'descend');
    bestFunction(1,c) = C(1,1);
    fittestPoint1(1,c) = C(1,2);
    fittestPoint2(1,c) = C(1,3);
    fitTotFinal(1,c) = C(1,1);
    fitSumFinal = sum(fitTotFinal);
    aveFitFinal(1,c) = fitSumFinal/c;
    
end

% End of Outer Loop
%% Fitness of the final Population
% Evaluated fitness of the final population.

fit = zeros(1, pop);
fitness = zeros(1, pop);
for l = 1:pop
    x = crossedPop(l,:);
    [eval_countOut,fitness(l)] = DigMar_F1(eval_count,x);
    eval_count = eval_countOut;
    fit(1,l) = fitness(l);
end

% Sorting the fitness of this iterations Population
dominationFinal = 0;
numFitFinal = length(fit);
fittestFinal1 = 0;
fittestFinal2 = 0;
tempFinal = fit(1,i);
inBoundsFinal = 0;
juggle = fit(1,1);
for h = 1:numFitFinal
    temp = fit(1,h);
    if fit(1,h) >= tempFinal
        tempFinal = fit(1,h);
        if juggle == tempFinal
            dominationFinal = dominationFinal + 1;
        else
            juggle = tempFinal;
            dominationFinal = 1;
        end
        fittestFinal1 = C(1,2);
        fittestFinal2 = C(1,3);
        
    end
    if C(h,1) > -100
        inBoundsFinal = inBoundsFinal + 1;
    end
    
end
%disp(fit);
disp("Number of Runs");
disp(runs);
disp("Population");
disp(pop);
disp("Evaluation Counter");
disp(eval_count);
disp("Scaling Factor F");
disp(F);
disp("Cross Over Probability");
disp(probChange);
disp("Best Function Value");
disp(C(1,1));
format shortG;
disp("Running average of the best");
disp(aveFitFinal(1,runs));
format short;
disp("Point x1");
disp(fittestFinal1);
disp("");
disp("Point x2");
disp(fittestFinal2);
percentInBounds = (inBoundsFinal/pop)*100;
disp("Percent of xValues within the bounds");
disp(percentInBounds);

%% The plot
% Plot of the function value.
% Plotting the x values of the fittest point of each iteration
run_it = size(1,runs);
for i = 1:runs
    run_it(i) = i;
end
plot(fittestPoint1,fittestPoint2,'o--');
xlabel ('X1');
ylabel ('X2');
title ('The value of the X values with respect to each other');
% xlim([-6 6]);
% ylim([-6 6]);
grid on

% Plot of the average fitness of the answer.
figure2 = figure;
plot(run_it, aveFitFinal,'o--');
xlabel ('aveFit'); %x_axis
ylabel ('fitTot'); %y_axis
title ('Fitness vs average fitness at that iteration');
xlim([-10 65]);
ylim([0 65]);
grid on

figure3 = figure;
plot(bestFunction,'o--');
xlabel ('aveFit'); %x_axis
ylabel ('fitTot'); %y_axis
title ('Evolution of Best Function');
xlim([-10 65]);
ylim([0 65]);
grid on
%% TTime
t = datetime('now');
disp(t);
%% Modification History
% Eleanor McSporran [ECM]
% [ECM] : DD/MM/YY : Edit Description

% [ECM] : 27/02/19 : Added run_it to allow for plots to be adjusted
%                    To be noted there is an issue with aveFitFinal
% [ECM] : 21/12/18 : Completed Algorithm.
% [ECM] : 20/12/18 : Adding the deterministic crowding method.
% [ECM] : 19/12/18 : Correcting flaws.
% [ECM] : 14/12/18 : Edited the plotting functions and updated other varibles.
% [ECM] : 14/12/18 : Edited the final method that sorts the fitness.
% [ECM] : 14/12/18 : Changed random point constructor.
% [ECM] : 13/12/18 : Mutating and Selection methods created.
% [ECM] : 12/12/18 : Script created.
% [ECM] : 12/12/18 : Edited.

