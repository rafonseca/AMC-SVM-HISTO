function Xhist=hist2_of_seq(Xseq,nbins2d)
global use1D

if use1D==1
    fprintf('\n\nUsing 1D hist in hist2_of_seq\n\n');
    Xhist=zeros(1,nbins2d*2);
    for i=1:length(Xseq)
            re=(1+real(Xseq(i)))/2;
            im=(1+imag(Xseq(i)))/2;
            % o range vai de (0,1)*nbins2d
            ind_re=1+floor(re*nbins2d); % fix rounds -0.001 to 0 and 16.001 to 16
            ind_im=1+floor(im*nbins2d);
            ind_re=min([ind_re nbins2d]);
            ind_im=min([ind_im nbins2d]);
            ind_re=max([ind_re 1]);
            ind_im=max([ind_im 1]);
            
            Xhist(1,ind_re)=Xhist(1,ind_re)+1;
            Xhist(1,ind_im+nbins2d)=Xhist(1,ind_im+nbins2d)+1;
            
    end
    return
else
    Xhist=zeros(1,nbins2d^2);
    for i=1:length(Xseq)
            re=(1+real(Xseq(i)))/2;
            im=(1+imag(Xseq(i)))/2;
            % o range vai de (0,1)*nbins2d
            ind_re=1+floor(re*nbins2d); % fix rounds -0.001 to 0 and 16.001 to 16
            ind_im=1+floor(im*nbins2d);
            ind_re=min([ind_re nbins2d]);
            ind_im=min([ind_im nbins2d]);
            ind_re=max([ind_re 1]);
            ind_im=max([ind_im 1]);

            Xhist(1,ind_re+(ind_im-1)*nbins2d)=Xhist(1,ind_re+(ind_im-1)*nbins2d)+1;
    end

    return
end