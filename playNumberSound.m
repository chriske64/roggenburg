function [ ] = playNumberSound( num )
% write 10 to num for 'droelf' output
load('numSound.mat')
sound(sound_num{num+1,1},sound_num{num+1,2})

end

