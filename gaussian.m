function gauss=gaussian(sigma,ifhp)
    mu1=132.5;mu2=180.5;rho=0;sigma1=sigma;sigma2=sigma;
    [x,y] = meshgrid(1:264,1:360);
    gauss=exp(-1/(2*(1-rho^2))*((x-mu1).^2/sigma1^2-2*rho.*(x-mu1).*(y-mu2)/(sigma1*sigma2)+(y-mu2).^2/sigma2^2))/(2*pi*sigma1*sigma2*sqrt(1-rho^2));
    gauss=(gauss-min(min(gauss)))/(max(max(gauss))-min(min(gauss)));
    %高斯分布图像
    
    if ifhp==0
        subplot(1,2,2);s=surf(x,y,gauss);s.EdgeColor = 'none';title("低通");
    else
        subplot(1,2,1);p=surf(x,y,1-gauss);p.EdgeColor = 'none';title("高通");
    end
    %}
    
end