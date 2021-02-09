close
clear 
clc
%% Loading the diameters data
Raw_D = importdata('Results_10x2.txt');
Raw_D = Raw_D.data ;
 
%% Sorting the diameters in the descending form
D_sort = sort(Raw_D(:,2),'ascend') ;
di2 = D_sort.^2 ; 
di3 = D_sort.^3 ; 
di4 = D_sort.^4 ; 
%% First calculations
Drops_n = length(D_sort) ; % total number of droplets
sum_di = sum(D_sort);
sum_di2 = sum(di2);
sum_di3 = sum(di3);
sum_di4 = sum(di4);
D10 = sum_di ./ Drops_n ;
D20 = sqrt(sum_di2 ./ Drops_n) ; 
D21 = sum_di2 ./ sum_di ;
D32 = sum_di3 ./ sum_di2 ;
D31 = sqrt(sum_di3 ./ sum_di) ;
D30 = power(sum_di3 ./ Drops_n , 1/3) ;
D43 = sum_di4 ./ sum_di3 ;
%% Distributions
vol_per = di3 ./ sum_di3 ;
cumm_vol = zeros(length(vol_per),1);
cumm_vol(1) = vol_per(1) ;
for i = 2:length(vol_per)
cumm_vol(i) = vol_per(i) + cumm_vol(i-1) ;
end


num_per = zeros(Drops_n,1);
for i = 1:length(vol_per)
num_per(i) = i ./ Drops_n ;
end

%% output and plots
Values = [D10;D20;D21;D32; D31; D30; D43] ;
Rep_diameters = {'D10';'D20';'D21';'D32';'D31';'D30';'D43' } ;
T = table(Rep_diameters,Values);
writetable(T,'tabledata.txt','Delimiter','\t','Writerownames',true);
type tabledata.txt


figure (1)
plot(D_sort,cumm_vol)
xlabel('Size (micro meters)')
ylabel('Cummulative volume')

figure (2)
histogram(D_sort,'normalization','cdf')
xlabel('Size (micro meters)')
ylabel('Number of drops')

figure (3)
plot(D_sort,num_per)
xlabel('Size (micro meters)')
ylabel('Cummulative probability')


Cum_numeric = [D_sort,num_per] ;
Cum_volumetri = [D_sort,cumm_vol];
