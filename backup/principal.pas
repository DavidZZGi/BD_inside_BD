unit Principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DBGrids, Buttons, ModuloDatos, Clases,DB;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid; // Mostrar instancias de la tabla activa
    Ed_NombreBBDD: TEdit; // Mostrar nombre de la BBDD
    Ed_TablaAct: TEdit; // Mostrar nombre de la tabla activa
    Ed_CantAtributos: TEdit; // MOstrar cantidad de campos de la tabla activa
    Ed_CantTablas: TEdit; // Mostrar la cantidad de tablas de la BBDD
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LBox_Tablas: TListBox; // Visualizar los nombres de las tablas
    LBox_Atributo: TListBox;// Visualizar los campos de la tabla activa
    LBox_TipoAtributo: TListBox; // Mostrar los tipos de los campos de la tabla activa
    Panel1: TPanel;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
  private
     ConnInstancia:TInstancia;
     ConnAtributo:TAtributo;
     ListaTablas:TstringList;
     ListaCatCat:TstringList;
     ListaInstInst:TstringList;
     ObjAtributo_Instancia:TstringList;
     ObjCategoria_Atributo:TstringList;
     function Buscar_PK(index:integer):string;
     procedure Buscar_TablaFK (StrPK:string;IndexOfTabla:integer);// Resultado en ListaCatCat(id_TablaPadre,Id_TablaHijo)
     procedure llenarObjetos(); //Para Acomodar la estructura de salida

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
   ListaTablas:=TstringList.Create;
   ListaCatCat:=TstringList.Create;
   ListaInstInst:=TstringList.Create;
   ObjAtributo_Instancia:=TstringList.Create;
   ObjCategoria_Atributo:=TstringList.Create;
end;

procedure TForm1.Panel3Click(Sender: TObject);
begin

end;



function TForm1.Buscar_PK(index:integer): string;
var
indexAtributo,indexTabla:integer;
tipoCampo,NombreCampo:String;
RecordAtributo:TAtributo;
RecordTabla:Table;
cant:integer;
begin
   RecordAtributo:=TAtributo.Create;
   RecordTabla:=Table.Create(1,'');
   indexTabla:=index;
   RecordTabla:= Table(self.ListaTablas.Objects[indexTabla]);
   cant:=RecordTabla.ListAtributos.Count;
    for indexAtributo:=0 to cant-1 do
     begin
       RecordAtributo:=TAtributo(RecordTabla.ListAtributos.Objects[indexAtributo]);
       tipoCampo:=RecordAtributo.Get_TipoAtributo;
       if tipoCampo='Autoinc' then
        begin
             NombreCampo:=RecordAtributo.Get_NomAtributo;
             result:=NombreCampo;
             exit;
        end;
     end;

 end;
// Conocida la PK de una tabla (StrPK), buscar las FK en el resto de las tablas
// ListaCatCat(
procedure TForm1.Buscar_TablaFK (StrPK:string;IndexOfTabla:integer);
var
  RecordTablaPadre: Table;
  RecordAtributo:TAtributo;
  RecordTablaHijo:Table;
  CatCat:TCategoria_Categoria;
//  InstInst:TInstancia_Instancia;
  PK_Activa:string;
  indexFK:integer;
  indexAtributo:integer;
  cantTablas:integer;
  cantAtributos:integer;
  NombreAtributo,NombrePK:string;
  idCatCat:integer;
begin
   PK_Activa:=StrPK;
