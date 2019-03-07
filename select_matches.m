function [f1_sel, f2_sel, selection] = select_matches(num_matches, matches);

selection = randperm(size(matches, 2), num_matches) ;
f1_sel = matches(1,selection); 
f2_sel = matches(2,selection);
end
