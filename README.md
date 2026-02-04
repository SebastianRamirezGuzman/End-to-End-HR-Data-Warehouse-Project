# Data Warehouse & Analytics: Recursos Humanos (End-to-End)

## 📌 Descripción del Proyecto
Este proyecto consiste en la implementación de un Data Warehouse para el área de Recursos Humanos, abarcando desde la ingesta de datos transaccionales hasta la visualización de KPIs estratégicos. El objetivo es centralizar la información de empleados, nóminas y asistencias para facilitar la toma de decisiones basada en datos.

## 🛠️ Tecnologías Utilizadas
* **Base de Datos:** SQL Server (T-SQL).
* **Modelado de Datos:** Arquitectura Medallion (STG, ODS, BDS) y Modelo Copo de Nieve (Snowflake Schema).
* **Visualización:** Power BI.

## 🏗️ Arquitectura del Proyecto
El flujo de datos se divide en tres capas principales para asegurar la integridad y limpieza de la información:

1.  **Capa Staging (STG):** Ingesta inicial de los datos desde la base transaccional `RecursosHumanos` con trazabilidad de carga (`fecha_carga`).
2.  **Capa ODS (Operational Data Store):** Limpieza y tipado de datos utilizando `TRY_CAST` para asegurar la calidad de la información.
3.  **Capa Business Data Store (BDS):** Creación del modelo dimensional (Dimensiones y Hechos) listo para analítica. Incluye una tabla de dimensiones de tiempo (`dimFecha`) generada mediante un script dinámico.

## 📊 Modelo de Datos
Está organizada bajo una jerarquía lógica empresarial que refleja fielmente la estructura de una organización real. En lugar de tablas aisladas, utilicé un diseño interconectado donde los departamentos y puestos de trabajo alimentan directamente el perfil del colaborador, asegurando que cualquier cambio en la estructura organizacional se refleje automáticamente en los reportes de gestión

## 📈 Dashboard de Insights
El dashboard permite visualizar:
* **Control de Gastos:** Análisis del Costo de Nómina Total y tendencia mensual del Pago Bruto.
* **Gestión de Talento:** Distribución de salarios por empleado y área de trabajo.
* **Operatividad:** Resumen de asistencias (Presente, Ausente, Sick) filtrable por ubicación y fechas.
* **Insights de Negocio:** Se identifica que el área de Finanzas representa la mayor carga en la planilla, permitiendo a la gerencia evaluar la eficiencia de la inversión en capital humano por departamento
---
