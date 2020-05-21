%% Preface: 
% This code is to simulate the glucose-responsive GFP-ssrA and RFP-ssrA
% levels in human body. Due to the scope and available time of this 
% project, many trivial parameters are based on reasonable assumptions.
% Those parameters can be chagned according to real reaction mechanisms. 

%% common parameters
clear all
lower_limit=0.053; %this is the lower limit
glucose=linspace(0.1,20,50); % glucose range
multi=3; 
%% GFP-ssrA
%RFP is using suffix "r", GFP is using "g"
r_g=10; 
theta_g=10;
gate=10; % the gate value of glucose  
gate_gap=0.3; % this value is control the gradient of green jump
for i=1:length(glucose)
if glucose(i)<=gate
    w_g=0;
elseif glucose(i)>=(gate+gate_gap)
    w_g=1;
else
    w_g=((glucose(i)-gate)/gate_gap)^0.1;
end
p_g(i)=r_g*w_g/theta_g+lower_limit;
end
color_g=[70/255,148/255,73/255];
plot(glucose,p_g,'Color',color_g,'LineWidth',1.5)
ylim([-2,12])
hold on
%% RFP-ssrA
r_r=10; 
theta_r=10;
n=2; % power
limit1=0.2;
gate_red2=gate+gate_gap*multi;
gate_red3=1.2;
for j=1:length(glucose)
if glucose(j)>=gate_red2
    w_r=0;
elseif glucose(j)<=gate_red3
    w_r=1;
else
    w_r=1-(glucose(j)/gate_red2)^n;
end
p_r(j)=r_r*w_r/theta_r+lower_limit;
end
value=spcrv([[glucose(1) glucose glucose(end)];[p_r(1) p_r p_r(end)]],5);
color_r=[175/255,54/255,60/255];
plot(value(1,:),value(2,:),'Color',color_r,'LineWidth',1.5)
ylim([-0.5,1.5])
legend('GFP-ssrA','RFP-ssrA','location','best')
title('concentration of protein vs. glucose')
xlabel('Glucose [mmol/L]')
ylabel('Protein [mmol/GDW]')
