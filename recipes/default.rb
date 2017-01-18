#
# Cookbook Name:: qlik-sense
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

directory 'c:/QlikSp' do
  action :create
  rights :full_control, 'qliklocal\qservice', :applies_to_children => true
  not_if { ::Dir.exists?("c:/QlikSp") }
end

powershell_script 'NewShare' do
  code <<-EOH
  if(!(Get-SMBShare -Name QlikSP -ea 0)){
    New-SmbShare -Name QlikSP -Path c:\\QlikSP -FullAccess qliklocal\\qservice
    }
  EOH
end

windows_package "QlikSense" do
  source 'c:/apps/Qlik_Sense_setup.exe'
  options  '-s dbpassword=Qlik1234 hostname=qs12.qliklocal.net userwithdomain=qliklocal\qservice password=Qlik1234 spc=c:\apps\sp_config.xml'
  installer_type :custom
  action :install
  not_if { ::File.exists?("c:\\program files\\Qlik\\Sense\\ServiceDispatcher\\ServiceDispatcher.exe")}
end

powershell_script 'QlikCli' do
   code <<-EOH
    $statusCode = 0
    while ($StatusCode -ne 200) {
      start-Sleep -s 5
      try { $statusCode = (invoke-webrequest  https://qs12.qliklocal.net/qps/user -usebasicParsing).statusCode }
    Catch { 
        start-Sleep -s 5
        }
    }
   Connect-Qlik qs12.qliklocal.net -UseDefaultCredentials
   $a = Get-QlikLicense
   if ($a -eq 'null')
    {Set-QlikLicense -serial XXX -control XXX -name Qlik -organization Qlik}
   EOH
end
