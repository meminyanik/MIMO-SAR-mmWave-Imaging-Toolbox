function [outputFilePath,fileNum] = createOutputFilePath(outputFileBase)
fileNum = 1;
outputFilePath = [outputFileBase 'data' num2str(fileNum) '\'];

while (exist(outputFilePath, 'dir') ~= 0 )
    fileNum = fileNum + 1;
    outputFilePath = [outputFileBase 'data' num2str(fileNum) '\'];
end