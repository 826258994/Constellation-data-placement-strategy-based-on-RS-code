function [C_intra,C_inter] = count_C(SG)
SNR_intra = SG.Pt_intra * 10^(SG.Gt/10) * 10^(SG.Gr/10) / ((4*pi*SG.l_intra*SG.f/SG.c)^2*SG.N0*SG.B);
SNR_inter = SG.Pt_inter * 10^(SG.Gt/10) * 10^(SG.Gr/10) / ((4*pi*SG.l_inter*SG.f/SG.c)^2*SG.N0*SG.B);
C_intra = SG.B*log2(1+SNR_intra)*1e-6; %化成Mbps，要和alph单位相同，除数为秒
C_inter = SG.B*log2(1+SNR_inter)*1e-6;
end