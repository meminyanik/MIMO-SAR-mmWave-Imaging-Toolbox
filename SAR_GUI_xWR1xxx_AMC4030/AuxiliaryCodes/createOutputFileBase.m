function outputFileBase = createOutputFileBase(outputFileBase,experimentFolder)
% COnvert to char array
if (isstring(outputFileBase))
    outputFileBase = char(outputFileBase);
end
if (isstring(experimentFolder))
    experimentFolder = char(experimentFolder);
end

% Check folder names end with '\'
if (outputFileBase(end) ~= '\')
    outputFileBase = [outputFileBase  '\'];
end
if (experimentFolder(end) ~= '\')
    experimentFolder = [experimentFolder '\'];
end

outputFileBase = [outputFileBase experimentFolder];