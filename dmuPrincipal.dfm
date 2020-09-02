object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 393
  Width = 540
  object fdConexaoPrincipal: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\simplesssms\Documents\Embarcadero\Studio\Proje' +
        'cts\ProjetoTesteAgrotis\Banco\TESTEAGROTIS.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=IB')
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object fdTransactionPrincipal: TFDTransaction
    Connection = fdConexaoPrincipal
    Left = 144
    Top = 16
  end
  object qryExecutar: TFDQuery
    Connection = fdConexaoPrincipal
    Left = 40
    Top = 112
  end
end
