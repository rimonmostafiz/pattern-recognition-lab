% Life is not fair, so don't expect this code to be
function func()
    
    cls1 = zeros(4, 2);
    cls2 = zeros(4, 2);
    
    Ar = zeros(1, 4);
    
    sum1 = 0;
    sum2 = 0;
    
    trData = csvread('trainDataset01.csv');
    tsData = csvread('testDataset01.csv');
    
    for j=1:20
        Ar = zeros(1, 4);
        Ar(1, 1) = trData(j, 1);
        Ar(1, 2) = trData(j, 2);
        Ar(1, 3) = trData(j, 3);
        Ar(1, 4) = trData(j, 4);
        cls = trData(j, 5);
%         for i=1:4
%            fprintf(' %d', Ar(1, i));
%         end
%         fprintf('\n');
        if(cls==1)
            for i=1:4
                cls1(i, Ar(1, i)) = cls1(i, Ar(1, i)) + 1;
                sum1 = sum1 + 1;
            end
        elseif(cls==2)
            for i=1:4
                cls2(i, Ar(1, i)) = cls2(i, Ar(1, i)) + 1;
                sum2 = sum2 + 1;
            end
        end
    end
    
    fprintf('Printing Class 1 After Train\n');
    for i=1:4
        for j=1:2
            fprintf(' %d', cls1(i, j));
        end
        fprintf('\n');
    end
    fprintf('Sum1 := %d\n', sum1);
    fprintf('Printing Class 2 After Train\n');
    for i=1:4
        for j=1:2
            fprintf(' %d', cls2(i, j));
        end
        fprintf('\n');
    end
    
    fprintf('Sum2 := %d\n', sum2);
    Err = 0;
    for j=1:20
        Ar(1, 1) = tsData(j, 1);
        Ar(1, 2) = tsData(j, 2);
        Ar(1, 3) = tsData(j, 3);
        Ar(1, 4) = tsData(j, 4);
        cls = tsData(j, 5);
            
        res1 = 1;
        res2 = 1;
        
        for i=1:4
            tmp = cls1(i, Ar(1, i)) / sum1;
            res1 = res1 * tmp;
        end
            res1 = res1 * (sum1/(sum1+sum2)); %P(w1)
        for i=1:4
            tmp = cls2(i, Ar(1, i))/sum2;
            res2 = res2 * tmp;
        end
            res2 = res2 * (sum2/(sum1+sum2)); %P(w2)
        d = 0;
        fprintf('res1 := %d\n', res1);
        fprintf('res2 := %d\n', res2);
        if(res1>res2)
            d=1;
        else
            d=2;
        end
        if(d ~= cls)
            Err = Err + 1; 
        end
    end
    fprintf('Error = %d\n', Err);
end