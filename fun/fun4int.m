function fun4int = fun4int(E,Vds,Vgs,E11,E22,delta,kT)
%Landauer-Buttiker
global G0;
sizeE = size(E,2);
for i=1:sizeE
    fun4int(i) = G0*Transmission(E(i),Vgs,E11,E22,delta)*(Fermi(E(i),Vds,kT) - Fermi(E(i),0,kT));
end;