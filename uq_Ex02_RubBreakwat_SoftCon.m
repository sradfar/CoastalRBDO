function Y = uq_Ex02_RubBreakwat_SoftCon(X)
Y(:,1) = 2 * 1.82 - X(:,1);
Y(:,2) = X(:,1) - 2 * 1.53;
Y(:,3) = 2 * 0.68 - X(:,2);
Y(:,4) = X(:,2) - 2 * 0.49;
Y(:,5) = 2.5 - X(:,5);
Y(:,6) = X(:,5) - 4.2;
Y(:,7) = 5 - X(:,6);
Y(:,8) = X(:,6) - 8.4;
Y(:,9) = 5 - X(:,6);
Y(:,10) = X(:,6) - 8.4;
Y(:,11) = 7 - X(:,7);
Y(:,12) = X(:,7) - 10;
Y(:,13) = 1.25 - cot(X(:,8));
Y(:,14) = cot(X(:,8)) - 1.75;
Y(:,15) = 2 - cot(X(:,9));
Y(:,16) = cot(X(:,9)) - 3;
Y(:,17) = 5 - X(:,1) + X(:,2) + X(:,3);
Y(:,18) = 5 - X(:,3);
Y(:,19) = 3 * 1.82 - X(:,4);
Y(:,20) = X(:,4) - 3 * 1.53;
Y(:,21) = 2 * X(:,5) - X(:,6);
Y(:,22) = X(:,6) - 2 * X(:,5);
end