%lorenz_eval.m
set(0,'defaultlinelinewidth',2)

% plottype 1: time trace
% plottype 2: dt distribution timing
% plottype 3: divergence study
plottype = 1;

% usecompiled: if true, use optimized mex function
usecompiled = true;

statRep = 100;
if plottype == 1
	steps = uint64(1e5);
	numTests = 1;
	statRep = 1;
elseif plottype == 2
	steps = uint64(1e7);
	numTests = 1;
else
	steps = uint64(1e5);
	numTests = 74;
end
metaNs = zeros(1,statRep);

dt0 = .015; %.02;
dtdt = .0002;

diverge = zeros(1,numTests);
for j = 1:statRep
for i = 1:numTests
	dt = dt0 + i*dtdt;
	tic;
    if usecompiled
        Y = lorenz_sim_mex(steps,dt); % one million time steps of the Lorenz system
    else
        Y = lorenz_sim(steps,dt); % one million time steps of the Lorenz system
    end
	T = toc;
	nsper = T/double(steps)*1e9;
	metaNs(j) = nsper;
	diverge(i) = diverge(i) + any(isnan(Y(:,end)))/statRep;
	disp(['Test ', num2str(j), ' : ', num2str(nsper), ' ns per time step.'])
	if plottype == 1
		figure(1);
		set(gcf,'Position', [100, 300, 560, 420]);
		clf; hold on;
		cmap = colormap(lines);
		% set this number to make sure there are the right number of peaks in the window
		maxInd = ceil(23/dt);
		% 24.5ns is the average dt we measured well
		goodDt = 24.5e-3;
		
		c(1,:) = cmap(1,:);
		c(2,:) = cmap(5,:) + [-.2,.0,.3] - .05*ones(1,3);
		c(3,:) = cmap(2,:);
        scale(1,1) = .9;
		scale(2,1) = .7;
		scale(3,1) = .7;
        scale = scale * .9;
        
        % plotting data cells
        tPlt = {goodDt*(1:maxInd)}; % in us
        xPlt = {Y(:,(1:maxInd)) ./ repmat(scale,1,maxInd)};
        ctrnnFile = './ctrnn data/lorenz_signals.mat';
        if exist(ctrnnFile,'file')
            m = matfile(ctrnnFile);
            ds = floor(length(m.time) / maxInd / 2);
            tPlt{2} = downsample(m.time, ds) * 1e-3; % starts in ns
            xPlt{2} = downsample(m.x', ds)';
        end
        
         % scaling and limits for both plots
		lim = max(max([xPlt{:}])) * [-1,1] + .2;
        tks = [-30, 0, 30];
        
        % Time trace plot
        for iPlt = 1:length(tPlt)
            subplot(length(tPlt), 1, iPlt);
            hold on
            for chan = 1:3
                plot(tPlt{iPlt}, xPlt{iPlt}(chan,:), 'color',c(chan,:));  
            end
            xlabel('Real time (\mu s)','Interpreter','tex')
            ylabel('Simulation variables: x (a.u.)')
            box on
            set(gca,'fontsize',16)
            set(gca,'linewidth',2)
            xlim([0, inf])
            ylim(lim)
            set(gca, 'Ytick', tks);
        end
		
		% Phase plot
		figure(2);
		set(gcf,'Position', [660, 200, 310, 520]);
		clf;
% 		phaseMaxInd = ceil(size(Y,2)/8);
% 		xPlt{1} = Y(:,1:phaseMaxInd) ./ repmat(scale, 1, phaseMaxInd);
        for iPlt = 1:length(xPlt)
            subplot(length(xPlt), 1, iPlt);
            plot3(xPlt{iPlt}(1,:), xPlt{iPlt}(2,:), xPlt{iPlt}(3,:));
            box on
            grid on
%             xlabel('x_1 (a.u.)')
%             ylabel('x_2 (a.u.)')
%             ylabel('x_3 (a.u.)')
            set(gca,'linewidth',1)
            
            xlim(lim);
            ylim(lim);
            zlim(lim);
%             axis tight
            set(gca, 'Xtick', tks);
            set(gca, 'Ytick', tks);
            set(gca, 'Ztick', tks);
            set(gca, 'CameraPosition', [-1.7, 1.7, 1.6]);
            drawnow;
            set(gca, 'CameraPosition', [43, -153, 60]);
        end
	end
	%clear mex
end
end

M = mean(metaNs)
V = var(metaNs)

if plottype == 2
	figure
	histogram(metaNs,30,'facecolor','k')
	xlabel('\Delta t (ns)')
	ylabel('Instances')
	box on
	set(gca,'fontsize',16)
elseif plottype == 3
	figure
	plot(dt0 + dtdt*(1:numTests),diverge,'k')
	ylim([-.05, 1.05]);
	box on
	set(gca,'fontsize',16)
	xlabel('\Delta t','Interpreter','tex')
	ylabel('Divergenge probability')
end