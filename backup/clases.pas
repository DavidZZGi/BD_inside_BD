unit Clases;

{$mode objfpc}{$H+}

interface
//uses Classes,DB,ModuloDatos;
uses Classes;
type

 { Table }
 {Esta clase tiene la responsabilidad de almacenar el ID y el Nombre de una tabla,
  asi como sus atributos}
 Table=class
 private
 FCategoriaID:integer;
 FNombreCategoria:string;
 public
 ListAtributos:TstringList;
 function Get_IDCategoria: integer;
 function Get_NomCategoria: string;
 procedure Set_IDCategoria(AValue: integer);
 procedure Set_NomCategoria(AValue: string);
 constructor Create(AID_Categoria:integer;ANom_Categoria:string);
 constructor create;
  end;

 { TAtributo }
 {Esta clase tiene la responsabilidad de almacenar el ID,Nombre y el Tipo de
 todos los  campos-atributos de una tabla}
 TAtributo=class
  private
     FAtributoID:integer;
     FNombreAtributo:String;
     FtipoAtributo:String;
  public
    ListaInstancias:TstringList;
    function Get_IDAtributo: integer;
    function Get_NomAtributo: String;
    function Get_TipoAtributo: String;
    procedure Set_IDAtributo(AValue: integer);
    procedure Set_NomAtributo(AValue: String);
    procedure Set_TipoAtributo(AValue: String);
    Constructor Create;
   end;

 { TInstancia }
 {Tiene la responsabilidad de almacenar el ID de la Tabla y el ID de la tupla}
 TInstancia=class
 private
 FCategoriaID:integer;
 FAtributoID:integer;
 FInstanciaId:integer;
 ValorInstAtrb:variant;
 public
 function Get_IDcategoria:integer;
 function Get_IDAtributo:integer;
 function Get_IDInstancia:integer;
 function Get_ValorInstAtrb:variant;
 Procedure Set_IDcategoria(AValue:integer);
 Procedure Set_IDAtributo(AValue:integer);
 Procedure Set_IDInstancia(AValue:integer);
 Procedure Set_ValorInstAtrb(AValue:variant);
 constructor Create(aIDCategoria,aIDAtributo,aIDInstancia:integer);
 constructor create;
 end;

 { TAtributo_Instancia }

 TAtributo_Instancia=class
 private
 idAtributo_Instancia:integer;
 idInstancia:integer;
 valor:variant ;
 atributoID:integer;
 public
 function Get_idAtributo_Instancia:integer;
 function Get_idInstancia:integer;
 function Get_valor:variant;
 function Get_atributoID:integer;
 Procedure Set_idAtributo_Instancia(AValue:integer);
 Procedure Set_idInstancia(AValue:integer);
 Procedure Set_valor(AValue:variant);
 Procedure Set_atributoID(AValue:integer);
 constructor create;
  end;

 { TCategoria_Atributo }

 TCategoria_Atributo=class
 private
 idCategoria_Atributo:integer;
 idCategoria:integer;
 idAtributo:integer;
 public
 function Get_idCategoria_Atributo:integer;
 function Get_idCategoria:integer;
 function Get_idAtributo:integer;
 Procedure Set_idCategoria_Atributo(AValue:integer);
 Procedure Set_idCategoria(AValue:integer);
 Procedure Set_idAtributo(AValue:integer);
 constructor create;
 end;

 { TCategoria_Categoria }

 TCategoria_Categoria=class
 private
 idCatCat:integer;
 idFatherCat:integer;
 idSonCat:integer;
 public
   Procedure set_idCatCat(Avalue:integer);
   Procedure Set_idFatherCat(AValue:integer);
   Procedure Set_idSonCat(AValue:integer);
   Function Get_idCatCat:integer;
   function Get_idFatherCat:integer;
   function Get_idSonCat:integer;
   Constructor Create;
 end;

  { TInstancia_Instancia }

  TInstancia_Instancia=class
 private
 idFatherInst:integer;
 idSonInst:integer;
 public
   Procedure Set_idFatherInst(AValue:integer);
   Procedure Set_idSonInst(AValue:integer);
   function Get_idFatherInst:integer;
   function Get_idSonInst:integer;
   Constructor Create;
 end;






implementation

{ TCategoria_Atributo }

function TCategoria_Atributo.Get_idCategoria_Atributo: integer;
begin
  result:=idCategoria_Atributo;
end;

function TCategoria_Atributo.Get_idCategoria: integer;
begin
    Result:=idCategoria;
end;

function TCategoria_Atributo.Get_idAtributo: integer;
begin
       Result:=idAtributo;
end;

procedure TCategoria_Atributo.Set_idCategoria_Atributo(AValue: integer);
begin
        idCategoria_Atributo:=AValue;
end;

procedure TCategoria_Atributo.Set_idCategoria(AValue: integer);
begin
                        idCategoria:=AValue;
end;

procedure TCategoria_Atributo.Set_idAtributo(AValue: integer);
begin
                    idAtributo:=AValue;
end;

{ TAtributo_Instancia }

function TAtributo_Instancia.Get_idAtributo_Instancia: integer;
begin
  result:=idAtributo_Instancia;
end;

