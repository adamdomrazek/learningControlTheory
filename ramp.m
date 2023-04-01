function y = ramp(t, m, d)
% t - czas support'u
% m - slope
% d - delay
N = length(t);
y = zeros(1,N);
for i = 1:N     % dla każdego sampla
    if t(i) >= -d
        y(i) = m * (t(i)+d);
    end
end
end