% MCPA
% Joseph Suthons 101083528
% 1D electron sim tool

clear all
close all
clc

% init param
iterations = 1000;
e(iterations+1) = struct();
nparticles = 3;
e(1).pos = zeros(nparticles,1);
e(1).v = zeros(nparticles,1);
m = 9.1e-31;
force = 3e-28;

timeBetweenSteps = 0.5;

% plot init
figure 

subplot(3,1,1)
hold on
plot (0,e(1).pos)
title('Accelerating Particle')
xlabel('Time')
ylabel('x-position')

subplot(3,1,2)
hold on
plot (0,e(1).v)
xlabel('Time')
ylabel('velocity')

subplot(3,1,3)
hold on
plot (0,0)
xlabel('Time')
ylabel('avg drift velocity')

% sim
drift = zeros(nparticles,iterations+1);
for t= 1:iterations % each iteration is 1 time step
    for p = 1:nparticles % goes through each particle to see if it scattered
        if rand(1) > 0.05
            % didn't scatter
            e(t+1).v(p,1) = e(t).v(p,1)+force/m;
            e(t+1).pos(p,1) = e(t).pos(p,1) + e(t).v(p,1);
        else
            % scatter. velocity set to 0
            e(t+1).v(p,1) = 0;
            e(t+1).pos(p,1) = e(t).pos(p,1);
        end
    end

    %finds avg drift velocities
    drift(:,t+1) = (drift(:,t) .* t + (e(t+1).v))./(t+1);

    % plot
    subplot(3,1,1)
    set(gca,'ColorOrderIndex',1)
    hold on
    plot(timeBetweenSteps*[t:t+1],[e(t:t+1).pos])
        %changes title to updating drift velocity
    title (strcat('Drift velocity:',{' '},sprintf('%0.2e',sum(drift(:,t+1))/nparticles)) )
        
    subplot(3,1,2)
    set(gca,'ColorOrderIndex',1)
    hold on
    plot(timeBetweenSteps*[t:t+1],[e(t:t+1).v])
        
    subplot(3,1,3)
    set(gca,'ColorOrderIndex',1)
    hold on
    plot (timeBetweenSteps*[t:t+1],[drift(:,t:t+1)])

    % delay added for veiwing plot as movie
    pause(0.0001)
end





