function TAtributo_Instancia.Get_idInstancia: integer;
begin
       result:=idInstancia;
end;

function TAtributo_Instancia.Get_valor: variant;
begin
      result:=valor;
end;

function TAtributo_Instancia.Get_atributoID: integer;
begin
        result:=atributoID;
end;

procedure TAtributo_Instancia.Set_idAtributo_Instancia(AValue: integer);
begin
        idAtributo_Instancia:=AValue;
end;

procedure TAtributo_Instancia.Set_idInstancia(AValue: integer);
begin
          idInstancia:=AValue;
end;

procedure TAtributo_Instancia.Set_valor(AValue: variant);
begin
          valor:=AValue;
end;

procedure TAtributo_Instancia.Set_atributoID(AValue: integer);
begin
    atributoID:=AValue;
end;

constructor TAtributo_Instancia.create;
begin
  inherited create;
end;

{ TInstancia_Instancia }

procedure TInstancia_Instancia.Set_idFatherInst(AValue: integer);
begin
  self.idFatherInst:=AValue;
end;

procedure TInstancia_Instancia.Set_idSonInst(AValue: integer);
begin
  self.idSonInst:=AValue;
end;

function TInstancia_Instancia.Get_idFatherInst: integer;
begin
 result:=self.idFatherInst;
end;

function TInstancia_Instancia.Get_idSonInst: integer;
begin
  result:=self.idSonInst;
end;

constructor TInstancia_Instancia.Create;
begin
  inherited create;
end;

{ TCategoria_Categoria }

procedure TCategoria_Categoria.set_idCatCat(Avalue: integer);
begin
  self.idCatCat:=Avalue;
end;

procedure TCategoria_Categoria.Set_idFatherCat(AValue: integer);
begin
  self.idFatherCat:=AValue;
end;

procedure TCategoria_Categoria.Set_idSonCat(AValue: integer);
begin
  self.idSonCat:=AValue;
end;

function TCategoria_Categoria.Get_idCatCat: integer;
begin
  result:=self.idCatCat;
end;

function TCategoria_Categoria.Get_idFatherCat: integer;
begin
 result:=self.idFatherCat;
end;

function TCategoria_Categoria.Get_idSonCat: integer;
begin
  result:=self.idSonCat;
end;

constructor TCategoria_Categoria.Create;
begin
 inherited create;
end;

{ TInstancia }

function TInstancia.Get_IDcategoria: integer;
begin
 result:=FCategoriaID;
end;

function TInstancia.Get_IDAtributo: integer;
begin
 result:=FAtributoID;
end;

function TInstancia.Get_IDInstancia: integer;
begin
  result:=FInstanciaId;
end;

function TInstancia.Get_ValorInstAtrb: variant;
begin
  result:=ValorInstAtrb;
end;

procedure TInstancia.Set_IDcategoria(AValue: integer);
begin
  FCategoriaID:=AValue;
end;

procedure TInstancia.Set_IDAtributo(AValue: integer);
begin
 FAtributoID:=AValue;
end;

procedure TInstancia.Set_IDInstancia(AValue: integer);
begin
 FInstanciaId:=AValue;
end;

procedure TInstancia.Set_ValorInstAtrb(AValue: variant);
begin
 ValorInstAtrb:=AValue;
end;

constructor TInstancia.Create(aIDCategoria,aIDAtributo,aIDInstancia:integer);
begin
  inherited create;
  self.FInstanciaId:=aIDInstancia;
  self.FCategoriaID:=aIDCategoria;
  self.FAtributoID:=aIDAtributo;
end;

constructor TInstancia.create;
begin
    inherited create;
end;

{ TAtributo }

function TAtributo.Get_IDAtributo: integer;
begin
  result:=FAtributoID;
end;

function TAtributo.Get_NomAtributo: String;
begin
  result:=FNombreAtributo;
end;

function TAtributo.Get_TipoAtributo: String;
begin
  result:=FtipoAtributo;
end;

procedure TAtributo.Set_IDAtributo(AValue: integer);
begin
  FAtributoID:=AValue;
end;

procedure TAtributo.Set_NomAtributo(AValue: String);
begin
  FNombreAtributo:=AValue;
end;

procedure TAtributo.Set_TipoAtributo(AValue: String);
begin
  FtipoAtributo:=AValue;
end;

constructor TAtributo.Create;
begin
  inherited create;
  ListaInstancias:=TstringList.Create;
end;



{ Table }

function Table.Get_IDCategoria: integer;
begin
 result:=FCategoriaID;
end;

function Table.Get_NomCategoria: string;
begin
 result:=FNombreCategoria;
end;

procedure Table.Set_IDCategoria(AValue: integer);
begin
  FCategoriaID:=AValue;
end;

procedure Table.Set_NomCategoria(AValue: string);
begin
 FNombreCategoria:=AValue;
end;

constructor Table.Create(AID_Categoria:integer;ANom_Categoria:string);
begin
  inherited create;
  self.FCategoriaID:=AID_Categoria;
  self.FNombreCategoria:=ANom_Categoria;
  self.ListAtributos:=TstringList.Create;
end;

constructor Table.create;
begin
  inherited create;
  self.ListAtributos:=TStringList.Create;
end;





end.

