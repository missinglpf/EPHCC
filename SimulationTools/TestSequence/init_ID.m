%% Copyright 2018 Alliance for Sustainable Energy, LLC
%
% Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
% and associated documentation files (the "Software"), to deal in the Software without restriction, 
% including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
% and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
% subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
% BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
% NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS, THE COPYRIGHT HOLDERS, THE UNITED STATES, 
% THE UNITED STATES DEPARTMENT OF ENERGY, OR ANY OF THEIR EMPLOYEES BE LIABLE FOR ANY CLAIM, 
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% Author: Przemyslaw Koralewicz / NREL
% Date: 2017

function [ id ] = init_prices()
%CALC_KPP1 Summary of this function goes here
%   Detailed explanation goes here

CB101 = 1;
CB102 = 2;
CB103 = 3;
CB104 = 4;
CB105 = 5;
CB106 = 6;
CB107 = 7;
CB108 = 8;
CB109 = 9;
CB110 = 10;
CB111 = 11;
CB112 = 12;
CB113 = 13;
CB114 = 14;
CB201 = 15;
CB202 = 16;
CB203 = 17;
CB204 = 18;
CB205 = 19;
CB206 = 20;
CB207 = 21;
CB208 = 22;
CB209 = 23;
CB210 = 24;
CB211 = 25;
CB212 = 26;
CB213 = 27;
CB214 = 28;
CB215 = 29;
CB216 = 30;
CB217 = 31;
CB218 = 32;
CB219 = 33;
CB301 = 34;
CB302 = 35;
CB303 = 36;
CB304 = 37;
CB305 = 38;
CB306 = 39;
CB307 = 40;
CB308 = 41;
CB309 = 42;
CB310 = 43;
CB401 = 44;
CB402 = 45;
CB403 = 46;
CB404 = 47;
CB405 = 48;
CB406 = 49;
CB100 = 50;
CB200 = 51;
CB300 = 52;
CB151 = 53;
CB251 = 54;
CB252 = 55;
CB351 = 56;
CB451 = 57;
CB452 = 58;
CB453 = 59;

CBGen1 = 53;
CBEss1 = 54;
CBPv1  = 55;
CBGen2 = 56;
CBGen3 = 57;
CBEss2 = 58;
CBPv2  = 59;



id=wsp2struct(who);