//  InstInst:=TInstancia_Instancia.Create;
  RecordAtributo:=TAtributo.Create;
  RecordTablaHijo:=Table.Create(1,'');
  RecordTablaPadre:=Table.Create(1,'');
  cantTablas:=self.ListaTablas.Count;
  RecordTablaPadre:=Table(self.ListaTablas.Objects[IndexOfTabla]);
  if IndexOfTabla=0 then idCatCat:=0;
      for indexFK:=0 to cantTablas-1 do
         begin
           if IndexOfTabla<>indexFK then
            begin
                RecordTablaHijo:=Table(self.ListaTablas.Objects[indexFK]);
                cantAtributos:=RecordTablaHijo.ListAtributos.Count;
                for indexAtributo:=0 to cantAtributos-1 do
                   begin
                      RecordAtributo:=TAtributo(RecordTablaHijo.ListAtributos.Objects[indexAtributo]);
                      NombrePK:=PK_Activa+'_id';
                      NombreAtributo:='id_'+RecordAtributo.Get_NomAtributo;

                        if NombrePK = NombreAtributo then
                              begin
                                   inc(idCatCat);
                                   CatCat:=TCategoria_Categoria.Create;
                                   CatCat.set_idCatCat(idCatCat);
                                   CatCat.Set_idFatherCat(RecordTablaPadre.Get_IDCategoria);
                                   CatCat.Set_idSonCat(RecordTablaHijo.Get_IDCategoria );
                                   self.ListaCatCat.AddObject(RecordTablaPadre.Get_NomCategoria,CatCat);
                              end;
                   end;
            end;
    end;
end;

procedure TForm1.llenarObjetos();
var
   pruebCantIns:integer;
   pruebCantAtr:integer;

  RecordTabla:Table;
  RecordAtributo:TAtributo;
  RecordInstancia:TInstancia;
  RecordAtributo_Instancia:TAtributo_Instancia;
  RecordAtributo_Categoria:TCategoria_Atributo;
  indexTable:integer;
  indexAtributo:integer;
  indexInstancia:integer;
  IdCatAtribut,IdAtrInst:integer;
begin

      RecordTabla:=Table.create;
      RecordAtributo:=TAtributo.Create;
      RecordInstancia:=TInstancia.Create;
      RecordAtributo_Instancia:=TAtributo_Instancia.create;
      RecordAtributo_Categoria:=TCategoria_Atributo.create;
      IdCatAtribut:=0;
      IdAtrInst:=0;

    for indexTable:=0 to self.ListaTablas.Count-1 do
       begin
              RecordTabla:=Table(ListaTablas.Objects[indexTable]);


              for indexAtributo:=0 to RecordTabla.ListAtributos.Count-1 do
                 begin

                        RecordAtributo_Categoria:=TCategoria_Atributo.create;
                        RecordAtributo_Categoria.Set_idCategoria(RecordTabla.Get_IDCategoria);
                        RecordAtributo:=TAtributo(RecordTabla.ListAtributos.Objects[indexAtributo]);
                        RecordAtributo_Categoria.Set_idAtributo(RecordAtributo.Get_IDAtributo);
                        IdCatAtribut:=IdCatAtribut+1;
                        RecordAtributo_Categoria.Set_idCategoria_Atributo(IdCatAtribut);
                        ObjCategoria_Atributo.AddObject(RecordTabla.Get_NomCategoria,RecordAtributo_Categoria);
                         for indexInstancia:=0 to RecordAtributo.ListaInstancias.Count-1do
                            begin
                               RecordAtributo_Instancia:=TAtributo_Instancia.create;
                               RecordAtributo_Instancia.Set_atributoID(RecordAtributo.Get_IDAtributo);
                               RecordInstancia:=TInstancia(RecordAtributo.ListaInstancias.Objects[indexInstancia]);
                               RecordAtributo_Instancia.Set_valor(RecordInstancia.Get_ValorInstAtrb);
                               RecordAtributo_Instancia.Set_idInstancia(RecordInstancia.Get_IDInstancia);
                               IdAtrInst:=IdAtrInst+1;
                               RecordAtributo_Instancia.Set_idAtributo_Instancia(IdAtrInst);
                               ObjAtributo_Instancia.AddObject(RecordAtributo.Get_NomAtributo, RecordAtributo_Instancia);

                            end;

                 end;

       end;


   pruebCantAtr:= ObjCategoria_Atributo.Count;
    pruebCantIns:=ObjAtributo_Instancia.Count;

end;




