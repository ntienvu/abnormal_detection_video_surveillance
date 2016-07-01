
clear;
close all;

%% load MIT traffic dataset
load('mit_surveillance_processed_data.mat');
Nrows = 24;Ncols = 36; winSize = 1;

% N: number of data point
% D: feature size
[N,D]=size(data);
X=data';

% plot the feature matrix
figure;imagesc(X);
xlabel('Sequence of Frames');
ylabel('Dimension 24x36');
title('Feature Data');

%% perform nonnegative matrix factorization
% In the paper, we use Bayesian Nonparametric Factor Analysis which
% identifies K=40 hidden patterns from the data. However the posterior
% inference is slow. Thus, here we use the built-in function nnmf from
% Matlab for optimizing speed.

KK=40; % number of pattern
% X = W * H
% X [ D x N], W [ D x K ], H[ K x N];
[WW,HH] = nnmf(X,KK);

% compute sum each row of hh
sum_HH = sum(HH,2);

% ranking the patterns from the most common to rare (abnormal)
[sum_HH_sorted,sortedInd] = sort(sum_HH,'descend');

WW_sorted = WW(:,sortedInd);
HH_mat_sorted =  HH(sortedInd,:);

%% finding abnormal patterns from the data
% plot top 3 common patterns
for ii=1:3
    Img_In=reshape( WW_sorted(:,ii),[24 36]);
    Img_Out=Overlay_MIT_Background(Img_In);
    figure;    imshow(Img_Out);
    strTitle=sprintf('Common (Not Abnormal) Pattern %d',ii);
    title(strTitle);
end

% plot top 3 abnormal patterns
TopKAbnormal=3;
for kk=(KK-TopKAbnormal+1):KK
    Img_In=reshape( WW_sorted(:,kk),[24 36]);
    Img_Out=Overlay_MIT_Background(Img_In);
    figure;    imshow(Img_Out);
    strTitle=sprintf('Abnormal Pattern %d',40-kk+1);
    title(strTitle);
end

%% finding abnormal data points
sum_HH_abnormal=sum(HH_mat_sorted(KK-TopKAbnormal+1:KK,:));
[sum_HH_abnormal_sorted idxSorted]=sort(sum_HH_abnormal,'descend');

% select top 0.05% data points as abnormal
selectTop1Percent=ceil(0.05*N);
fprintf('Number of abnormal points is %d at index:\n',selectTop1Percent);
disp(idxSorted(1:selectTop1Percent));
