figure;
width=1800;%宽度，像素数
height=500;%高度
left=60;%距屏幕左下角水平距离
bottom=240;%距屏幕左下角垂直距离
set(gcf,'position',[left,bottom,width,height]);
N = 100;
D = 100;
x = D*rand(N,1);
x = [1:10 1:10 1:10 1:10 1:10 1:10 1:10 1:10 1:10 1:10];
y = D*rand(N,1);
vel = D/20*rand(N,2);
o = ones(1,10);
y = [o 2*o 3*o 4*o 5*o 6*o 7*o 8*o 9*o 10*o];
d2 = 1000;
d2 = 30;
%draw network
subplot(1,3,1);
scatter(x,y);
hold on;
title('Position');
hold off;
subplot(1,3,2);
scatter(x,y);
title('Connectivity');
hold on;
A = zeros(N);
for i=1:N-1
    for j=i+1:N
        if ((x(i)-x(j))^2+(y(i)-y(j))^2<d2)
            A(i,j) = 1;
            plot([x(i) x(j)],[y(i) y(j)]);
        end
    end
end
hold off;
%draw relay selection result using Prim
subplot(1,3,3);
scatter(x,y);
title('MLST');
hold on;
%relay node selection using Maximally Leafy Forest 
A = A+A';%+eye(size(A,1));
%A(A==0) = Inf;
[F,R] = MLST(A);
for i=1:N-1
    plot([x(F(1,i)+1) x(F(2,i)+1)],[y(F(1,i)+1) y(F(2,i)+1)]);
end
scatter(x(R==1),y(R==1),'filled');
linkaxes([subplot(1,3,2),subplot(1,3,3)],'xy');
hold off;