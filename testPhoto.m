rlen0=[];rd0=[];gd0=[];bd0=[];
for p=1:50
 system('wget https://source.unsplash.com/random');
 im=imread('random');
 sz=size(im);
 # get differences
 d=reshape(int16(im(:,2:end,:))-int16(im(:,1:end-1,:)),[sz(1)*(sz(2)-1) sz(3)]);
 # see which ones are runs (no diff)
 d0=sum(abs(d),2);
 dd0=double((d0(2:end)==d0(1:end-1))&(d0(2:end)==0));
 # tag run begginings and end
 dd0=[0;dd0;0];
 ddd1=find((dd0(2:end)==0)&(dd0(1:end-1)==1));
 ddd2=find((dd0(2:end)==1)&(dd0(1:end-1)==0));
 # compute run length
 rlen=(ddd1-ddd2)+1;
 # collect run lengths
 rlen0=[rlen0;rlen];
 # find diffferences and collect them
 d(d0==0,:)=[];
 rd0=[rd0;d(:,1)];
 gd0=[gd0;d(:,2)];
 bd0=[bd0;d(:,3)];
 # wait a little bit before getting a new photo so as not to disturb mr. internet
 delete('random');
 pause(100*rand(1,1));
end
# run log length histogram
figure;hist(log10(rlen0),round(sqrt(length(rlen0))));title('identical run lengths');xlabel('log10(run number)');
# color diff histograms
figure;hist(rd0,round(sqrt(length(rd0))));title('red difference from previous pixel');xlabel('R difference (current-previous)');
figure;hist(gd0,round(sqrt(length(gd0))));title('green difference from previous pixel');xlabel('G difference (current-previous)');
figure;hist(bd0,round(sqrt(length(bd0))));title('blue difference from previous pixel');xlabel('B difference (current-previous)');
# correlation of color differences
id=round(linspace(1,length(rd0),1e5));
figure;scatter(double(rd0(id))+randn(size(rd0(id)))*0.1,double(gd0(id))+randn(size(gd0(id)))*0.1,'.');title('red vs. green difference from previous pixel');xlabel('red');ylabel('green');
figure;scatter(double(gd0(id))+randn(size(gd0(id)))*0.1,double(bd0(id))+randn(size(bd0(id)))*0.1,'.');title('green vs. blue difference from previous pixel');xlabel('green');ylabel('blue');
figure;scatter(double(bd0(id))+randn(size(bd0(id)))*0.1,double(rd0(id))+randn(size(rd0(id)))*0.1,'.');title('blue vs. red difference from previous pixel');xlabel('blue');ylabel('red');
