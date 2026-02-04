
-- Creamos la Base de datos ODS

use DW_ODS_RRHH

select	try_cast(a.asistencia_id as int) Asistencia_ID,
		try_cast(a.empleado_id as int) Empleado_ID, 
		try_cast(a.fecha as datetime) as Fecha,
		a.estado_asistencia as Estado_ASistencia,
		try_cast(a.horas_trabajadas as decimal(10,2)) Horas_Trabajadas,
		try_cast(a.hora_entrada as time) Hora_Entrada,
		try_cast(a.hora_salida as time) Hora_Salida,
		a.ruta_archivo Ruta_Archivo,
		a.nombre_archivo Nombre_Archivo,
		cast(a.fecha_carga as datetime) Fecha_Carga
		into ods_Asistencia
		from RecursosHumanos.dbo.asistencia a 

select	try_cast(a.departamento_id as int) Departamento_ID,
		a.nombre_departamento Nombre_Departamento, 
		a.ubicacion Ubicacion,
		a.ruta_archivo Ruta_Archivo,
		a.nombre_archivo Nombre_Archivo,
		try_cast(a.fecha_carga as datetime) Fecha_Carga
		into ods_Departamento
		from RecursosHumanos.dbo.departamentos a 

select	TRY_CAST(a.empleado_id as int) Empleado_ID,
		a.nombre Nombre_Empleado,
		a.apellido Apellido_Empleado,
		try_cast(a.fecha_nacimiento as date) Fecha_Nacimiento,
		try_cast(a.fecha_ingreso as date) Fecha_Ingreso,
		try_cast(a.departamento_id as int) Departamento_ID,
		try_cast(a.puesto_id as int) Puesto_ID,
		try_cast(a.salario_base as decimal(18,2)) Salario_Base,
		a.correo Correo_Empleado,
		a.estado Estado,
		a.ruta_archivo Ruta_Archivo,
		a.nombre_archivo Nombre_Archivo,
		try_cast(a.fecha_carga as datetime) as Fecha_Carga
		into ods_Empleado
		from RecursosHumanos.dbo.empleados a 


select try_cast(a.nomina_id as int) as Nomina_ID ,
	   try_cast(a.empleado_id as int) Empleado_ID,
	   try_cast(a.periodo_pago as date) Periodo_Pago,
	   try_cast(a.pago_bruto as decimal(18,2)) Pago_Bruto,
	   try_cast(a.impuesto as decimal(18,2)) Impuesto,
	   try_cast(a.pago_neto as decimal(18,2)) Pago_Neto,
	   try_cast(a.fecha_pago as date) Fecha_Pago,
	   a.metodo_pago Metodo_Pago,
	   a.ruta_archivo Ruta_Archivo,
	   a.nombre_archivo Nombre_Archivo,
	   cast(fecha_carga as datetime) as Fecha_Carga 
	   into ods_Nomina
	   from RecursosHumanos.dbo.nomina a 

	
select	try_cast(a.puesto_id as int) as Puesto_ID,
		a.nombre_puesto Nombre_Puesto,
		a.nivel Nivel,
		a.ruta_archivo Ruta_Archivo,
		a.nombre_archivo Nombre_Archivo,
		try_Cast(a.fecha_carga as datetime) as Fecha_Carga
		into ods_Posiciones
		from RecursosHumanos.dbo.posiciones a 

