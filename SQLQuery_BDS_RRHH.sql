use DW_BDS_RRHH

create table dimDepartamento
(
DepartamentoKey int identity(1,1) primary key,
DepartamentoID nvarchar(5) not null,
NombreDepartamento varchar(100),
Ubicacion varchar(50),
RutaArchivo varchar(150),
NombreArchivo varchar(100)
)

insert into dimDepartamento
select  a.Departamento_ID,
		a.Nombre_Departamento,
		a.Ubicacion,
		a.Ruta_Archivo, 
		a.Nombre_Archivo
		from DW_ODS_RRHH.dbo.ods_Departamento a 

create table dimPosiciones 
(
PosicionesKey int identity(1,1) primary key,
PuestoID nvarchar(5) not null, 
NombrePuesto varchar(100) not null,
Nivel varchar(50), 
RutaArchivo varchar(150),
NombreArchivo varchar(100)
)

insert into dimPosiciones
select	a.Puesto_ID
		,a.Nombre_Puesto 
		,a.Nivel
		,a.Ruta_Archivo
		,a.Nombre_Archivo
		from DW_ODS_RRHH.dbo.ods_Posiciones a 

	

create table dimEmpleado
(
EmpleadoKey int identity(1,1) primary key, 
EmpleadoID nvarchar(5) not null,
NombreEmpleado varchar(50),
ApellidoEmpleado varchar(50),
FechaNacimiento date, 
FechaIngreso date, 
DepartamentoKey int foreign key references dimDepartamento not null,
PosicionesKey int foreign key references dimPosiciones not null, 
SalarioBase decimal(18,2) not null,
CorreoEmpleado varchar(100),
Estado varchar(30),
RutaArchivo varchar(150),
NombreArchivo varchar(100)
)


insert into dimEmpleado
select	a.Empleado_ID
		,a.Nombre_Empleado 
		,a.Apellido_Empleado
		,a.Fecha_Nacimiento
		,a.Fecha_Ingreso
		,d.DepartamentoKey 
		,p.PosicionesKey
		,a.Salario_Base
		,a.Correo_Empleado 
		,a.Estado
		,a.Ruta_Archivo
		,a.Nombre_Archivo
		from DW_ODS_RRHH.dbo.ods_Empleado a 
		inner join DW_BDS_RRHH.dbo.dimDepartamento d on a.Departamento_ID=d.DepartamentoID
		inner join DW_BDS_RRHH.dbo.dimPosiciones p on a.Puesto_ID=p.PuestoID


Create table dimFecha
(
FechaKey int primary key not null,
FechaCompleta date not null,
day int,
dayname varchar(20) not null,
month int not null,
MonthName varchar(20),
Year int, 
Quarter int,
NombreTrimestre varchar(20),
FinDeSemana bit not null
)

set language spanish;
DECLARE @FechaInicio DATE = '2020-01-01';
DECLARE @FechaFin DATE = '2025-12-31';

Declare @fechaActual date =  @fechaInicio; 

while @fechaActual <= @FechaFin
begin 
	insert into dimFecha(FechaKey,FechaCompleta,day,dayname,month,MonthName,Year,Quarter,NombreTrimestre,FinDeSemana)
	values(
			cast(FORMAT(@fechaActual,'yyyyMMdd') as int),
			@fechaActual,
			day(@fechaActual),
			datename(weekday,@fechaActual),
			MONTH(@fechaActual),
			datename(month,@fechaActual),
			Year(@fechaActual),
			DATEPART(quarter,@fechaActual),
			'T' + CAST(datepart(quarter,@fechaActual) as varchar(1)),
			case 
				when DATEPART(weekday,@fechaactual) in (1,7) then 1 
				else 0
			end
			);
			Set @fechaActual = DATEADD(day,1,@fechaActual); 
		end; 

create table fctAsistencia 
(
AsistenciaKey int identity(1,1) primary key not null,
EmpleadoKey int foreign key references dimEmpleado not null, 
Fechakey int foreign key references dimFecha(Fechakey) not null,
EstadoAsistencia varchar(30),
HorasTrabajadas decimal(10,2),
HorarioEntrada time, 
HorarioSalida time,
RutaArchivo varchar(150),
NombreArchivo varchar(100)
)

insert into fctAsistencia(EmpleadoKey,Fechakey,EstadoAsistencia,HorasTrabajadas,HorarioEntrada,HorarioSalida,RutaArchivo,NombreArchivo)
select	e.EmpleadoKey
		,f.FechaKey
		,a.Estado_ASistencia
		,a.Horas_Trabajadas
		,a.Hora_Entrada
		,a.Hora_Salida
		,a.Ruta_Archivo
		,a.Nombre_Archivo
		from DW_ODS_RRHH.dbo.ods_Asistencia a 
		inner join dimEmpleado e on a.Empleado_ID=e.EmpleadoID
		inner join dimFecha f on a.Fecha = f.Fechacompleta 

create table fctNomina
(
NominaKey int identity(1,1) primary key not null
,EmpleadoKey int foreign key references dimEmpleado not null 
,PeriodoPagokey int foreign key references dimFecha(Fechakey) not null
,PagoBruto decimal(18,2)
,Impuesto decimal(18,2)
,PagoNeto decimal(18,2)
,FechaPagoKey int foreign key references dimFecha(Fechakey) not null
,MetodoPago varchar(50)
,RutaArchivo varchar(150)
,NombreArchivo varchar(100)	
)

insert into fctNomina(EmpleadoKey,PeriodoPagokey, PagoBruto, Impuesto, PagoNeto, FechaPagoKey, MetodoPago, RutaArchivo, NombreArchivo)
select	 e.EmpleadoKey
		,p.FechaKey 
		,a.Pago_Bruto
		,a.Impuesto 
		,a.Pago_Neto 
		,f.FechaKey 
		,a.Metodo_Pago 
		,a.Ruta_Archivo 
		,a.Nombre_Archivo
		from DW_ODS_RRHH.dbo.ods_Nomina a 
		inner join dimEmpleado e on a.Empleado_ID=e.EmpleadoID
		inner join dimFecha p on a.Periodo_Pago=p.FechaCompleta
		inner join dimFecha f on a.Fecha_Pago=f.FechaCompleta
