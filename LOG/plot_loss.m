filename = 'pascal_dense33net-class25.log';
fid=fopen(filename,'r');
regpat = 'Iteration [0-9]+, loss = [0-9\.]+';
regpat2 = 'Train net output #0: rpn_cls_loss = [0-9\.]+';
regpat3 = 'Train net output #1: rpn_loss_bbox = [0-9\.]+';
iter = zeros(100000,1);
bbox_loss = zeros(100000,1);
cls_loss = zeros(100000,1);
p = 1;
while ~feof(fid)
    newline=fgetl(fid);
    o3=regexpi(newline,regpat,'match');
    if ~isempty(o3)
        iterloss = sscanf(o3{1},'Iteration %d, loss = %f');
        iter(p) = iterloss(1);
%         loss(p) = iterloss(2);
        newline=fgetl(fid);
        o4 = regexpi(newline,regpat2, 'match');
        newline=fgetl(fid);
        o5 = regexpi(newline,regpat3, 'match');
        if ~isempty(o4)
            rpn_cls_loss = sscanf(o4{1},'Train net output #0: rpn_cls_loss = %f');
            rpn_loss_bbox = sscanf(o5{1},'Train net output #1: rpn_loss_bbox = %f');
            cls_loss(p) = rpn_cls_loss(1);
            bbox_loss(p) = rpn_loss_bbox(1);
            p=p+1;
        else
            lastwarn('o4 is empty!');
            continue;
        end
    end;
end;
fclose(fid);
figure(1);
iter = iter(1:p-1);
cls_loss = cls_loss(1:p-1);
plot(iter,cls_loss);
figure(2);
bbox_loss = bbox_loss(1:p-1);
plot(iter,bbox_loss);