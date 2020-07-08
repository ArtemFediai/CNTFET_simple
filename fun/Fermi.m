function Fermi = Fermi(E,shift,kT)
sizeE = size(E,2);
if kT~=0
    for i=1:sizeE
    Fermi(i) = 1./(1+exp((E(i)+shift)/kT));
    end;
elseif kT==0
    for i=1:sizeE
    Fermi(i) = heaviside(-(E(i)+shift));
    end;
else
    'Error: Temperature is not positive and not zero!'
end;