
%s = spi("aardvark",0,0)

%c = NET.Assembly("CyUSB")
%view = NET.interfaceView(c,typename)
%NET.addAssembly(c.Na)
%loadlibrary("DIFxAPI","D:\seasar\Cypress USB-Serial Driver\DIFxAPI.dll")
%loadlibrary("ADI_CYUSB", "C:\Windows\System32\drivers\ADI_CYUSB.sys");
%loadlibrary('CyUSB','D:\ADF435x\CyUSB.DLL','addheader','D:\ADF435x\CyUSB.h')
% D:\libusb\MinGW64\dll\libusb-1.0.dll
loadlibrary("libusb", "D:\libusb\include\libusb.h")
loadlibrary("D:\ADF435x\CyUSB.dll", 'D:\ADF435x\CyUSB.h');