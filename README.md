# UFR Blois Development Web

## Play with Ruby online
- [Ruby Online Interpreter](https://replit.com/languages/ruby)
- [Ruby Doc](https://ruby-doc.org)

## TD Setup

1. Launch the Developer VM (E:\apps\)
2. Launch a Terminal
3. Launch `irb`
4. Download the TD PDF
5. Go to the TD live help -> https://1.101.fr/

## Access Internet in the VM at the **university**

- in `irb`: `ENV['http_proxy'] = "http://proxy:3128"`
- OR 
- in `terminal`: `export http_proxy="http://proxy:3128"`

## Install and use the Developer WM at **home**

1. Download and Install *VirtualBox* AND *Oracle VM VirtualBox Extension Pack* -> https://www.virtualbox.org/wiki/Downloads
2. Download the VM -> http://www.info.univ-tours.fr/ftp/utfr/diblois/etu/.ed536a06cf9a0ff2df7b7f552cb1c92b856cbecd04caf9d1fa729a6761067f70_utfr_diblois_vm_linux_centos8_webdeveloper/
3. Extract VM (.rar)
4. In Virtual Box, Machine > Add, `20210914_utfr_diblois_vm_linux_centos8_developer_2021.vbox`
5. Launch the Virtual Machine with
   1. In the Virtual Machine, disable the proxy
      1. Navigate in the menu System > Preferences > Internet and Network > Network Proxy
      2. Disable the proxy by selecting "Direct Internet Connection"
