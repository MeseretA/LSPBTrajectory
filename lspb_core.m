function [s, sd, sdd] = lspb_core(q0, q1, te, f, V)
    % Linear Segments with Parabolic Blends (LSPB)
    dt = 1/f;
    t_one_cycle = 0:dt:(te-dt);
    num_pt = size(t_one_cycle,2);
    if nargin<5
        [s_f, sd_f, sdd_f] = lspb(q0, q1, num_pt/2);
        [s_b, sd_b, sdd_b] = lspb(q1, q0, num_pt/2);
    else
        [s_f, sd_f, sdd_f] = lspb(q0, q1, num_pt/2, V);
        [s_z1, sd_z1, sdd_z1] = lspb(q1, q1, num_pt/2, V);
        [s_b, sd_b, sdd_b] = lspb(q1, q0, num_pt/2, V);
        [s_z2, sd_z2, sdd_z2] = lspb(q0, q0, num_pt/2, V);
    end
    s = [s_f;s_z1;s_b;s_z2];
    sd = [sd_f;sd_z1;sd_b;sd_z2];
    sdd = [sdd_f;sdd_z1;sdd_b;sdd_z2];
	plotsargs = {'linewidth', 2.5};
    switch nargout
        case 0
            clf
            subplot(311)
            hold on
            plot(t_one_cycle, s, 'r.-', plotsargs{:});
            grid; ylabel('$s$', 'FontSize', 16, 'Interpreter','latex');

            hold off

            subplot(312)
            plot(t_one_cycle, sd, '.-', plotsargs{:});
            grid;
            ylabel('$ds/dk$', 'FontSize', 16, 'Interpreter','latex');
            
            subplot(313)
            plot(t_one_cycle, sdd, '.-', plotsargs{:});
            grid;
            ylabel('$ds^2/dt^2$', 'FontSize', 16, 'Interpreter','latex');
            xlabel('t (seconds)');
            shg
        case 1
            s = s;
        case 2
            s = s;
            sd = sd;
        case 3
            s = s;
            sd = sd;
            sdd = sdd;            
    end
    
%     csvwrite('trajectory_fric_generated/traj_s.csv',s);
%     csvwrite('trajectory_fric_generated/traj_sdot.csv',sd);
%     csvwrite('trajectory_fric_generated/traj_sddot.csv',sdd);
    