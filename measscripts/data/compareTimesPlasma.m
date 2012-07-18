
close all

% load data to compare
pde = load('underpde-20110823T185645.mat');
lab02 = load('plasma-20120717T020000.mat');
lab08 = load('plasma-20120717T080000.mat');
lab12 = load('plasma-20120717T120000.mat');
lab16 = load('plasma-20120717T164500.mat');
labtitle = 'plasma';

compareTimeGeneric