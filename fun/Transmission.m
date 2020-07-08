function Transmission = Transmission(E,Vgs,E11,E22,delta)
sizeE = size(E,2);
DELTA = delta + Vgs;
for i=1:sizeE
    Transmission(i) = 2*(heaviside( E(i) - E11/2 - DELTA) + heaviside( E(i) - E22/2 - DELTA) + ...
                    + heaviside(-(E(i) + E11/2 - DELTA)) + heaviside(-(E(i) + E22/2 - DELTA)));
end;