% MW; Capacity Factor; Heat Rate; CO2 rate; NOx rate
% [num,txt]=csvread('Arizona.csv');
% n=find(strcmp(txt(1,1:end),'Heat_rate_MMBtu/MWh'));
% I=num(1:length(t),n-1);

st = {'Arizona.csv'; 'California.csv'; 'Florida.csv'; 'Massachusetts.csv';...
    'Nevada.csv'; 'New-Jersey.csv'; 'New-Mexico.csv'; 'New-York.csv';...
    'Texas.csv'};

co2 = zeros(200,9);
mw = zeros(200,9);
cap = zeros(200,9);
heat = zeros(200,9);
nox = zeros(200,9);
run = zeros(200,9);
co2_gen = zeros(200,9);
en_cap = zeros(200,9);
cog2_gen_sun = zeros(1, 9);
co2_pp = zeros(1,9);
en_pp = zeros(1,9);
en_cap = zeros(200,9);

for i = 1:9
    % read csv
    a =readmatrix(st{i});
    idx = isnan(a); a(idx) = 0;
    
    % get co2, MW, heat, cap
    co2(1:height(a),i) = a(:, 10);
    mw(1:height(a),i) = a(:, 5);
    heat(1:height(a),i) = a(:, 9);
    cap(1:height(a),i) = a(:, 7)/100;
    run(1:height(a),i) = a(:,8);
    
    % get co2 generation, energy generation
    co2_gen(:,i) = co2(:,i) .* mw(:,i) .* cap(:,i) .* 8760;
    en_cap(:,i) = mw(:,i) .* cap(:,i);
    %en_cap(:,i) = en_gen(:,i) ./8760;
    
    % get number of peaker plants for co2 for each state
    co2_pp(i) = sum(co2_gen(:,i)~=0);
    en_pp(i) = sum(en_cap(:,i)~=0);
end

% sum co2 gen per states
co2_gen_sum = sum(co2_gen);
en_gen_sum = sum(en_cap);
%en_gen_cap = sum(en_cap);

% sum co2 gen all states

co2_gen_sum_all = sum(co2_gen_sum)
en_gen_sum_all = sum(en_gen_sum)

% get sum of peaker plants
co2_pp_sum = sum(co2_pp);
en_pp_sum = sum(en_pp);

% % get mean values and multiply by 1000
% co2_gen_mean = co2_gen_sum_all/co2_pp_sum;
% co2_mean_1000 = co2_gen_mean*1000

% get co2 and energy gen for 1000 plants
co2_1000 = co2_gen_sum_all*(1000/co2_pp_sum) % tons
en_1000 = en_gen_sum_all*(1000/en_pp_sum) % MW
%en_1000/24/365/1000 %MW

%cap_1000 = en_gen_cap *1000/en_pp_sum



percent = en_1000/1200000; %1.2MW capcity 

%1.1MW

