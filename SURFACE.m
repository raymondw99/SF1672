syms D x y z

%Input dialog 

prompt = {'X-coordinate of lightning - X_L:'...
         'Y-coordinate of lightning - Y_L:'...
         'Z-coordinate of lightning - Y_L:'};
title = 'Input values';
num_lines = 1;
dims = [1 60]; 
definput ={'0', '-10', '0'}; %Standard input 
opts.Interpreter = 'tex';
answer = inputdlg(prompt,title,dims,definput,opts); %Generating dialog box
%Execution and definition of variables
xl = (str2num(answer{1})); 
yl = (str2num(answer{2}));
zl = (str2num(answer{3}));
z = x.^2-y.^2; %Function definition
output(xl,yl,zl);
projection(x,y,z,xl,yl,zl);
 
%Lightning and projection 
function projection(x,y,z,xl,yl,zl)
l = light('Position',[xl yl zl]); 
l.Color = [1 1 0.8];
D = sqrt((x-xl).^2 + (y-yl).^2 + (sqrt(z)-zl).^2); %Calculating distance
 
eqnx = diff(D.^2,x) == 0; %Apply partial derivative test
eqny = diff(D.^2,y) == 0;
soly = solve(eqny, y); %Solve for x,y,z
solx = solve(eqnx, x);
solz = solx.^2-soly.^2;

%Drawing line between light source and sphere
P1 = [solx, soly, solz]; %Specifying points
P2 = [xl,yl,zl];
pts = [P1; P2];
p=line(pts(:,1), pts(:,2), pts(:,3)); %Drawing line 
p.LineWidth = 4;
p.Color = [0.7 0.7 0.7];
end
 
%Simulation 
function output(xl,yl,zl)
[X,Y] = meshgrid(-3:0.2:3); %Generating graph
Z = X.^2-Y.^2;
s1 = surf(X,Y,Z);
 
hold on 
[x,y,z] = sphere; %Generating light source 
s2 = surf(x*0.4+xl,y*0.4+yl,z*0.4+zl);
FuncSpec();

%Grid Specification
shading interp
axis equal
axis off
fig = gcf;
fig.Color = [0 0 0];
end


%Specifications of surface 
function FuncSpec()
map = [1 0 0];
colormap(cool)
material shiny
daspect([1 1 1])

end

