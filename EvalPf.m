function Pf = EvalPf(d,Z,std, idxDes, idxEnv)

DesignOpts.Marginals(1).Name = 'a';  % Armor-layer height - X1
DesignOpts.Marginals(1).Type = 'Gaussian';

DesignOpts.Marginals(2).Name = 'b';  % Underlayer height - X2
DesignOpts.Marginals(2).Type = 'Gaussian';

DesignOpts.Marginals(3).Name = 'c';  % Core height - X3
DesignOpts.Marginals(3).Type = 'Gaussian';

DesignOpts.Marginals(4).Name = 'Cw';  % Crest width -X4
DesignOpts.Marginals(4).Type = 'Gaussian';

DesignOpts.Marginals(5).Name = 't'; % Toe thickness - X5
DesignOpts.Marginals(5).Type = 'constant';

DesignOpts.Marginals(6).Name = 'r'; % Toe berm width -X6
DesignOpts.Marginals(6).Type = 'constant';

DesignOpts.Marginals(7).Name = 'Bc'; % Core width - X7
DesignOpts.Marginals(7).Type = 'constant';

DesignOpts.Marginals(8).Name = 'al';  % Leeward slope - X8
DesignOpts.Marginals(8).Type = 'Gaussian';

DesignOpts.Marginals(9).Name = 'as';  % Seaward slope - X9
DesignOpts.Marginals(9).Type = 'Gaussian';
        
% Loop over all the design samples
for ii = 1:size(d,1)
    
    % Loop over each dimension of the design variable:
    for jj = 1 : size(d(ii,:),2)
        % I assume a fixed standard definition is given for each design
        % variables
        DesignOpts.Marginals(jj).Moments = [d(ii,jj), std(jj)] ;
    end
  
    
    % Build an Input object
    myInput = uq_createInput(DesignOpts,'-private') ;
    % Sample the random  variables locally
    D = uq_getSample(myInput,1e4) ;
    % Now recombine D and Z according to how they enter in your final
    % objective function
    X = zeros(1e4,length(idxDes)+length(idxEnv)) ;
    X(:,idxDes) = D ;
    X(:,idxEnv) = Z ;
    
    % Evaluate the limit-state function
    Y = uq_Ex02_RubBreakwat_constraint(X) ;
    % Get the corresponding failure probability
    Pf(ii,:) = sum(Y<0)/1e4 ;
end
end




