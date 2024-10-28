function Y = uq_Ex02_RubBreakwat_cost(X,P)
Z = P.Z ;
% Definition of Val: Volume of Main Armor Layer
Val = 0.5*X(:,1).*(((X(:,1)+X(:,2)+X(:,3))./sin(X(:,9)))+...
    ((X(:,2)+X(:,3))./sin(X(:,9))))+(X(:,4).*X(:,1)) + X(:,5).*X(:,6);

% Definition of Vul: Volume of Underlayer

Vfl = 0.5*X(:,2).*(((X(:,2)+X(:,3))./sin(X(:,9)))+...
    ((X(:,3))./sin(X(:,9)))) + X(:,2).*...
    (X(:,4)+(X(:,1)+X(:,2))/3)+X(:,2).*X(:,3)./sin(X(:,8));

% Definition of Vcl: Volume of Core Layer

Vcl = 0.5*X(:,3).*(2*X(:,7)+X(:,3).*cot(X(:,9))+X(:,3).*cot(X(:,8)))+...
    0.5*(4+X(:,6)+(X(:,2)./sin(X(:,8)))+((X(:,1)+X(:,2))./sin(X(:,9))));

std =[0.1462 0.1053 0.504 0.4998 0 0 0 0.0378 0.0350]';

idxDes = [1:9];
idxEnv = [10:16];
Pf = EvalPf(X,Z,std, idxDes, idxEnv);

% Penalty Function for Controling Overtopping Failure
failurep1 = Pf(:,1);
if failurep1 > 0.001
    Penalty1 = 1000000 * (failurep1 - 0.001); 
else
    Penalty1 = 0;
end

% Penalty Function for Controling Failure due to Armor Instability
failurep2 = Pf(:,2); 
if failurep2 > 0.001
    Penalty2 = 1000000 * (failurep2 - 0.001);
else
    Penalty2 = 0;
end

% Penalty Function for Controling Toe Erosion Failure
failurep3 = Pf(:,3); 
if failurep3 > 0.001
    Penalty3 = 100000 * (failurep3 - 0.001);
else
    Penalty3 = 0;
end

% Calculation of Construction Cost
Y = 301*Val + 67*Vfl + 110*Vcl + ...
+ Penalty1 + Penalty2 + Penalty3;

end