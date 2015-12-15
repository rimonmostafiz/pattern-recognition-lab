function Basian()

trData = csvread('trainDataset01.csv');
tsData = csvread('testDataset01.csv');

cls1 = zeros(4, 4, 4, 4);
cls2 = zeros(4, 4, 4, 4);

%Training
for i=1:20
     a = trData(i, 1);
     b = trData(i, 2);
     c = trData(i, 3);
     d = trData(i, 4);
     cls = trData(i, 5);
    if(cls==1)
        cls1(a, b, c, d) = cls1(a, b, c, d) + 1;
    else
        cls2(a, b, c, d) = cls2(a, b, c, d) + 1;
    end
end
% fprintf('Display CLASS 1');
% disp(cls1);
% fprintf('Display CLASS 2');
% disp(cls2);
err = 0;
for i=1:20
%         fprintf('\n\nWorking with := %d\n', i);
        a = tsData(i, 1);
        b = tsData(i, 2);
        c = tsData(i, 3);
        d = tsData(i, 4);
        nx = cls1(a, b, c, d) + cls2(a, b, c, d);
%          fprintf('nx := %d\n', nx);
        nxw1 = cls1(a, b, c, d);
        nxw2 = cls2(a, b, c, d);
%          fprintf('nxw1 := %d\n', nxw1);
%          fprintf('nxw2 := %d\n', nxw2);
        POA = nxw1 / nx;
        POB = nxw2 / nx;
%         fprintf('POA := %f\n', POA);
%         fprintf('POB := %f\n', POB);
        res = 0;
        if(POA>POB)
            res = 1;
        else
            res = 2;
        end
        if(res ~= tsData(i, 5))
            err = err + 1;
%             fprintf('ERR := %d\n', err);
        end
end
fprintf('Error %d\n', err);
end
