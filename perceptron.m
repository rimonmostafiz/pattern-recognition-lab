function perceptron()
    TrainMatrix = csvread('germanTrain.csv');
    TestMatrix = csvread('germanTest.csv');
    
    weight = [rand(1, 7), 0];
    STEP = 0.05;
    
    %Train
    for iteration=1:1000
        errorSum = zeros(1, 8);
        error = 0;
        for i=1:size(TrainMatrix, 1)
            gW = weight * [TrainMatrix(i, 1:7), 1]';
            if(gW > 0 && TrainMatrix(i, 8) ~=1)
                errorSum = errorSum + [TrainMatrix(i, 1:7), 1];
                error = error + 1;
            elseif(gW < 0 && TrainMatrix(i, 8) ~=2)
                errorSum = errorSum - [TrainMatrix(i, 1:7), 1];
                error = error + 1;
            end
        end
        if(error==0)
            break;
        end
        weight = weight - STEP*errorSum;
    end
    
    err = 0;
    %Train
        for i=1:size(TestMatrix, 1)
            gW = weight * [TestMatrix(i, 1:7), 1]';
            if(gW > 0 && TrainMatrix(i, 8) ~=1)
                %disp(i);
                err = err + 1;
            elseif(gW < 0 && TrainMatrix(i, 8) ~=2)
                %disp(i);
                err = err + 1;
            end
        end
        fprintf('Error = %d', err);
    
end
