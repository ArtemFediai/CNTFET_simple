%Ids(Uds, Ugs) main script
clc;
clear all;
close all;
addpath('fun')
global G0 kB
G0 = 7.7480917310E-5; %[Ohm^-1] quantum conductance
kB = 8.6173303510E-5; %[eV*K^-1] Bolzmann constant

settings = ReadYaml('inp/settings.yaml');%you can create the yaml file with the other name
Uds = linspace(settings.Uds{2}, settings.Uds{1},settings.Uds{3});
Ugs = linspace(settings.Ugs{2}, settings.Ugs{1},settings.Ugs{3});
Vds = -settings.alpha_Uds*linspace(settings.Uds{2}, settings.Uds{1},settings.Uds{3});
Vgs = -settings.alpha_Ugs*linspace(settings.Ugs{2}, settings.Ugs{1},settings.Ugs{3});
E11 = settings.E11;
E22 = settings.E22;
delta = settings.delta;
T = settings.T;
Tol = settings.Tol;
kT = kB*T;

Ids = zeros(size(Vds,2),size(Vgs,2));
for i=1:size(Vds,2)
    a = -25*kT+min(Vds(i),0);
    b =  25*kT+max(Vds(i),0);
    for j=1:size(Vgs,2)
        Ids(i,j) = quad('fun4int', a, b, Tol, [], Vds(i), Vgs(j), E11, E22, delta, kT);
    end;
end;
mkdir('out');
figure('Name','transfer') %transfer characteristic
for i=1:size(Uds,2)
    semilogy(Ugs,abs(Ids(i,:)));
    ylim([1e-10,1e-5]);%lower limit
    xlabel('U_{gs} [V]');
    ylabel('I_{ds} [A]');
    grid on;
    hold on;
end;    
if size(Uds,2)==1
legend(['U_{ds} = ',num2str(Uds(1))])
elseif size(Uds,2)>1
    str{1} = ['U_{ds} = ',num2str(Uds(1))];
    for i=2:size(Uds,2)
    str{i} = num2str(Uds(i));
    end;
    legend(str)
end;
savefig('out/transfer.fig');

figure('Name','output') %output characteristic
for i=1:size(Ugs,2)
    plot(Uds,Ids(:,i));
    xlabel('U_{ds} [V]');
    ylabel('I_{ds} [A]');
    grid on;
    hold on;
end;
if size(Ugs,2)==1
legend(['U_{gs} = ',num2str(Ugs(1))])
elseif size(Ugs,2)>1
    str1{1} = ['U_{gs} = ',num2str(Ugs(1))];
    for i=2:size(Ugs,2)
    str1{i} = num2str(Ugs(i));
    end;
    legend(str1)
end;
savefig('out/output.fig');