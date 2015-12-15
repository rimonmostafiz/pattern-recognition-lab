function heart()

trData = csvread('heart_train.csv');
tsData = csvread('heart_test.csv');
    
Ocnt0 = 1;
Ocnt1 = 1;

Tcnt0 = 1;
Tcnt1 = 1;

for i=1:203
    trData(i, 5) = trData(i, 5) - 1;
end

for i=1:67
    tsData(i, 5) = tsData(i, 5) - 1;
end

for i=1:203
    if (trData(i, 5)==0)
        cc0(Ocnt0) = trData(i, 1);
        Ocnt0 = Ocnt0 + 1;
    else
        cc1(Ocnt1) = trData(i, 1);
        Ocnt1 = Ocnt1 + 1;
    end
    
    if (trData(i, 5)==0)
        CC0(Tcnt0) = trData(i, 4);
        Tcnt0 = Tcnt0 + 1;
    else
        CC1(Tcnt1) = trData(i, 4);
        Tcnt1 = Tcnt1 + 1;
    end
end

%Mean and SD for first continious data
OM0 = mean(cc0);
OM1 = mean(cc1);

OSD0 = std(cc0);
OSD1 = std(cc1);
%%%%%END

%Mean and SD for second continious data
TM0 = mean(CC0);
TM1 = mean(CC1);

TSD0 = std(CC0);
TSD1 = std(CC1);
%%%% END

TrC0 = zeros(4, 4);
TrC1 = zeros(4, 4);

%%Training
for i=1:203
    for j=1:4
        if(j==2 || j==3)
            val = trData(i, j);
            if(j==2)
                val = val + 1;
            end
            if(trData(i, 5)==0)
                TrC0(j, val) = TrC0(j, val) + 1;
            else
                TrC1(j, val) = TrC0(j, val) + 1;
            end
        end
    end
end
%Training End

sum1 = sum(sum(TrC0));
sum2 = sum(sum(TrC1));

fprintf('sum1 = %d\n', sum1);
fprintf('sum2 = %d\n', sum2);

Error = 0;

for i=1:67
    PC0 = 1;
    PC1 = 1;
    for j=1:4
        if(j==2 || j==3)
            val = tsData(i, j);
            if(j==2)
                val = val + 1;
            end
            tot = TrC0(j, val) + TrC1(j, val);
            PC0 = PC0 * (TrC0(j, val) / tot);
            PC1 = PC1 * (TrC1(j, val) / tot);
        elseif(j==1)
            PC0 = PC0 * normpdf(tsData(i, j), OM0, OSD0);
            PC1 = PC1 * normpdf(tsData(i, j), OM1, OSD1);
        elseif(j==4)    
            PC0 = PC0 * normpdf(tsData(i, j), TM0, TSD0);
            PC1 = PC1 * normpdf(tsData(i, j), TM1, TSD1);
        end
    end
    PC0 = PC0 * sum1/(sum1+sum2);
    PC1 = PC1 * sum2/(sum1+sum2);
    
    if(PC0 > PC1)
        cls = 0;
    else
        cls = 1;
    end
    if(cls~=tsData(i, 5))
        Error = Error + 1;
    end
end

fprintf('Error = %d\n', Error);

end