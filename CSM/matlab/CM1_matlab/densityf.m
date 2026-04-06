function df=densityf(data,savedata);

e_value=sum(data)/length(data);
step=(max(data)-min(data))/100;
treshold=[min(data):step:max(data)]; 

df=zeros(1,length(treshold));



for k=1:(length(treshold)-1)
  for j=1:length(data)
        if ((data(j)>=treshold(k)) && (data(j)<treshold(k+1))) df(k)=df(k)+1;
        end
  end
end    

df=100*df/length(data);

if strcmp(savedata,'on')
    plot(treshold,df);
    ylabel('Conditional Probability Density [%]');
    xlabel('Amplitude');
    xlim([min(data) max(data)]);
end