function Y = lorenz_sim(steps,dt)
% To make mex files for this, run "codegen lorenz_sim"
% You can call that optimized function as "lorenz_sim_mex(steps,dt)"

assert(isa(steps, 'uint64'));
assert(isscalar(steps));
assert(isa(dt, 'double'));

% select precision
%precis = @(x) double(x);

% The values of the global parameters are
%global SIGMA RHO BETA
s = 1.0;
SIGMA = (10) * s;
BETA = (8./3.) * s;
RHO = (28.) * s;

%y0 = ([rand*30+5, rand*35-30, rand*40-5]);
y0 = rand(1,3);
% y0 = [.12, 0, 0]; % for repeatability

%dt = (.1);
tmax = steps;

y = y0';
Y = (zeros(3,tmax));
x=0;
%tic
unroller = 1;
for i = 1:tmax/unroller
	% Compute the slopes
% 	s(1) = SIGMA * (y(2) - y(1));
% 	s(2) = -y(1)*y(3) - y(2) + RHO*y(1);
% 	s(3) = y(1)*y(2) - BETA*y(3);
% 	

for j = coder.unroll(1:unroller)
	dy = [SIGMA * (y(2) - y(1)); ...
		(-y(1)*y(3) - y(2)); ...
		y(1)*y(2) - BETA*(y(3) + RHO)];
	y = y + dt * dy;
	x=x+1;
	Y(:,x) = y;
end
 	
% x=y;
% y(1) = plus(x(1), times(dt, times(SIGMA, plus(x(2), - x(1)))));
% y(2) = plus(x(2), times(dt, plus(plus(times(-x(1), x(3)), -x(2)), times(RHO, x(1)))));
% y(3) = plus(x(3), times(dt, plus(times(x(1), x(2)), times(-BETA, x(3)))));	
end
% T = toc;
% disp(['It took ', num2str(T/tmax*1e6), ' us per time step using my own Euler'])

% tic
% [t, y] = ode23(@myODE, [0, tmax*dt], y0');
% T = toc;
% disp(['It took ', num2str(T/length(t)*1e6), ' us per time step using MATLAB ode45'])

% plot(1:400,Y)
% plot3(Y(1,:),Y(2,:),Y(3,:))

% 	function c = plus(a,b)
% 		c = a+b;
% 	end
% 
% 	function c = times(a,b)
% 		c = a*b;
% 	end
% 
% 	function dydt = myODE(t, y)
% 		dydt = [SIGMA * (y(2) - y(1)); ...
% 			-y(1)*y(3) - y(2) + RHO*y(1); ...
% 			y(1)*y(2) - BETA * y(3)];
% 	end
end

