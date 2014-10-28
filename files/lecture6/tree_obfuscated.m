% Niru Maheswaranathan 2012 - Example of obfuscated code

b = 1e2;
r = 0.7;
mx = 2;
mt = -pi/4;
s = 0.1;
tmx = [-0.5 0.5 0 0.5];
dt = 0.01;

t = {}; t{1} = [0 0 pi/2 0]; br = ones(length(t),1);
figure(1); axis([-1 1 -1 3]);
plot(t{1}(:,1), t{1}(:,2), 'k.');

while length(t) < 50
figure(1); clf; hold on; 
for bidx = 1:length(t)
if br(bidx)
temp = t{bidx}; len = size(temp,1);
temp = [temp; temp(len,1) + dt*round(cos(temp(len,3))*1e3)/1e3*(r^temp(len,4)) ...
temp(len,2) + dt*round(sin(temp(len,3))*1e3)/1e3*(r^temp(len,4)) ...
temp(len,3) temp(len,4)];
t{bidx} = temp;
if len*dt > sqrt(rand)
theta = mt + s*randn;
br(bidx) = 0;
t{length(t)+1} = [temp(len,1) temp(len,2) temp(len,3)+theta temp(len,4)+1];
br(end+1) = 1;
t{length(t)+1} = [temp(len,1) temp(len,2) temp(len,3)+theta+pi/2 temp(len,4)+1];
br(end+1) = 1;
end
end
temp = max(t{bidx}(:,2)); if tmx(4) < temp tmx(4) = temp; end
temp = min(t{bidx}(:,1)); if tmx(1) > temp tmx(1) = temp; end
temp = max(t{bidx}(:,1)); if tmx(2) < temp tmx(2) = temp; end
th = 10-t{bidx}(1,4); if th <= 0 th = 1; end
plot(t{bidx}(:,1), t{bidx}(:,2), 'k-', 'LineWidth', th);
end
axis(tmx); title(['# of Branches: ' num2str(length(t))]); drawnow;
end