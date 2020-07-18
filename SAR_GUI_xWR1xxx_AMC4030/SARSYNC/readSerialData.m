function readSerialData(src,~)
    % data = read(src,src.NumBytesAvailable,"char");
    data = readline(src);
    disp(data)
    % disp(evt)
end