%{
 Copyright 2013 KIOS Research Center for Intelligent Systems and Networks, University of Cyprus (www.kios.org.cy)

 Licensed under the EUPL, Version 1.1 or � as soon they will be approved by the European Commission - subsequent versions of the EUPL (the "Licence");
 You may not use this work except in compliance with theLicence.
 You may obtain a copy of the Licence at:

 http://ec.europa.eu/idabc/eupl

 Unless required by applicable law or agreed to in writing, software distributed under the Licence is distributed on an "AS IS" basis,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the Licence for the specific language governing permissions and limitations under the Licence.
%}

function dy = myode2(t, y, A, L, C, xt, time, GAMMA, B, Fj, nsources)

    g = interp1(time,xt,t);
%     f = interp1(time,fault,t);
%     g = xt 
    Zones = length(B);
    
%     %     persistent i
%     %     if isempty(i)
%     %         i = 0;
%     %     end
%     %     i = i + 1
% %     if t>time5
% %        Fj(5)=1;
% %     end
%     
%     dy = zeros(2*Zones+1,1); 
%    
%     if (0.0001<y(2*Zones+1))||((y(2*Zones+1)==0.0001)&&((-GAMMA*(C*y(Zones+1:2*Zones))' * (g' - C*y(1:Zones)))<=0))       
% %         y(2*Zones+1)=0;
%         
%         dy(2*Zones+1) =  GAMMA*(C*y(Zones+1:2*Zones))' * (g' - C*y(1:Zones));
%     else
%         dy(2*Zones+1)=0;
%     end
%     
%     
%     dy(1:Zones) = (A - L*C)*y(1:Zones) + L*g' + y(Zones+1:2*Zones)*dy(2*Zones+1) + B*Fj*y(2*Zones+1) + B*f' ;
% 
%     dy(Zones+1:2*Zones) = (A - L*C)*y(Zones+1:2*Zones) + B*Fj;
%     
% %     if t>3.4903
% %        dy(2*Zones+1)=0;
% %        y(2*Zones+1)=0;
% %     end

   dy = zeros(Zones + nsources*Zones+nsources,1); 
    
    for i=1:nsources
        if (0.0001<y(Zones + nsources*Zones+i))||((y(Zones + nsources*Zones+i)==0.0001)&&((-GAMMA*(C*y((i*Zones+1):(i*Zones+Zones)))' * (g' - C*y(1:Zones)))<=0))
            dy(Zones + nsources*Zones+i) =  GAMMA*(C*y((i*Zones+1):(i*Zones+Zones)))' * (g' - C*y(1:Zones));
        else
            dy(Zones + nsources*Zones+i)=0;
        end
        W(1:Zones, i) = y((i*Zones+1):(i*Zones+Zones)) ;
    end
    
    dy(1:Zones) = (A - L*C)*y(1:Zones) + L*g' + W*dy((Zones + nsources*Zones+1):(Zones + nsources*Zones+nsources)) + B*Fj*y((Zones + nsources*Zones+1):(Zones + nsources*Zones+nsources));

    
    for i=1:nsources
        dy((i*Zones+1):(i*Zones+Zones)) = (A - L*C)*y((i*Zones+1):(i*Zones+Zones)) + B*Fj(1:Zones,i);
    end     
    
