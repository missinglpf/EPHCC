function folders = project_paths()
%project_paths   Define the set of folders to add to the MATLAB path
%  
%   Definition of the folders to add to the MATLAB path when this Project
%   is opened, and remove from the path when it is closed. Edit the
%   definition of folders below to add your own paths to the current
%   project.
%
%   The variable folders is a cell-array of paths relative to the project
%   root. For example,
%
%       folders = { ...
%           'data', ...
%           'models', ...
%           'src', ...
%           fullfile('components','core'), ...
%           'utilities' ...
%           };
%
%   Using the MATLAB command fullfile when constructing folder hierarchies
%   will make your project compatible with multiple operating systems
%   (for example, both Windows and Linux).

%   Copyright 2011-2012 The MathWorks, Inc.

folders = { ...
    'utilities', ...
    '../../Components/SimulinkOpal/ActiveLoad' ...
    '../../Components/SimulinkOpal/Cable' ...
    '../../Components/SimulinkOpal/ESS' ...
    '../../Components/SimulinkOpal/ESS/Software_1stOrder_model' ...
    '../../Components/SimulinkOpal/Motor' ...
    '../../Components/SimulinkOpal/PassiveLoad' ...
    '../../Components/SimulinkOpal/Transformer' ...
    '../../Components/SimulinkOpal/CHPandThermal' ...
    '../../Components/SimulinkOpal/CircuitBreaker' ...
    '../../Components/SimulinkOpal/Genset' ...
    '../../Components/SimulinkOpal/PV' ...
    '../../Components/SimulinkOpal/Relay' ...
    '../../Components/SimulinkOpal/UDP' ...
    '../../Components/SimulinkOpal/HWController_Diesel_Genset_4MVA' ...
	'../../Components/SimulinkOpal/HWController_NGCHP_Genset_3p5MVA' ...
	'../../Components/SimulinkOpal/WoodwardEasyGen3500_InterfaceBlocks' ...
	'../../Components/SimulinkOpal/SEL751_InterfaceBlocks' ...	
	'../../Components/SimulinkOpal/MeasurementBlocks' ...	
    '../../Components/SimulinkOpal/Fault' ...
	'../../Components/SimulinkOpal/DMSandTestSeq' ...
	'../../Components/SimulinkOpal/HWCtrl_IO_InterfaceBlocks' ...
    '../../Components/SimulinkOpal/EPC_BESS_PV' ...
	
	
	
	
	
	
	
    };
	
	
	
	
	
	
	
