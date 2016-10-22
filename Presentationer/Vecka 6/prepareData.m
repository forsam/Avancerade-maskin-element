clear all
close all
clc

addpath('data/');
addpath('functions/');

% Time the read all the data!!
% its 26 files so i will hardcode it!
fileNumber = 26;

% initialize the data array
data.init = 1;

% Read in the data with help from the datareader function!
data = readTheData(fileNumber, data);

% The fuelweight is measured in each measurment!
% now we need a function that fixes our data!
data = cleanTheData(data);

% make a function with help from the data!
% a surface that depends on Rpm and Torque!
data.fuelCon.function = fit([data.Rpm.value', data.Torque.value'],-data.fuelCon.value100','poly22');
data.BSFC.function =@(rpm,torque) 3600.*1000.*data.fuelCon.function(rpm,torque)./(torque.*rpm.*(pi/30));

