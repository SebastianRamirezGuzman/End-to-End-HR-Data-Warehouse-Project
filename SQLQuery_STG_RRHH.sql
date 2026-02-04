create database DW_STG_RRHH
create database DW_ODS_RRHH
create database DW_BDS_RRHH

use dw_stg_rrhh


create table stg_Asistencia
(asistencia_id varchar(10) null,
empleado_id varchar (10) null, 
fecha varchar(30) null,
estado_asistencia varchar(50) null,
horas_trabajadas varchar(30) null,
hora_entrada varchar(20) null,
hora_salida varchar(20) null,
ruta_archivo varchar(100) null,
nombre_archivo varchar(50) NULL,
fecha_carga varchar(100)
)

insert into stg_Asistencia
select	a.asistencia_id,
		a.empleado_id, 
		a.fecha,
		a.estado_asistencia,
		a.horas_trabajadas,
		a.hora_entrada,
		a.hora_salida,
		a.ruta_archivo,
		a.nombre_archivo,
	   convert(varchar(20),getdate(),120) as fecha_carga
	   from 
	   RecursosHumanos.dbo.asistencia a
WHERE NOT EXISTS 
(
    SELECT 1 
    FROM stg_Asistencia b 
    WHERE b.asistencia_id COLLATE SQL_Latin1_General_CP1_CI_AS 
          = a.asistencia_id COLLATE SQL_Latin1_General_CP1_CI_AS
      AND b.fecha_carga = CONVERT(VARCHAR(20), GETDATE(), 120)
)

select * from stg_Asistencia

create table stg_departamentos 
(
[departamento_id] varchar(10),
[nombre_departamento] varchar(30), 
[ubicacion] varchar(50), 
[ruta_archivo] varchar(100), 
[nombre_archivo] varchar(50), 
[fecha_carga] varchar(100),
)

insert into stg_departamentos
select	departamento_id,
		nombre_departamento,
		ubicacion,
		ruta_archivo,
		nombre_archivo,
		convert(varchar(20),GETDATE(),120) as fecha_carga
from RecursosHumanos.dbo.departamentos

create table stg_empleados
(
empleado_id varchar(20),
nombre varchar(100),
apellido varchar(50),
fecha_nacimiento varchar(50),
fecha_ingreso varchar(50),
departamento_id varchar(30),
puesto_id varchar(30),
salario_base varchar(30),
correo varchar(100),
estado varchar(30),
ruta_archivo varchar(100),
nombre_archivo varchar(50),
fecha_carga varchar(100)
)

insert into stg_empleados
select	empleado_id,
		nombre, 
		apellido,
		fecha_nacimiento,
		fecha_ingreso, 
		departamento_id, 
		puesto_id, 
		salario_base,
		correo,
		estado, 
		ruta_archivo,
		nombre_archivo,
	   convert(varchar(20), getdate(),120) as fecha_carga
	   from RecursosHumanos.dbo.empleados

create table stg_nomina
(
nomina_id varchar(20),
empleado_id varchar(20),
periodo_pago varchar(50),
pago_bruto varchar(50),
impuesto varchar(30),
pago_neto varchar(30),
fecha_pago varchar(50),
metodo_pago varchar(50),
ruta_archivo varchar(100),
nombre_archivo varchar(50),
fecha_carga varchar(100)
)

INSERT INTO stg_nomina
select nomina_id,
	   empleado_id,
	   periodo_pago,
	   pago_bruto,
	   impuesto,
	   pago_neto,
	   fecha_pago,
	   metodo_pago,
	   ruta_archivo,
	   nombre_archivo,
	   convert(varchar(20),getdate(),120) as fecha_carga
	   from RecursosHumanos.dbo.nomina

create table stg_posiciones
(
puesto_id varchar(20),
nombre_puesto varchar(30),
nivel varchar(20),
ruta_archivo varchar(100),
nombre_archivo varchar(50),
fecha_carga varchar(100)
)

INSERT INTO stg_posiciones
select	puesto_id, 
		nombre_puesto, 
		nivel, 
		ruta_archivo,
		nombre_archivo,
		convert(varchar(20),getdate(),120) as fecha_carga
from RecursosHumanos.dbo.posiciones

