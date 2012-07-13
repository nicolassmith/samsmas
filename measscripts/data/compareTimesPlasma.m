
close all

% load data to compare
pde = load('underpde-20110823T185645.mat');
lab02 = load('plasma-20120711T020000.mat');
lab08 = load('plasma-20120711T080000.mat');
lab12 = load('plasma-20120711T120000.mat');
lab16 = load('plasma-20120710T164501.mat');
labtitle = 'plasma';

compareTimeGeneric