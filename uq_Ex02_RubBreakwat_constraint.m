function Y = uq_Ex02_RubBreakwat_constraint(X)

Y(:, 1) = X(:, 10).*X(:, 11).*(X(:, 12).*cot(X(:,9))).^(1/3) - X(:, 13);

gamma = 0.5;
Rc = X(:, 1) + X(:, 2) + X(:, 3) - X(:, 16) - 5;
Tm = X(:, 14)./1.25;
Lm = 9.81.*(Tm.^2)/2/pi();
Hs = X(:, 13);
Y(:, 2) = 0.0001 - 0.026.*sqrt(Lm./Hs./cot(X(:, 9))).*...
    exp(-(((2.5.*Rc.*cot(X(:, 9)).*sqrt(Hs./Lm))./Hs./gamma).^1.3))...
    .* sqrt(9.806.*(Hs.^3));

hd = 5 + X(:, 16) - 0.5 - X(:, 5);
Y(:, 3) = (0.24*hd + 1.6*0.37*X(:, 11)) .* (X(:, 15) .^0.15) .* ...
    X(:, 10) - X(:, 13);
% Y(:, 3) = X(:, 11) + (X(:, 13) ./ (2 + 6.2 .* (hd .^ 2.7)) ./...
%     (X(:, 15) .^0.15)./X(:, 10));

end