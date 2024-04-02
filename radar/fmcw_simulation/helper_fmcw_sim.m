function helper_fmcw_sim
%   This function helperslexFMCWParam is only in support of
%   slexFMCWExample. It may be removed in a future release.

%   Copyright 2014-2020 The MathWorks, Inc.

% Constant
c = 3e8;
concrete_dielectric_const = 25;
maxEstimatesFMCW = 1;
numParallelChains = 5; 

% Environment
paramEnvironment.propSpeed = c / sqrt(concrete_dielectric_const);

% Radar Waveform
paramRadarWaveformFMCW.StartF = 1;
paramRadarWaveformFMCW.EndF = 2;
paramRadarWaveformFMCW.NumSweeps = 1;
paramRadarWaveformFMCW.Bw = paramRadarWaveformFMCW.EndF - paramRadarWaveformFMCW.StartF;
paramRadarWaveformFMCW.Fs = 100;
paramRadarWaveformFMCW.T = 0.5;
paramRadarWaveformFMCW.Slope = paramRadarWaveformFMCW.Bw/paramRadarWaveformFMCW.T;

% Radar Hardware
paramRadarHardwareFMCW.Fc = (paramRadarWaveformFMCW.EndF - paramRadarWaveformFMCW.StartF)/2 + ...
                            paramRadarWaveformFMCW.StartF;
paramRadarHardwareFMCW.lambda = c/paramRadarHardwareFMCW.Fc;
paramRadarHardwareFMCW.Ppow = 0.00000000000000001;
paramRadarHardwareFMCW.TxGain = 20;
paramRadarHardwareFMCW.NF = 4.5;
paramRadarHardwareFMCW.RxGain = 36;
paramRadarHardwareFMCW.RCS = 0.5;

% Geometry
paramGeometryFMCW.RadarVel = [0; 0; 0]; % make radar stationary
paramGeometryFMCW.RadarPos = [0; 0; 0];
paramGeometryFMCW.CarVel = [0.02; 0; 0]; % assuming m/s?
paramGeometryFMCW.CarPos = [1; 0; 0]; % assuming m?

% CFAR
numRng = (paramRadarWaveformFMCW.T*paramRadarWaveformFMCW.Fs)/numParallelChains;
paramDetectionFMCW.NumRng = numRng; 
rngOver = max(round(numRng/(paramRadarWaveformFMCW.T*paramRadarWaveformFMCW.Fs)),1);
numGuardRng = 2*rngOver;
numTrainRng = 4*rngOver;
numCUTRng = 1+numGuardRng+numTrainRng;
paramDetectionFMCW.CUTSize = 1+numGuardRng+numTrainRng;
paramDetectionFMCW.GuardSize = numGuardRng;
paramDetectionFMCW.TrainSize = numTrainRng;
CUTIdxFMCW = numCUTRng:(numRng-numCUTRng+1);

% Output to base workspace
assignin('base','c',c)
assignin('base','maxEstimatesFMCW',maxEstimatesFMCW)
assignin('base','paramRadarWaveformFMCW',paramRadarWaveformFMCW)
assignin('base','paramRadarHardwareFMCW',paramRadarHardwareFMCW)
assignin('base','paramGeometryFMCW',paramGeometryFMCW)
assignin('base','paramDetectionFMCW',paramDetectionFMCW)
assignin('base','CUTIdxFMCW',CUTIdxFMCW)
assignin('base', "paramEnvironment", paramEnvironment);

end