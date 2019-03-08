function [selection] = select_matches(num_matches, matches)
% Selects random matches.
% Inputs: 
    % num_matches: Number of random matches being selected.
    % matches: Matches being selected from.
% Outputs: 
    % selection: Random subset of matches.   
selection = randperm(size(matches, 2), num_matches);
end
