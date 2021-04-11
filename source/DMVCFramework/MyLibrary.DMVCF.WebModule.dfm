object MyLibrary_DMVCF_WebModule: TMyLibrary_DMVCF_WebModule
  OldCreateOrder = False
  OnCreate = WebModuleCreate
  OnDestroy = WebModuleDestroy
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
    end>
  Height = 230
  Width = 415
end
