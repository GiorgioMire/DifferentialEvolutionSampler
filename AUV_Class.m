classdef AUV_Class < matlab.System
    properties(DiscreteState)
        nu
        eta
    end
    properties
        nu0
        eta0
        Ts
        theta
    end
    
    methods (Access = protected)
        
        function [nu_tilde,eta_tilde] = stepImpl(obj,tau)
            tau=reshape(tau,[],1);
            m1_1=obj.theta(1);
            m2_2=obj.theta(2);
            m2_6=obj.theta(3);
            m6_6=obj.theta(4);
            d1_1=obj.theta(5);
            d2_2=obj.theta(6);
            d2_6=obj.theta(7);
            d6_6=obj.theta(8);
            u=obj.nu(1);
            v=obj.nu(2);
            r=obj.nu(3);
            
            psi=obj.eta(3);
            c=cos(psi);
            s=sin(psi);
            J=[c -s 0;s c 0; 0 0 1];
            etadot=J*obj.nu;
            obj.eta=obj.eta+obj.Ts*etadot; 
             
            M=[ m1_1,    0,    0;
                0, m2_2, m2_6;
                0, m2_6, m6_6];
            
            D=[ d1_1,    0,    0;
                0, d2_2, d2_6;
                0, d2_6, d6_6];
            
           C=-skew([M(1:2,:)*obj.nu;0]);
            
            
     nudot=M\(tau-C*obj.nu-D*obj.nu);
           obj.nu=obj.nu+obj.Ts*nudot;
            
   
            
            nu_tilde=obj.nu;
            eta_tilde=obj.eta;
            
        end
        
        
        
        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            obj.nu=reshape(obj.nu0,[],1);
            obj.eta=reshape(obj.eta0,[],1);
        end
    end
    
    
    
    
    
    
end