procedure TForm1.Button1Click(Sender: TObject);
var
  CantTablas:integer;
  IndexForTablas, IndexForAtributos, IndexForInstancias:integer;
  NombreTablaActiva:string;
  NombreCampoActivo:string;
  CantAtributosTablaActiva:integer;
  CantInstanciasTablaActiva:integer;
  ContadorAtributos:integer;
  ContadorTablas:integer;
  TipoAtributo:string;
  Tabla:Table;
  StrPrimaryKey:string;
begin
  try
  DataModule1.SQLite3Connection1.DatabaseName:=Self.Ed_NombreBBDD.Text;
  DataModule1.SQLite3Connection1.Connected:=true;
  DataModule1.SQLite3Connection1.GetTableNames(LBox_Tablas.Items);
  cantTablas:=self.LBox_Tablas.Count;
  self.Ed_CantTablas.Text:=IntToStr(cantTablas);
  ContadorTablas:=1;
  for IndexForTablas:=0 to cantTablas-1 do
    begin
   ContadorAtributos:=1;
   self.LBox_Atributo.Clear;
   self.LBox_TipoAtributo.clear;
   NombreTablaActiva:=LBox_Tablas.Items.Strings[IndexForTablas];
   self.Ed_TablaAct.text:=NombreTablaActiva;
   DataModule1.SQLite3Connection1.GetFieldNames(NombreTablaActiva,LBox_Atributo.Items);
   CantAtributosTablaActiva:=self.LBox_Atributo.Count;
   self.Ed_CantAtributos.text:=IntToStr(CantAtributosTablaActiva);
   // Se crea la tabla con los parametros ID_Categoria y Nombre Categoria.
   Tabla:=Table.Create(ContadorTablas,NombreTablaActiva);
     for IndexForAtributos:=0 to CantAtributosTablaActiva-1 do
       begin
          self.ConnAtributo:=TAtributo.Create;
          self.ConnAtributo.Set_IDAtributo(ContadorAtributos);
          NombreCampoActivo:=LBox_Atributo.Items.Strings[IndexForAtributos];
          self.ConnAtributo.Set_NomAtributo(NombreCampoActivo);
          TipoAtributo:=DataModule1.Get_TipoAtributo(NombreTablaActiva,IndexForAtributos);
          DataModule1.Get_InstanciasDelAtributo(NombreTablaActiva,IndexForAtributos);
          self.LBox_TipoAtributo.Items.Add(TipoAtributo); // Escribir en ListBOX
          self.ConnAtributo.Set_TipoAtributo(TipoAtributo);// Setear propiedad
          /////////////////
          CantInstanciasTablaActiva:=DataModule1.CantidadDeInstancias;
          for IndexForInstancias:=0 to CantInstanciasTablaActiva-1 do
             begin
               Self.ConnInstancia:=TInstancia.Create(ContadorTablas,ContadorAtributos,IndexForInstancias);
               Self.ConnInstancia.Set_ValorInstAtrb(DataModule1.ValoresInstanciasDelAtributo[IndexForInstancias]);
           //    valor:=self.ConnInstancia.Get_ValorInstAtrb;
               self.ConnAtributo.ListaInstancias.AddObject(NombreCampoActivo,Self.ConnInstancia);
             end;
          ////////////
          Tabla.ListAtributos.AddObject(NombreTablaActiva,self.ConnAtributo);
          inc(ContadorAtributos);
          // Almacenar ConnAtributo en la lista de atributos de la clase tabla y el resto de propiedades necesarias de la clase tabla.
       end;
       Self.ListaTablas.AddObject(NombreTablaActiva,Tabla);
       ContadorAtributos:=1;
  //     showMessage('Procesar proxima tabla');
       inc(ContadorTablas);
     end;
  finally
  end;
  self.Button2.Enabled:=true;
  for IndexForTablas:=0 to cantTablas-1 do
    begin
         StrPrimaryKey:=Self.Buscar_PK(IndexForTablas);
         self.Buscar_TablaFK(StrPrimaryKey,IndexForTablas);
    end;
  ContadorTablas:=self.ListaCatCat.Count;
   self.llenarObjetos();
 end;

procedure TForm1.Button2Click(Sender: TObject);
begin

end;



end.

