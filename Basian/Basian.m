function Basian()
trData = csvread('trainDataset01.csv');
tsData = csvread('testDataset01.csv');
cls = zeros(2);
%Training
for i=1:20
    for j=1:1
%         fprintf('i = %d, j = %d\n', trData(i, j), trData(1, j));
        cls(trData(i, 5), trData(i, j)) = cls(trData(i, 5), trData(i, j)) + 1;
    end
end
disp(cls); %Display After Training
err = 0;
N=0;
%Calculating N
for i=1:2
    for j=1:2
        N = N + cls(i, j);
    end
end
%Testing
for i=1:20
    for j=1:1
%         fprintf('row = %d --->\n', i);
        nx = cls(1, tsData(i, j)) + cls(2, tsData(i, j));
        nxw1 = cls(1, tsData(i, j));
        nxw2 = cls(2, tsData(i, j));
        POA = nxw1 / nx;
        POB = nxw2 / nx;
        res = 0;
%         fprintf('POA = %d, POB = %d\n', POA, POB);
        if(POA>POB)
            res = 1;
        else
            res = 2;
        end
        if(res ~= tsData(i, 5))
%             fprintf('Expected = %d, Result = %d\n', tsData(i, 5), res);
            err = err + 1;
        else
%             fprintf('Matched %d = %d\n', tsData(i, 5), res);
            
        end
%         fprintf('\n');
    end
end
fprintf('Error = %d\n', err);
end
