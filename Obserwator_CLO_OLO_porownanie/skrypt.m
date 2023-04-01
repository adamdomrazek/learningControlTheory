%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Różnica pomiędzy obserwatorem zamkniętym a otwartym
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clc
clear

%% odpalić żeby mieć parametry w simulinku
S  = 1;
K  = 0.02; 
c1 = 1;
c2 = 2;
F1pp = 0.015;
F2pp = 0.005;

%% sim params
end_time = 15;

%% 
duap = sim("MODEL_nieliniowy.slx");

%% rezultaty
tout = duap.tout;
c_approx_clo = duap.logsout{7}.Values.Data;
h_approx_clo = duap.logsout{8}.Values.Data;

c_orig = duap.logsout{9}.Values.Data;
h_orig = duap.logsout{10}.Values.Data;

% %% ploty
% 
% % FIG 1
% fig = figure(1);
% ax = subplot(2, 1, 1);
% hold(ax, 'on');
% 
% sp = plot(tout, c_orig);
% sp = plot(tout, c_approx_clo);
% 
% legend('c oryginalne', 'c estymowane');
% grid(ax, 'on');
% hold(ax, 'off');
% 
% ax = subplot(2, 1, 2);
% hold(ax, 'on');
% 
% sp = plot(tout, h_orig);
% sp = plot(tout, h_approx_clo);
% 
% legend('h oryginalne', 'h estymowane');
% grid(ax, 'on');
% hold(ax, 'off');






