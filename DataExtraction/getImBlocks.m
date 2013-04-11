% Function to build image blocks
%   function imBlocks = getImBlocks(im, atomSize, nAtom)
% Input
%   im - image
%   atomSize - size of image blocks
%   nAtom - number of image blocks
% 
% Output
%   imBlocks - vectorized image blocks
% 




function imBlocks = getImBlocks(im, atomSize, nAtom)

imVec = [im2col(im(:,:,1), [atomSize, atomSize]);im2col(im(:,:,2), [atomSize, atomSize]);im2col(im(:,:,3), [atomSize, atomSize])];

nVec = size(imVec,2);

if ( nVec < nAtom )
    nAtom = nVec;
end

rId = randperm(nVec);
rId = rId(1:nAtom);

imBlocks = imVec(:,rId);














