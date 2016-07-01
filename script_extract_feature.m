% This script to loop over the video clips in MIT dataset and perform
% background subtraction using robust PCA approach.

clear all

r=480; c=720;

Ndf=300;
bszr=r/4; bszc=c/4;
p1=r/bszr; p2=c/bszc;
M=zeros(bszr*bszc,Ndf);
S=zeros(Ndf,r,c);


for vid=1:20
    fprintf('%d ',vid);
    drname=sprintf('S\\v2_%03d',vid);
    mkdir(drname);
    for m=0:Ndf:8000-Ndf
        for ir=1:p1
            for ic=1:p2
                for nf=1:Ndf
                    filename=sprintf('JPEGS\\v2_%03d\\%08d.jpg',vid,m+nf);
                    I1=imread(filename);
                    I=rgb2gray(I1);
                    a=I((ir-1)*bszr+1:ir*bszr,(ic-1)*bszc+1:ic*bszc);
                    b=reshape(a,1,bszr*bszc);
                    M(:,nf)=b;
                end
                S1=zeros(size(M));
                [n1,n2] = size(M);
                tau = max(sum(sum(M))/n1/n2/10,8);
                for iter=1:7
                    ms=sum(M-S1,2)/Ndf;
                    L=ms(:,ones(1,Ndf));
                    X=M-L;
                    S1=sign(X).* max(abs(X)-tau,0);
                end
                for nf=1:Ndf
                    S(nf,(ir-1)*bszr+1:ir*bszr,(ic-1)*bszc+1:ic*bszc)=reshape(S1(:,nf),bszr,bszc);
                end
            end
        end
        for nf=1:Ndf
            I1=reshape(abs(S(nf,:,:)),r,c);
            I2=im2bw(I1,0);
            s=medfilt2(I2,[7 7]);
            filename=sprintf('S\\v2_%03d\\%08d.png',vid,m+nf);
            imwrite(s,filename);
        end
    end
end

% store the processed data into mat file
S=reshape(S,Ndf,r*c);
save('mit_surveillance_processed_data.mat',S);