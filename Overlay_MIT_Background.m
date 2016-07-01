function Img_Out=Overlay_MIT_Background(Img_In)
% this function to overlay the pattern (Img_In) with the background from
% MIT dataset for visualization purpose.

Sam_Img=imread('mit_bg.jpg');
r = 480;
c = 720;
bszr = 20;
bszc = 20;

% scale the data
Img_In=Img_In./sum(Img_In(:));
Img_In=Img_In.*100;

Img_Out=zeros(r,c,3,'uint8');
Img_Out(:,:,2)=Sam_Img(:,:,2);
Img_Out(:,:,3)=Sam_Img(:,:,3);
Img_Out(:,:,1)=Sam_Img(:,:,1);

for i=1:24
    for j=1:36
        if(Img_In(i,j)~=0)
            Img_Out((i-1)*bszr+1:i*bszr,(j-1)*bszc+1:j*bszc,2)=Img_Out((i-1)*bszr+1:i*bszr,(j-1)*bszc+1:j*bszc,2)+uint8(Img_In(i,j)*255*ones(bszr,bszc));
        end
    end
end

end