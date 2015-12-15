function Guess()

trData = csvread('germanTrain.csv');
tsData = csvread('germanTest.csv');

cnt1 = 1;
cnt2 = 1;
MOD = [10 0 29 90 100 190 200];

for i=1:800
    if (trData(i, 8)==1)
        cc1(cnt1) = trData(i, 2);
        cnt1 = cnt1 + 1;
    else
        cc2(cnt2) = trData(i, 2);
        cnt2 = cnt2 + 1;
    end
end

M1 = mean(cc1);
M2 = mean(cc2);

SD1 = std(cc1);
SD2 = std(cc2);

TC1 = zeros(7, 5);
TC2 = zeros(7, 5);

for i=1:800
    for j=1:7
        if(j~=2)
            val = trData(i, j);
            idx = mod(val, MOD(j));
            if(trData(i, 8)==1)
                TC1(j, idx) = TC1(j, idx) + 1;
            else
                TC2(j, idx) = TC2(j, idx) + 1;
            end
        end
    end
end

sum1 = sum(sum(TC1));
sum2 = sum(sum(TC2));

Error = 0;

for i=1:200
    PC1 = 1;
    PC2 = 1;
    for j=1:7
        if(j~=2)
            val = tsData(i, j);
            idx = mod(val, MOD(j));
            tot = TC1(j, idx) + TC2(j, idx);
            PC1 = PC1 * (TC1(j, idx)/tot);
            PC2 = PC2 * (TC2(j, idx)/tot);
        else
            PC1 = PC1 * normpdf(tsData(i, j), M1, SD1);
            PC2 = PC2 * normpdf(tsData(i, j), M2, SD2);
        end
    end
    PC1 = PC1 * sum1/(sum1+sum2);
    PC2 = PC2 * sum2/(sum1+sum2);
    
    if(PC1 > PC2)
        cls = 1;
    else
        cls = 2;
    end
    if(cls~=tsData(i, 8))
        Error = Error + 1;
    end
end

fprintf('Error = %d', Error);

end