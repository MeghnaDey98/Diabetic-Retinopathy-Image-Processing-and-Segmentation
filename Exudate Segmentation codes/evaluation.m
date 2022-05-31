% Masks = 'm'

% segmented = 'Images_TBH_Ad'

Print_all_images(nfiles, Images_TBH_Ad)
Print_all_images(nfiles, M)

%%

for i = 1:nfiles
    tp = 0;
    tn = 0;
    fp = 0;
    fn = 0;

    %ground truth
    RIGHT = cell2mat(M(i));

    %predicted
    PREDICTED = cell2mat(Images_TBH_Ad(i));
    all_p = 512*512;

    for j = 1:512
        for k = 1:512
            
            if(RIGHT(j, k) == 1 && PREDICTED(j, k) == 1)
                tp = tp + 1;
            end
            
            if(RIGHT(j, k) == 0 && PREDICTED(j, k) == 0)
                tn = tn + 1;
            end

            if(RIGHT(j, k) == 0 && PREDICTED(j, k) == 1)
                fp = fp + 1;
            end
            
            if(RIGHT(j, k) == 1 && PREDICTED(j, k) == 0)
                fn = fn + 1;
            end
        end
    end

    TP(i) = tp/all_p;
    TN(i) = tn/all_p;
    FP(i) = fp/all_p;
    FN(i) = fn/all_p;   
end

%%
TP(4:7)= [];TP(8:11)= []; TP(10:15)= [];
TN(4:7)= [];TN(8:11)= []; TN(10:15)= [];
FP(4:7)= [];FP(8:11)= []; FP(10:15)= [];
FN(4:7)= [];FN(8:11)= []; FN(10:15)= [];
%%
%averages
TP_Av = sum(TP, 'all')/23
TN_Av = sum(TN, 'all')/23
FP_Av = sum(FP, 'all')/23
FN_Av = sum(FN, 'all')/23
%%
%Evaluation
Acc = (TP_Av + TN_Av)/(TP_Av + TN_Av + FP_Av + FN_Av);
Sens = TP_Av/(TP_Av+FN_Av);
spec = TN_Av/(TN_Av+FP_Av);

Per = TP_Av/(TP_Av+FP_Av);
Rec = TP_Av/(TP_Av+FN_Av);
F1 = (2*Per*Rec)/(Per+Rec);