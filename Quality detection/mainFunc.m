clc;
clear all;
close all;

disp('Enter 1 for Apple');
disp('Enter 2 for Banana');
answer = input('Enter the type of fruit ');

if(isequal(answer, 1))
    appleFunc();
else 
    if(isequal(answer, 2))
        bananaFunc();
else
    disp('Invalid Entry');
    end
end



