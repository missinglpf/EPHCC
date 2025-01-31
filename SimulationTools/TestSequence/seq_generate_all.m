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

function [ sequence ] = seq_generate_all( opt )
%GENERATE_ALL Summary of this function goes here
%   Detailed explanation goes here

t = 0:opt.Ts:opt.End;

irradiance = seq_gen_irradiance(opt);
if (isfield(opt,'Cloud'))
irradiance = [  seq_gen_clouds(opt, irradiance, 0); ... 
                seq_gen_clouds(opt, irradiance, opt.CloudDelay)];
else
    irradiance = [irradiance; irradiance];
end
price = seq_gen_price(opt);

cut_grid = seq_gen_stairs(opt, 'Grid.CutGrid');
grid_open_ssf1 = seq_gen_stairs(opt, 'Grid.OpenSSF1');
grid_open_ssf2 = seq_gen_stairs(opt, 'Grid.OpenSSF2');
grid_open_ssf3 = seq_gen_stairs(opt, 'Grid.OpenSSF3');

grid_freq = 60.000 * ones(1,opt.N);
grid_freq = seq_gen_freq(opt, grid_freq);
grid_volt = 115000 * ones(1,opt.N);
grid_volt = seq_gen_volt(opt, grid_volt);

dms_disreq = seq_gen_stairs(opt, 'DMS.DisReq');
dms_kWena  = seq_gen_stairs(opt, 'DMS.kWena');
dms_PFena  = seq_gen_stairs(opt, 'DMS.PFena');
dms_kWref  = seq_gen_stairs(opt, 'DMS.kWref');
dms_PFref  = seq_gen_stairs(opt, 'DMS.PFref');
dms_Dp     = seq_gen_stairs(opt, 'DMS.Dp');
dms_Dq     = seq_gen_stairs(opt, 'DMS.Dq');
iDp = dms_Dp>0;
dms_kWHzref = dms_kWref;
dms_kWHzref(iDp) = dms_kWref(iDp) + (grid_freq(iDp) - 60)/60./(dms_Dp(iDp)/100)*10e3;
kWref_assume = dms_kWref;               % kW load from grid for angle calculations - assume kWref when in dmskWena=1
kWref_assume(dms_kWref == 0) = 8000;    % assume 8MW load when not in dms_kWena
dms_kVArref = sqrt(1-dms_PFref.*dms_PFref)./dms_PFref.*kWref_assume;        % Reactive power with PF control term
dms_kVArVoltref = dms_kVArref + (grid_volt-115000)/115000./(dms_Dq/100)*10e3;     % Reactive power with kVAR/Volt support
dms_ang_kVArVoltref = atan(dms_kVArVoltref./kWref_assume);

iFreqEvent = grid_freq ~= 60.00;
iVoltEvent = grid_volt ~= 115000;

nanv = nan*ones(1,opt.N);
kWref = nanv;
dms_kWref_nan = nanv;
dms_kWref_nan(dms_kWena==1) = dms_kWref(dms_kWena==1);
dms_kWHzref_nan = nanv;
dms_kWHzref_nan(iFreqEvent) = dms_kWHzref(iFreqEvent);
dms_PFref_nan = nanv;
dms_PFref_nan(dms_PFena==1) = dms_PFref(dms_PFena==1);
dms_kVArref_nan = nanv;
dms_kVArref_nan(dms_PFena==1) = dms_kVArref(dms_PFena==1);
dms_kVArVoltref_nan = nanv;
dms_kVArVoltref_nan(iVoltEvent) = dms_kVArVoltref(iVoltEvent);
dms_ang_kVArVoltref_nan = nanv;
dms_ang_kVArVoltref_nan(iVoltEvent) = dms_ang_kVArVoltref(iVoltEvent);
dms_phiref_nan = acos(dms_PFref_nan)/pi*180;

motor1     = seq_gen_stairs(opt, 'Motor1');
motor2     = seq_gen_stairs(opt, 'Motor2');

mgc_enable = seq_gen_stairs(opt, 'MGC_Enable');
fault.loc1 = seq_gen_stairs(opt, 'Fault.Loc1');
fault.loc2 = seq_gen_stairs(opt, 'Fault.Loc2');
fault.loc3 = seq_gen_stairs(opt, 'Fault.Loc3');
fault.loc4 = seq_gen_stairs(opt, 'Fault.Loc4');
fault.loc5 = seq_gen_stairs(opt, 'Fault.Loc5');
fault.loc6 = seq_gen_stairs(opt, 'Fault.Loc6');
fault.gen1 = seq_gen_stairs(opt, 'Fault.Gen1');
fault.gen2 = seq_gen_stairs(opt, 'Fault.Gen2');
fault.gen3 = seq_gen_stairs(opt, 'Fault.Gen3');
fault.ess1 = seq_gen_stairs(opt, 'Fault.Ess1');
fault.ess2 = seq_gen_stairs(opt, 'Fault.Ess2');
fault.pv1  = seq_gen_stairs(opt, 'Fault.Pv1');
fault.pv2  = seq_gen_stairs(opt, 'Fault.Pv2');

udpframe = int16(zeros(15,opt.N));
udpframe(1:2,:)   = reshape(typecast(uint32(t*1000), 'int16'),2,opt.N);
udpframe(3,:)     = fault.loc1 *   1 + ...
                    fault.loc2 *   2 + ...
                    fault.loc3 *   4 + ...
                    fault.loc4 *   8 + ...
                    fault.loc5 *  16 + ...
                    fault.loc6 *  32 + ...
                    fault.gen1 *  64 + ...
                    fault.gen2 * 128 + ...
                    fault.gen3 * 256 + ...
                    fault.ess1 * 512 + ...
                    fault.ess2 *1042 + ...
                    fault.pv1  *2048 + ...
                    fault.pv2  *4096;
udpframe(4,:)     = motor1 + 2*motor2;
udpframe(5,:)     = dms_disreq*1 + dms_kWena*2 + dms_PFena*4;
udpframe(6,:)     = dms_kWref;
udpframe(7,:)     = dms_PFref*1000;
udpframe(8,:)     = dms_Dp*100;
udpframe(9,:)     = dms_Dq*100;
udpframe(10,:)    = cut_grid         *   1 + ...
                    mgc_enable       *   2 + ...
                    grid_open_ssf1   *   4 + ...
                    grid_open_ssf2   *   8 + ...
                    grid_open_ssf3   *  16;
udpframe(11,:)    = grid_freq*100;
udpframe(12,:)    = grid_volt*0.1;
udpframe(13,:)    = 1000*price;
udpframe(14:15,:) = 1000*irradiance;

sequence=wsp2struct(who);
end

