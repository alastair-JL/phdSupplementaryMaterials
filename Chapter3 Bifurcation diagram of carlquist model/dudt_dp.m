function [J]=dudt_dp(u,p) %%#ok


c_d=u(1,:);
c_de=u(2,:);
c_ded=u(3,:);
c_e=u(4,:);

%% p(1) = D_max/D_0    p(2)= E_max/E_0
D_0=319.17 ;
E_0=819.01;
c_D=p(1) - ([1,1,2,0]*u)./(p(3)*D_0); %%EFFECTIVE C_D.
c_E=p(2) - ([0,1,1,1]*u)./(p(3)*E_0); %%EFFECTIVE C_D.



J= [ [ (8186404148903883*conj(c_d))/(140737488355328*(conj(c_d) + conj(c_de) + 2*conj(c_ded) + 9233/50)^2) - (879061142088555*conj(c_de))/18446744073709551616 - (54231*conj(c_e))/100000 - (1198*conj(c_D)*(conj(c_d) + conj(c_de) + 2*conj(c_ded) - 26733/5))/16708125 - 8186404148903883/(140737488355328*(conj(c_d) + conj(c_de) + 2*conj(c_ded) + 9233/50)) - (481748250699971*conj(c_E))/144115188075855872 - (1198*conj(c_D)*conj(c_d))/16708125 - (6513*conj(c_D)*conj(c_de))/178220000 - (6599*conj(c_D)*conj(c_ded))/89110000 - (240394899230369*conj(c_E)*conj(c_de))/1208925819614629174706176 - (6263202886259471*conj(c_E)*conj(c_ded))/4835703278458516698824704 - (3967*conj(c_E)*conj(c_e))/2000, (8186404148903883*conj(c_d))/(140737488355328*(conj(c_d) + conj(c_de) + 2*conj(c_ded) + 9233/50)^2) - (6513*conj(c_D)*(conj(c_d) + conj(c_de) + 2*conj(c_ded) - 26733/5))/178220000 - (879061142088555*conj(c_d))/18446744073709551616 - (1198*conj(c_D)*conj(c_d))/16708125 - (6513*conj(c_D)*conj(c_de))/178220000 - (6599*conj(c_D)*conj(c_ded))/89110000 - (240394899230369*conj(c_E)*conj(c_d))/1208925819614629174706176 + 1931756009765791/36028797018963968, (8186404148903883*conj(c_d))/(70368744177664*(conj(c_d) + conj(c_de) + 2*conj(c_ded) + 9233/50)^2) - (6599*conj(c_D)*(conj(c_d) + conj(c_de) + 2*conj(c_ded) - 26733/5))/89110000 - (2396*conj(c_D)*conj(c_d))/16708125 - (6513*conj(c_D)*conj(c_de))/89110000 - (6599*conj(c_D)*conj(c_ded))/44555000 - (6263202886259471*conj(c_E)*conj(c_d))/4835703278458516698824704 + 8478300665020017/1180591620717411303424,                                                             - (54231*conj(c_d))/100000 - (3967*conj(c_E)*conj(c_d))/2000, - (1198*conj(c_d)*(conj(c_d) + conj(c_de) + 2*conj(c_ded) - 26733/5))/16708125 - (6513*conj(c_de)*(conj(c_d) + conj(c_de) + 2*conj(c_ded) - 26733/5))/178220000 - (6599*conj(c_ded)*(conj(c_d) + conj(c_de) + 2*conj(c_ded) - 26733/5))/89110000,                                                                                                                                                                                                                     - (481748250699971*conj(c_d))/144115188075855872 - (240394899230369*conj(c_d)*conj(c_de))/1208925819614629174706176 - (6263202886259471*conj(c_d)*conj(c_ded))/4835703278458516698824704 - (3967*conj(c_d)*conj(c_e))/2000]
[                                                                                                                                                                                                                                                                                                                                                                                                    (481748250699971*conj(c_E))/144115188075855872 - (879061142088555*conj(c_de))/18446744073709551616 + (54231*conj(c_e))/100000 + (240394899230369*conj(c_E)*conj(c_de))/1208925819614629174706176 + (6263202886259471*conj(c_E)*conj(c_ded))/4835703278458516698824704 + (3967*conj(c_E)*conj(c_e))/2000,                                                                                                                                                                          (240394899230369*conj(c_E)*conj(c_d))/1208925819614629174706176 - (172508762430561*conj(c_de))/72057594037927936 - (879061142088555*conj(c_d))/18446744073709551616 + (1185313987200281*conj(c_E)*conj(c_ded))/36893488147419103232 - 7377155448032397278246473/29514790517935282585600000,                                                            (1255809474056559*conj(c_E))/18889465931478580854784 + (3893*conj(c_e))/200 + (6263202886259471*conj(c_E)*conj(c_d))/4835703278458516698824704 + (1185313987200281*conj(c_E)*conj(c_de))/36893488147419103232 + (827742300075495*conj(c_E)*conj(c_ded))/9223372036854775808 + (4997*conj(c_E)*conj(c_e))/12500 + 8478300665020017/1180591620717411303424, (54231*conj(c_d))/100000 + (3893*conj(c_ded))/200 + (3967*conj(c_E)*conj(c_d))/2000 + (4997*conj(c_E)*conj(c_ded))/12500,                                                                                                                                                                                                                                                0, (481748250699971*conj(c_d))/144115188075855872 + (1255809474056559*conj(c_ded))/18889465931478580854784 + (827742300075495*conj(c_ded)^2)/18446744073709551616 + (240394899230369*conj(c_d)*conj(c_de))/1208925819614629174706176 + (6263202886259471*conj(c_d)*conj(c_ded))/4835703278458516698824704 + (3967*conj(c_d)*conj(c_e))/2000 + (1185313987200281*conj(c_de)*conj(c_ded))/36893488147419103232 + (4997*conj(c_ded)*conj(c_e))/12500]
[                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          (879061142088555*conj(c_de))/18446744073709551616,                                                                                                                                                                                                                                                                                                  (879061142088555*conj(c_d))/18446744073709551616 + (172508762430561*conj(c_de))/144115188075855872 - (1185313987200281*conj(c_E)*conj(c_ded))/73786976294838206464,                                                                                                                            - (1255809474056559*conj(c_E))/37778931862957161709568 - (3893*conj(c_e))/400 - (1185313987200281*conj(c_E)*conj(c_de))/73786976294838206464 - (827742300075495*conj(c_E)*conj(c_ded))/18446744073709551616 - (4997*conj(c_E)*conj(c_e))/25000 - 8478300665020017/1180591620717411303424,                                                            - (3893*conj(c_ded))/400 - (4997*conj(c_E)*conj(c_ded))/25000,                                                                                                                                                                                                                                                0,                                                                                                                                                                                                                          - (1255809474056559*conj(c_ded))/37778931862957161709568 - (827742300075495*conj(c_ded)^2)/36893488147419103232 - (1185313987200281*conj(c_de)*conj(c_ded))/73786976294838206464 - (4997*conj(c_ded)*conj(c_e))/25000]
[                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  -(54231*conj(c_e))/100000,                                                                                                                                                                                                                                                                                                                                                                      (172508762430561*conj(c_de))/144115188075855872 + 506405320206772239429/9444732965739290427392,                                                                                                                                                                                                                                                                                                                                                                                               -(3893*conj(c_e))/400,                                - (54231*conj(c_d))/100000 - (3893*conj(c_ded))/400 - 7438217202159149/144115188075855872,                                                                                                                                                                                                                                                0,                                                                                                                                                                                                                                                                                                                                                                                                                                              0] ] ;


J=[J(1:4,5),J(1:4,6),-J(1:4,5).*(- [1,1,2,0]*u)./(p(3)^2)/D_0-J(1:4,6).*( - [0,1,1,1]*u)./(p(3)^2)/E_0];

end