%Input dialog 
function input()
prompt = {'X-coordinate of sphere - X_0:'...
    'Y-coordinate of sphere - Y_0:'...
    'Z-coordinate of sphere - Y_0:'...
    'Radius of sphere:'...
    'X-coordinate of lightning - X_L:'...
    'Y-coordinate of lightning - Y_L:'...
    'Z-coordinate of lightning - Y_L:'};
title = 'Input values';
num_lines = 1;
dims = [1 60];
definput ={'-3','-3','-3','3','3','3','3'};
opts.Interpreter = 'tex';
answer = inputdlg(prompt,title,dims,definput,opts);
x0 = (str2num(answer{1})); 
y0 = (str2num(answer{2}));
z0 = (str2num(answer{3}));
r = (str2num(answer{4})); 
xl = (str2num(answer{5}));
yl = (str2num(answer{6})); 
zl = (str2num(answer{7}));

output(x0,y0,z0,r,xl,yl,zl);
end

%Simulation 
function output(x0,y0,z0,r,xl,yl,zl)
close
[x,y,z] = sphere;
figure
s1 = surf(x*r+x0,y*r+y0,z*r+z0);
SphereSpec()
hold on
s2 = surf(x*(r/13)+xl,y*(r/13)+yl,z*(r/13)+zl);
set(s1, 'FaceColor', [1 0 0])
shading interp
set(s2, 'FaceColor', [1 1 0])

projection(x0,y0,z0,r,xl,yl,zl)
axis equal
axis off

fig = gcf;
fig.Color = [0 0 0];
pause;
input 
end

%Lightning and projection 
function projection(x0,y0,z0,r,xl,yl,zl)
l = light('Position',[xl yl zl]);
l.Color = [1 1 0.8];
xp = xl-x0;
yp = yl-y0;
zp = zl-z0;
P = [xp yp zp];
vecP = sqrt(xp^2+yp^2+zp^2);
Q = (r/vecP) * P;
R = Q + [x0 y0 z0];

P1 = R;
P2 = [xl,yl,zl];
pts = [P1; P2];
p=line(pts(:,1), pts(:,2), pts(:,3));
c = p.Color;
p.Color = 'yellow';
end

%Grid Specification
function SphereSpec()
map = [0.2 0.2 0.7];
colormap(map)
material shiny
view([-160 25])
end



