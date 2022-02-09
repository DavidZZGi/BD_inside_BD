unit ModuloDatos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB,Dialogs,DBGrids;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    SQLite3Connection1: TSQLite3Connection;
    SQLite3Connection2: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
  private

  public
    CantidadDeInstancias:integer;
    ValoresInstanciasDelAtributo:Array of variant;
    function Get_TipoAtributo(FTabla: string; IndexAtributo: integer): string;
    Procedure Get_InstanciasDelAtributo(FTabla: string;IndexAtributo:integer);
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

function TDataModule1.Get_TipoAtributo(FTabla: string; IndexAtributo: integer
  ): string;
var
  TipoDato:string;
  FTipoDato:TFieldType;
  NumCampo:integer;
begin
 NumCampo:=IndexAtributo;
 Self.SQLQuery1.Close;
 try
    Self.SQLQuery1.SQL.Clear;
    Self.SQLQuery1.sql.text := 'select * from'+' '+FTabla;
    Self.SQLQuery1.Open;
    CantidadDeInstancias:=Self.SQLQuery1.RecordCount;
 except
   on e:EDatabaseError do ShowMessage(e.Message);
 end;
 Self.SQLQuery1.FieldDefs.Update;
 FTipoDato:=Self.SQLQuery1.Fields.Fields[NumCampo].DataType;
  case FTipoDato of
              ftUnknown      : TipoDato:= 'Unknown';
              ftString       : TipoDato:= 'String';
              ftSmallint     : TipoDato:= 'Smallint';
              ftInteger      : TipoDato:= 'Integer';
              ftWord         : TipoDato:= 'Word';
              ftBoolean      : TipoDato:= 'Boolean';
              ftAutoinc      : TipoDato:= 'Autoinc';
              ftMemo         : TipoDato:= 'Text';
              ftDate         : TipoDato:= 'Date';
              ftfloat        : TipoDato:= 'Double';
       else
             TipoDato:= 'DESCONOCIDO';
   end;
 Result := TipoDato;
end;

procedure TDataModule1.Get_InstanciasDelAtributo(FTabla: string;IndexAtributo: integer);
var
  NombreCampo:string;
  CantRegistros:integer;
  Index:integer;
  NumCampo:integer;
  valor:Variant;
begin
 NumCampo:=IndexAtributo;
 try
    Self.SQLQuery2.SQL.Clear;
    Self.SQLQuery2.sql.text := 'select * from'+' '+FTabla;
    Self.SQLQuery2.Open;
    except
   on e:EDatabaseError do ShowMessage(e.Message);
 end;
    self.SQLQuery2.Last;
    CantRegistros:=self.SQLQuery2.RecordCount;
  //  CantidadDeInstancias:=CantRegistros;
    SetLength(ValoresInstanciasDelAtributo,CantRegistros);
    Index:=0;
    NombreCampo:=Self.SQLQuery1.Fields.Fields[NumCampo].DisplayName;
 try
 while not self.SQLQuery2.EOF do
       begin
         ValoresInstanciasDelAtributo[Index]:=self.SQLQuery2.Fields.FieldByName(NombreCampo).Value;
         valor:=ValoresInstanciasDelAtributo[Index];
         inc(index);
         self.SQLQuery2.Next;
        end;
 finally
   self.SQLQuery2.Close;
 end;
end;





end.

