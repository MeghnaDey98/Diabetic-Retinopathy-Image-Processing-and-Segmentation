function [P, N, T] = calculatePNT2(segmented_image,gt_image) %function for calculating the evaluation metrics of segmentation
%given a ground truth image
n1=size(segmented_image); %segmented image size
n2=size(gt_image); %ground truth(gt) image size
tn=0; %true negative
tp=0; %true postive
fp=0; %false positive
fn=0;%false negative
if n1==n2
    for i =1:n1(1)
        for j=1:n2(1)
            if segmented_image(i,j)==0 && gt_image(i,j)==0 %if a certain pixel is not segmented in both the images
                tn=tn+1;
            elseif segmented_image(i,j)==0 && gt_image(i,j)==1 %if certain pixel is not segmented in our routine but segmented in gt
                fn=fn+1;
            elseif segmented_image(i,j)==1 && gt_image(i,j)==0 %if certain pixel is segmented in our routine but not segmented in gt
                fp=fp+1;
            else %final case left is segmented in both cases
                tp=tp+1;
            end
        end
    end
    %Sensitivity 
    N= tp/ (tp + fn);
    %Specificity 
    P= tn/ (tn + fp);
    %Accuracy 
    T= (tp+tn) /(tp+tn+fp+fn);
else
    disp('The size of the images dont match. Please try again.')
end
end