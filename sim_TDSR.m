function results = sim_TDSR(sim)
    
    % Simulate experimental paradigms.
    %
    % USAGE: results = sim_TDSR(sim)
    %
    % INPUTS:
    %   sim - string specifying simulation:
    %           'sharpe17_opto' - activation experiment from Sharpe et al (2017)
    %           'sharpe17_deval' - devaluation experiment from Sharpe et al (2017)
    %           'sharpe17_inhib' - inhibition experiment from Sharpe et al (2017)
    %           'takahashi17_identity' - identity change experiment from Takahashi et al (2017)
    %           'chang17_identity' - identity unblocking experiment from Chang et al (2017)
    %
    % OUTPUTS:
    %   results - see linearTDSR.m
    %
    % Sam Gershman, Dec 2017
    
    switch sim
        
        case 'sharpe17_opto'
            
            % A = 1
            % C = 2
            % D = 3
            % E = 4
            % F = 5
            % X = 6
            % food = 7
            
            n = 5;
            A_X = repmat([1 0 0 0 0 0 0; 1 0 0 0 0 1 0; 0 0 0 0 0 0 0],n,1);
            EF_X = repmat([0 0 0 1 1 0 0; 0 0 0 1 1 1 0; 0 0 0 0 0 0 0],n,1);
            AD_X = repmat([1 0 1 0 0 0 0; 1 0 1 0 0 1 0; 0 0 0 0 0 0 0],n,1);
            AC_X = repmat([1 1 0 0 0 0 0; 1 1 0 0 0 1 0; 0 0 0 0 0 0 0],n,1);
            X = repmat([0 0 0 0 0 1 0; 0 0 0 0 0 1 1; 0 0 0 0 0 0 0],n,1);
            rX = repmat([0; 1; 0],n,1);
            F = [0 0 0 0 1 0 0; 0 0 0 0 0 0 0];
            D = [0 0 1 0 0 0 0; 0 0 0 0 0 0 0];
            C = [0 1 0 0 0 0 0; 0 0 0 0 0 0 0];
            r = [zeros(n*3*5,1); rX; zeros(6,1)];
            x = [A_X; EF_X; AD_X; AC_X; A_X; X; F; D; C];
            opto = [zeros(n*3*2,1); repmat([0; 0; 0.4],n,1); repmat([0; 0.4; 0],n,1); zeros(n*3*2 + 6,1)];
            results{1} = linearTDSR(x,r,opto);  % chr2
            results{2} = linearTDSR(x,r);       % eypf
            
            V(1,:) = [results{1}.V];
            V(2,:) = [results{2}.V];
            figure;
            subplot(1,2,2);
            bar(V(:,end-5:2:end));
            set(gca,'FontSize',25,'XTickLabel',{'ChR2' 'eYFP'});
            ylabel('Value','FontSize',25);
            title('Model','FontSize',25,'FontWeight','Bold')
            
            subplot(1,2,1);
            V = [2.05 1.66 2.66; 2.15 1.47 1.52];
            bar(V);
            legend({'F' 'D' 'C'},'FontSize',25);
            set(gca,'FontSize',25,'XTickLabel',{'ChR2' 'eYFP'});
            ylabel('Food cup entries','FontSize',25);
            title('Data','FontSize',25,'FontWeight','Bold')
            set(gcf,'Position',[200 200 1000 400])
            
        case 'sharpe17_deval'
            
            % A = 1
            % C = 2
            % D = 3
            % E = 4
            % F = 5
            % X = 6
            % food = 7
            
            n = 5;
            A_X = repmat([1 0 0 0 0 0 0; 1 0 0 0 0 1 0; 0 0 0 0 0 0 0],n,1);
            EF_X = repmat([0 0 0 1 1 0 0; 0 0 0 1 1 1 0; 0 0 0 0 0 0 0],n,1);
            AD_X = repmat([1 0 1 0 0 0 0; 1 0 1 0 0 1 0; 0 0 0 0 0 0 0],n,1);
            AC_X = repmat([1 1 0 0 0 0 0; 1 1 0 0 0 1 0; 0 0 0 0 0 0 0],n,1);
            X = repmat([0 0 0 0 0 1 0; 0 0 0 0 0 1 1; 0 0 0 0 0 0 0],n,1);
            rX = repmat([0; 1; 0],n,1);
            C = [0 1 0 0 0 0 0];
            food = [0 0 0 0 0 0 1; 0 0 0 0 0 0 0];
            r1 = [zeros(n*3*5,1); rX; 0; -5; 0];
            x1 = [A_X; EF_X; AD_X; AC_X; A_X; X; food; C];
            r2 = [zeros(n*3*5,1); rX; -5; 0; 0];
            x2 = [A_X; EF_X; AD_X; AC_X; A_X; X; food; C];
            opto = [zeros(n*3*2,1); repmat([0; 0; 0.4],n,1); repmat([0; 0.4; 0],n,1); zeros(n*3*2 + 4,1)];
            results{1} = linearTDSR(x1,r1,opto);  % chr2 / nodeval
            results{2} = linearTDSR(x2,r2,opto);  % chr2 / deval
            
            V(1) = results{1}(end).V;
            V(2) = results{2}(end).V;
            figure;
            subplot(1,2,2)
            bar(V);
            set(gca,'FontSize',25,'XTickLabel',{'Nondevalued' 'Devalued'},'XLim',[0.5 2.5]);
            ylabel('Value','FontSize',25);
            title('Model','FontSize',25,'FontWeight','Bold');
            
            subplot(1,2,1)
            V = [3.22 1.23];
            bar(V);
            set(gca,'FontSize',25,'XTickLabel',{'Nondevalued' 'Devalued'},'XLim',[0.5 2.5]);
            ylabel('Food cup entries','FontSize',25);
            title('Data','FontSize',25,'FontWeight','Bold');
            set(gcf,'Position',[200 200 900 350])
            
        case 'sharpe17_inhib'
            
            % A = 1
            % B = 2
            % X = 3
            % Y = 4
            % flavor1 = 5
            % flavor2 = 6
            
            n = 5;
            A_X = repmat([1 0 0 0 0 0; 1 0 1 0 0 0; 0 0 0 0 0 0],n,1);
            B_Y = repmat([0 1 0 0 0 0; 0 1 0 1 0 0; 0 0 0 0 0 0],n,1);
            X = repmat([0 0 1 0 0 0; 0 0 1 0 1 0; 0 0 0 0 0 0],n,1);
            Y = repmat([0 0 0 1 0 0; 0 0 0 1 0 1; 0 0 0 0 0 0],n,1);
            rX = repmat([0; 1; 0],n,1);
            A = [1 0 0 0 0 0; 0 0 0 0 0 0];
            B = [0 1 0 0 0 0; 0 0 0 0 0 0];
            r = [zeros(n*3*2,1); rX; rX; zeros(4,1)];
            x = [A_X; B_Y; X; Y; A; B];
            opto = [zeros(n*3,1); repmat([0; -0.1; 0],n,1); zeros(n*3*2 + 4,1)];
            results{1} = linearTDSR(x,r,opto);  % nphr
            results{2} = linearTDSR(x,r);       % eypf
            
            V(1,:) = [results{1}.V];
            V(2,:) = [results{2}.V];
            figure;
            subplot(1,2,2);
            bar(V(:,end-3:2:end));
            set(gca,'FontSize',25,'XTickLabel',{'NpHR' 'eYFP'});
            ylabel('Value','FontSize',25);
            title('Model','FontSize',25,'FontWeight','Bold');
            
            subplot(1,2,1);
            V = [51.4 29.3; 38.5 36.9];
            bar(V);
            legend({'A' 'B'},'FontSize',25);
            set(gca,'FontSize',25,'XTickLabel',{'NpHR' 'eYFP'});
            ylabel('Value','FontSize',25);
            title('Data','FontSize',25,'FontWeight','Bold');
            set(gcf,'Position',[200 200 1000 400])
            
        case 'takahashi17_identity'
            
            % A (reward 1) = 1
            % B (reward 2) = 2
            
            n = 15;
            x = [repmat([1 0; 0 0],n,1); repmat([0 1; 0 0],n,1)];
            r = ones(2*2*n,1);
            x = [x r];
            results = linearTDSR(x,r);
            for i=1:length(results); dt(i,:) = results(i).dt; end
            dt = mean(dt(1:2:end,:),2);
            k = 5;
            D(1,:) = [mean(dt(n-k+1:n)) mean(dt(n+1:n+k))];
            clear dt
            
            figure;
            subplot(1,2,2)
            bar(D);
            set(gca,'FontSize',25,'XTickLabel',{'Late' 'Early'},'XLim',[0.5 2.5],'YLim',[0 0.4]);
            ylabel('Prediction error','FontSize',25);
            title('Model','FontSize',25,'FontWeight','Bold');
            
            subplot(1,2,1)
            D = [2.34 6.82];
            bar(D);
            set(gca,'FontSize',25,'XTickLabel',{'Late' 'Early'},'XLim',[0.5 2.5]);
            ylabel('Spikes/sec','FontSize',25);
            title('Data','FontSize',25,'FontWeight','Bold');
            set(gcf,'Position',[200 200 900 350])

        case 'chang17_identity'
            
            % A = 1
            % B = 2
            % X = 3
            % Y = 4
            % flavor1 = 5
            % flavor2 = 6
            
            n = 5;
            A = repmat([1 0 0 0 0 0; 1 0 0 0 1 0; 0 0 0 0 0 0],n,1);
            B = repmat([0 1 0 0 0 0; 0 1 0 0 0 1; 0 0 0 0 0 0],n,1);
            AX = repmat([1 0 1 0 0 0; 1 0 1 0 1 0; 0 0 0 0 0 0],n,1);
            BY = repmat([0 1 0 1 0 0; 0 1 0 1 1 0; 0 0 0 0 0 0],n,1);
            X = [0 0 1 0 0 0; 0 0 0 0 0 0];
            Y = [0 0 0 1 0 0; 0 0 0 0 0 0];
            r = [repmat([0; 1; 0],n*4,1); zeros(4,1)];
            x = [A; B; AX; BY; X; Y];
            opto1 = [zeros(n*3*3,1); repmat([0; -0.1; 0],n,1); zeros(4,1)];
            opto2 = [zeros(n*3*3,1); repmat([0; 0; -0.1],n,1); zeros(4,1)];
            results{1} = linearTDSR(x,r,opto1);
            results{2} = linearTDSR(x,r,opto2);
            
            V(1,:) = [results{1}.V];
            V(2,:) = [results{2}.V];
            figure;
            subplot(1,2,2);
            bar(V(:,end-3:2:end));
            set(gca,'FontSize',25,'XTickLabel',{'Exp' 'ITI'});
            ylabel('Value','FontSize',25);
            title('Model','FontSize',25,'FontWeight','Bold');
            
            subplot(1,2,1);
            V = [27.6 17.1; 26.7 47.4];
            bar(V);
            legend({'A_B' 'A_{UB}'},'FontSize',25,'Location','North');
            set(gca,'FontSize',25,'XTickLabel',{'Exp' 'ITI'});
            ylabel('Value','FontSize',25);
            title('Data','FontSize',25,'FontWeight','Bold');
            set(gcf,'Position',[200 200 900 350])
            
    end